// Flutter Packages
import 'package:flutter/material.dart';

// Third Party Packages
import 'package:responsive_navigation/responsive_navigation.dart';

// Pages
import 'package:whats_that_anime/pages/HomePage/home_page.dart';
import 'package:whats_that_anime/pages/HistoryPage/history_page.dart';
import 'package:whats_that_anime/pages/SettingsPage/settings_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.uid});

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
