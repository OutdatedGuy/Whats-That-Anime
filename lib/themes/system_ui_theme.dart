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
