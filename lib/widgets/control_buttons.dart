import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/stopwatch_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class ControlButtons extends ConsumerWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canStart = ref.watch(canStartProvider);
    final canPause = ref.watch(canPauseProvider);
    final canReset = ref.watch(canResetProvider);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StopwatchButton(
          onPressed: canStart ? () => ref.read(stopwatchProvider.notifier).start() : null,
          color: AppColors.startButtonColor,
          icon: Icons.play_arrow,
          label: 'INICIAR',
        ),
        _StopwatchButton(
          onPressed: canPause ? () => ref.read(stopwatchProvider.notifier).pause() : null,
          color: AppColors.pauseButtonColor,
          icon: Icons.pause,
          label: 'PAUSAR',
        ),
        _StopwatchButton(
          onPressed: canReset ? () => ref.read(stopwatchProvider.notifier).reset() : null,
          color: AppColors.resetButtonColor,
          icon: Icons.stop,
          label: 'RESETEAR',
        ),
      ],
    );
  }
}

class _StopwatchButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;
  final IconData icon;
  final String label;

  const _StopwatchButton({
    required this.onPressed,
    required this.color,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: isEnabled ? [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ] : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(35),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: isEnabled ? color : AppColors.buttonDisabled,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isEnabled ? color.withOpacity(0.3) : AppColors.buttonDisabled.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  icon,
                  color: AppColors.textPrimary,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.buttonText.copyWith(
            fontSize: 12,
            color: isEnabled ? AppColors.textPrimary : AppColors.buttonDisabled,
          ),
        ),
      ],
    );
  }
}
