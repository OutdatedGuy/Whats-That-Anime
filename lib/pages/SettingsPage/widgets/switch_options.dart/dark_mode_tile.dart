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
    return SwitchListTile(
      value: UserPreferences().isDarkMode,
      onChanged: (bool value) {
        UserPreferences().theme = value ? ThemeMode.dark : ThemeMode.light;
        setState(() {});
      },
      title: const Text('Dark Mode'),
      secondary: Icon(
        UserPreferences().isDarkMode ? Icons.dark_mode : Icons.light_mode,
      ),
    );
  }
}
