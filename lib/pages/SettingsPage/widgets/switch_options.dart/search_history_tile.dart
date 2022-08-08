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

class SearchHistoryTile extends StatefulWidget {
  const SearchHistoryTile({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchHistoryTile> createState() => _SearchHistoryTileState();
}

class _SearchHistoryTileState extends State<SearchHistoryTile> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = UserPreferences().searchHistoryEnabled;

    return SwitchListTile(
      value: isChecked,
      onChanged: (bool value) {
        UserPreferences().searchHistoryEnabled = value;
        setState(() {});
      },
      title: const Text('Search History'),
      secondary: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: const Offset(0, 0),
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: Icon(
          isChecked ? Icons.history : Icons.history_toggle_off,
          key: ValueKey('search-history-switch: $isChecked'),
        ),
      ),
    );
  }
}
