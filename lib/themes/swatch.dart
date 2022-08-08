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

/// Primary swatch [MaterialColor] for light theme.
MaterialColor lightThemeSwatch = MaterialColor(
  Colors.deepPurple.value,
  const <int, Color>{
    50: Color.fromRGBO(103, 58, 183, 0.1),
    100: Color.fromRGBO(103, 58, 183, 0.2),
    200: Color.fromRGBO(103, 58, 183, 0.3),
    300: Color.fromRGBO(103, 58, 183, 0.4),
    400: Color.fromRGBO(103, 58, 183, 0.5),
    500: Color.fromRGBO(103, 58, 183, 0.6),
    600: Color.fromRGBO(103, 58, 183, 0.7),
    700: Color.fromRGBO(103, 58, 183, 0.8),
    800: Color.fromRGBO(103, 58, 183, 0.9),
    900: Color.fromRGBO(103, 58, 183, 1),
  },
);

/// Primary swatch [MaterialColor] for dark theme.
MaterialColor darkThemeSwatch = MaterialColor(
  Colors.purpleAccent.value,
  const <int, Color>{
    50: Color.fromRGBO(224, 64, 251, 0.1),
    100: Color.fromRGBO(224, 64, 251, 0.2),
    200: Color.fromRGBO(224, 64, 251, 0.3),
    300: Color.fromRGBO(224, 64, 251, 0.4),
    400: Color.fromRGBO(224, 64, 251, 0.5),
    500: Color.fromRGBO(224, 64, 251, 0.6),
    600: Color.fromRGBO(224, 64, 251, 0.7),
    700: Color.fromRGBO(224, 64, 251, 0.8),
    800: Color.fromRGBO(224, 64, 251, 0.9),
    900: Color.fromRGBO(224, 64, 251, 1),
  },
);
