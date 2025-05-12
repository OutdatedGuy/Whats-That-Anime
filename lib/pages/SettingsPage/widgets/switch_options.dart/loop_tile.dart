// Flutter Packages
import 'package:flutter/material.dart';

// Data Models
import 'package:whats_that_anime/models/user_preferences.dart';

class LoopTile extends StatefulWidget {
  const LoopTile({super.key});

  @override
  State<LoopTile> createState() => _LoopTileState();
}

class _LoopTileState extends State<LoopTile> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = UserPreferences().shouldLoop;

    return SwitchListTile(
      value: isChecked,
      onChanged: (bool value) {
        UserPreferences().shouldLoop = value;
        setState(() {});
      },
      title: const Text('Loop Videos'),
      secondary: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return RotationTransition(
            turns: animation,
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
          isChecked ? Icons.loop : Icons.looks_one_outlined,
          key: ValueKey('loop-switch: $isChecked'),
        ),
      ),
    );
  }
}
