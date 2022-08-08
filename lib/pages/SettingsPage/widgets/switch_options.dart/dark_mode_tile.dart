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

// Data Models
import 'package:whats_that_anime/models/user_preferences.dart';

class DarkModeTile extends StatefulWidget {
  const DarkModeTile({Key? key}) : super(key: key);

  @override
  State<DarkModeTile> createState() => _DarkModeTileState();
}

class _DarkModeTileState extends State<DarkModeTile> {
  @override
  Widget build(BuildContext context) {
    final bool isChecked = UserPreferences().isDarkMode;

    return SwitchListTile(
      value: isChecked,
      onChanged: (bool value) {
        UserPreferences().theme = value ? ThemeMode.dark : ThemeMode.light;
        setState(() {});
      },
      title: const Text('Dark Mode'),
      secondary: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: RotationTransition(turns: animation, child: child),
          );
        },
        child: Icon(
          isChecked ? Icons.dark_mode : Icons.light_mode,
          key: ValueKey('theme-switch: $isChecked'),
        ),
      ),
    );
  }
}
