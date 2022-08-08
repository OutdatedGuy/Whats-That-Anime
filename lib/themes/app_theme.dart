// Copyright (C) 2022 OutdatedGuy
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Themes
import 'swatch.dart';

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
