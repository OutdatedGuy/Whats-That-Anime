// Flutter Packages
import 'package:flutter/material.dart';

// Data Models
import 'package:whats_that_anime/models/user_preferences.dart';

class AutoPlayTile extends StatefulWidget {
  const AutoPlayTile({super.key});

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
