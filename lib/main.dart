import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'screens/shell/main_shell.dart';

void main() => runApp(const MarsExplorerApp());

class MarsExplorerApp extends StatelessWidget {
  const MarsExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mars Explorer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const MainShell(),
    );
  }
}
