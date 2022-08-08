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

class AutoPlayTile extends StatefulWidget {
  const AutoPlayTile({
    Key? key,
  }) : super(key: key);

  @override
  State<AutoPlayTile> createState() => _AutoPlayTileState();
}

class _AutoPlayTileState extends State<AutoPlayTile> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = UserPreferences().shouldAutoplay;

    return SwitchListTile(
      value: isChecked,
      onChanged: (bool value) {
        UserPreferences().shouldAutoplay = value;
        setState(() {});
      },
      title: const Text('Autoplay Videos'),
      secondary: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          isChecked ? Icons.play_arrow : Icons.play_disabled,
          key: ValueKey('autoplay-switch: $isChecked'),
        ),
      ),
    );
  }
}
