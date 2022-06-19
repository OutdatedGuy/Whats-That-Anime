// Flutter Packages
import 'package:flutter/material.dart';

// Firebase Packages
import 'package:firebase_auth/firebase_auth.dart';

// Pages
import 'package:whats_that_anime/pages/HomePage/home_page.dart';
import 'package:whats_that_anime/pages/HistoryPage/history_page.dart';
import 'package:whats_that_anime/pages/SettingsPage/settings_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          const HomePage(),
          HistoryPage(key: Key('history: $uid')),
          SettingsPage(key: Key('settings: $uid')),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.amber[800],
          selectedIconTheme: const IconThemeData(size: 30),
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
