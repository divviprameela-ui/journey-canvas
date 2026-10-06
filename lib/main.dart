import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/main_shell.dart';

void main() {
  runApp(const JourneyCanvasApp());
}

class JourneyCanvasApp extends StatelessWidget {
  const JourneyCanvasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JourneyCanvas — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainShell(),
    );
  }
}
