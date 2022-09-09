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

// Third Party Packages
import 'package:responsive_navigation/responsive_navigation.dart';

// Pages
import 'package:whats_that_anime/pages/HomePage/home_page.dart';
import 'package:whats_that_anime/pages/HistoryPage/history_page.dart';
import 'package:whats_that_anime/pages/SettingsPage/settings_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    this.uid,
  }) : super(key: key);

  final String? uid;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ResponsiveNav(
      items: [
        NavItem(icon: const Icon(Icons.home), label: 'Home'),
        NavItem(icon: const Icon(Icons.history), label: 'History'),
        NavItem(icon: const Icon(Icons.settings), label: 'Settings'),
      ],
      onNavigationChanged: (int index) {
        setState(() => _currentIndex = index);
      },
      navStyle: NavStyle(
        verticalDivider: VerticalDivider(
          color: Theme.of(context).colorScheme.secondary,
          thickness: 1,
          width: 1,
        ),
        indicatorColor: Colors.amber[800],
      ),
      child: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          const HomePage(),
          HistoryPage(key: Key('history: ${widget.uid}')),
          SettingsPage(key: Key('settings: ${widget.uid}')),
        ],
      ),
    );
  }
}
