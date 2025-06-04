import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_vision/app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // TODO: Open Hive boxes if any are used at startup
  // Example: await Hive.openBox('settings');

  runApp(
    ProviderScope(
      child: ProjectVisionApp(),
    ),
  );
}
