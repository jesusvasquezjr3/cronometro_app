import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/stopwatch_provider.dart';
import '../models/stopwatch_state.dart'; // ← AGREGADO
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class TimeDisplay extends ConsumerWidget {
  const TimeDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedTime = ref.watch(formattedTimeProvider);
    final status = ref.watch(stopwatchStatusProvider);

    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            formattedTime,
            style: AppTextStyles.timeDisplay.copyWith(
              color: _getTimeColor(status),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _getStatusColor(status),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _getStatusText(status),
              style: AppTextStyles.buttonText.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTimeColor(StopwatchStatus status) {
    switch (status) {
      case StopwatchStatus.running:
        return AppColors.startButtonColor;
      case StopwatchStatus.paused:
        return AppColors.pauseButtonColor;
      case StopwatchStatus.initial:
        return AppColors.textPrimary;
    }
  }

  Color _getStatusColor(StopwatchStatus status) {
    switch (status) {
      case StopwatchStatus.running:
        return AppColors.startButtonColor.withOpacity(0.2);
      case StopwatchStatus.paused:
        return AppColors.pauseButtonColor.withOpacity(0.2);
      case StopwatchStatus.initial:
        return AppColors.primaryBlue.withOpacity(0.3);
    }
  }

  String _getStatusText(StopwatchStatus status) {
    switch (status) {
      case StopwatchStatus.running:
        return 'EN EJECUCIÓN';
      case StopwatchStatus.paused:
        return 'PAUSADO';
      case StopwatchStatus.initial:
        return 'LISTO';
    }
  }
}
