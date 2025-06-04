import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_vision/screens/home_screen.dart'; // Placeholder
import 'package:macos_ui/macos_ui.dart'; // For macOS look and feel

class ProjectVisionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MacosApp for macOS native look and feel
    return MacosApp(
      title: 'ProjectVision',
      theme: MacosThemeData.light(), // Example theme
      darkTheme: MacosThemeData.dark(), // Example dark theme
      themeMode: ThemeMode.system, // Follow system theme settings
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // Initially shows the HomeScreen
      // TODO: Add routes from config/routes.dart
    );
  }
}
