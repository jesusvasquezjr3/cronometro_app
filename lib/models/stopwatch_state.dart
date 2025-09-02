import 'package:flutter/foundation.dart';

enum StopwatchStatus {
  initial,
  running,
  paused,
}

@immutable
class StopwatchState {
  final Duration elapsed;
  final StopwatchStatus status;
  final DateTime? startTime;

  const StopwatchState({
    required this.elapsed,
    required this.status,
    this.startTime,
  });

  const StopwatchState.initial()
      : elapsed = Duration.zero,
        status = StopwatchStatus.initial,
        startTime = null;

  StopwatchState copyWith({
    Duration? elapsed,
    StopwatchStatus? status,
    DateTime? startTime,
  }) {
    return StopwatchState(
      elapsed: elapsed ?? this.elapsed,
      status: status ?? this.status,
      startTime: startTime ?? this.startTime,
    );
  }

  bool get isRunning => status == StopwatchStatus.running;
  bool get isPaused => status == StopwatchStatus.paused;
  bool get isInitial => status == StopwatchStatus.initial;
  bool get canStart => status != StopwatchStatus.running;
  bool get canPause => status == StopwatchStatus.running;
  bool get canReset => status != StopwatchStatus.initial;

  String get formattedTime {
    final minutes = elapsed.inMinutes;
    final seconds = elapsed.inSeconds % 60;
    final milliseconds = (elapsed.inMilliseconds % 1000) ~/ 10;
    
    return '${minutes.toString().padLeft(2, '0')}:'
           '${seconds.toString().padLeft(2, '0')}.'
           '${milliseconds.toString().padLeft(2, '0')}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StopwatchState &&
        other.elapsed == elapsed &&
        other.status == status &&
        other.startTime == startTime;
  }

  @override
  int get hashCode => Object.hash(elapsed, status, startTime);

  @override
  String toString() {
    return 'StopwatchState(elapsed: $elapsed, status: $status, startTime: $startTime)';
  }
}
