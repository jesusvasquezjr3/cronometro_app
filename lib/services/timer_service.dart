import 'dart:async';

class TimerService {
  static const Duration _tickInterval = Duration(milliseconds: 10);
  
  Timer? _timer;
  
  Stream<void> createTickStream() {
    return Stream.periodic(_tickInterval);
  }
  
  void startTimer(VoidCallback onTick) {
    _timer?.cancel();
    _timer = Timer.periodic(_tickInterval, (_) => onTick());
  }
  
  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
  
  void dispose() {
    stopTimer();
  }
  
  bool get isActive => _timer?.isActive ?? false;
}

typedef VoidCallback = void Function();
