import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.accent,
      onPrimary: AppColors.onAccent,
      surface: AppColors.background,
      onSurface: AppColors.text,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: ThemeData.dark().textTheme.apply(
            bodyColor: AppColors.text,
            displayColor: AppColors.text,
          ),
      sliderTheme: const SliderThemeData(
        trackHeight: 4,
        activeTrackColor: AppColors.accent,
        inactiveTrackColor: AppColors.track,
        thumbColor: AppColors.accent,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.text,
        contentTextStyle: const TextStyle(
          color: AppColors.onAccent,
          fontWeight: FontWeight.w700,
        ),
        actionTextColor: AppColors.accent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

/// Estilos de texto recorrentes do wireframe.
abstract final class AppText {
  /// Rótulo em caixa alta e espaçado (ex.: "MARS EXPLORER").
  static const eyebrow = TextStyle(
    fontFamily: 'monospace',
    fontSize: 11,
    letterSpacing: 3,
    color: AppColors.textMuted,
  );

  /// Texto técnico pequeno (códigos de câmera, parâmetros da API).
  static const mono = TextStyle(
    fontFamily: 'monospace',
    fontSize: 11,
    color: AppColors.textMuted,
  );

  static const screenTitle = TextStyle(
    fontSize: 34,
    height: 1.05,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
  );

  static const sectionTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static const body = TextStyle(fontSize: 14, color: AppColors.textMuted);
}
