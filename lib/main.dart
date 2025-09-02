import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/stopwatch_screen.dart';
import 'constants/app_colors.dart';

void main() {
  runApp(const ProviderScope(child: CronometroApp()));
}

class CronometroApp extends StatelessWidget {
  const CronometroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cronómetro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        useMaterial3: true,
      ),
      home: const StopwatchScreen(),
    );
  }
}
