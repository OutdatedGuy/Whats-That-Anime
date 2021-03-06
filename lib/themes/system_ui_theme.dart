// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle systemUITheme({
  required BuildContext context,
  required ThemeMode themeMode,
}) {
  bool isLight = themeMode == ThemeMode.light;
  Brightness brightness = isLight ? Brightness.dark : Brightness.light;

  return SystemUiOverlayStyle(
    // Applied when appBar is not shown.
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: brightness,
    systemStatusBarContrastEnforced: false,

    systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: brightness,
    systemNavigationBarContrastEnforced: false,
  );
}
