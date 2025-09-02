import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/time_display.dart';
import '../widgets/control_buttons.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class StopwatchScreen extends ConsumerWidget {
  const StopwatchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundColor,
              AppColors.primaryBlue,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                const SizedBox(height: 20),
                Text(
                  'Cronómetro',
                  style: AppTextStyles.titleText,
                ),
                Text(
                  'Precisión de centésimas',
                  style: AppTextStyles.subtitleText,
                ),
                
                // Espaciador flexible
                const Spacer(flex: 2),
                
                // Display del tiempo
                const TimeDisplay(),
                
                // Espaciador flexible
                const Spacer(flex: 3),
                
                // Botones de control
                const ControlButtons(),
                
                // Espaciador inferior
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
