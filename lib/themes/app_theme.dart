// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Themes
import 'swatchs.dart';

/// Returns a customized [ThemeData] object for the given [Brightness].
ThemeData appTheme(Brightness mode) {
  bool isLight = mode == Brightness.light;

  return ThemeData(
    brightness: mode,
    useMaterial3: true,
    primarySwatch: isLight ? lightThemeSwatch : darkThemeSwatch,
    appBarTheme: AppBarTheme(
      backgroundColor: isLight ? lightThemeSwatch : null,
      foregroundColor: Colors.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemStatusBarContrastEnforced: false,
      ),
    ),
  );
}
