// Flutter Packages
import 'package:flutter/material.dart';

// Themes
import 'swatchs.dart';

/// Returns a customized [ThemeData] object for the given [Brightness].
ThemeData appTheme(Brightness mode) {
  return ThemeData(
    brightness: mode,
    useMaterial3: true,
    primarySwatch:
        mode == Brightness.light ? lightThemeSwatch : darkThemeSwatch,
    appBarTheme: AppBarTheme(
      backgroundColor: mode == Brightness.light ? lightThemeSwatch : null,
      foregroundColor: Colors.white,
    ),
  );
}
