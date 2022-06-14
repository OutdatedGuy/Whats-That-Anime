// Flutter Packages
import 'package:flutter/material.dart';

// Data Models
import 'package:whats_that_anime/models/user_preferences.dart';

class LoopTile extends StatefulWidget {
  const LoopTile({
    Key? key,
  }) : super(key: key);

  @override
  State<LoopTile> createState() => _LoopTileState();
}

class _LoopTileState extends State<LoopTile> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: UserPreferences().shouldLoop,
      onChanged: (bool value) {
        UserPreferences().shouldLoop = value;
        setState(() {});
      },
      title: const Text('Loop Videos'),
      secondary: const Icon(Icons.loop),
    );
  }
}
