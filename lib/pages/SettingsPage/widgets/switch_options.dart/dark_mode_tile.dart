// Flutter Packages
import 'package:flutter/material.dart';

// Data Models
import 'package:whats_that_anime/models/user_preferences.dart';

class DarkModeTile extends StatefulWidget {
  const DarkModeTile({super.key});

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
