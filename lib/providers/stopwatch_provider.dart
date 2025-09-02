import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/stopwatch_state.dart';
import '../services/timer_service.dart';

class StopwatchNotifier extends StateNotifier<StopwatchState> {
  StopwatchNotifier() : super(const StopwatchState.initial());

  final TimerService _timerService = TimerService();
  DateTime? _baseTime;

  void start() {
    if (state.isRunning) return;

    _baseTime = DateTime.now().subtract(state.elapsed);

    state = state.copyWith(
      status: StopwatchStatus.running,
      startTime: DateTime.now(),
    );

    _timerService.startTimer(_updateElapsedTime);
  }

  void pause() {
    if (!state.isRunning) return;

    _timerService.stopTimer();

    state = state.copyWith(
      status: StopwatchStatus.paused,
    );
  }

  void reset() {
    _timerService.stopTimer();
    _baseTime = null;

    state = const StopwatchState.initial();
  }

  void _updateElapsedTime() {
    if (_baseTime != null && state.isRunning) {
      final newElapsed = DateTime.now().difference(_baseTime!);
      state = state.copyWith(elapsed: newElapsed);
    }
  }

  @override
  void dispose() {
    _timerService.dispose();
    super.dispose();
  }
}

// Provider principal del cronómetro
final stopwatchProvider =
    StateNotifierProvider<StopwatchNotifier, StopwatchState>(
  (ref) => StopwatchNotifier(),
);

// Providers derivados para casos específicos
final formattedTimeProvider = Provider<String>((ref) {
  final stopwatch = ref.watch(stopwatchProvider);
  return stopwatch.formattedTime;
});

final stopwatchStatusProvider = Provider<StopwatchStatus>((ref) {
  final stopwatch = ref.watch(stopwatchProvider);
  return stopwatch.status;
});

final canStartProvider = Provider<bool>((ref) {
  final stopwatch = ref.watch(stopwatchProvider);
  return stopwatch.canStart;
});

final canPauseProvider = Provider<bool>((ref) {
  final stopwatch = ref.watch(stopwatchProvider);
  return stopwatch.canPause;
});

final canResetProvider = Provider<bool>((ref) {
  final stopwatch = ref.watch(stopwatchProvider);
  return stopwatch.canReset;
});
