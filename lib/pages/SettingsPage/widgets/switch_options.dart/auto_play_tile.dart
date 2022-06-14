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
    return SwitchListTile(
      value: UserPreferences().shouldAutoplay,
      onChanged: (bool value) {
        UserPreferences().shouldAutoplay = value;
        setState(() {});
      },
      title: const Text('Autoplay Videos'),
      secondary: Icon(
        UserPreferences().shouldAutoplay
            ? Icons.play_arrow
            : Icons.play_disabled,
      ),
    );
  }
}
