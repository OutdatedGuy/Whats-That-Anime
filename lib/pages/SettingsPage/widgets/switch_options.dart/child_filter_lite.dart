// Flutter Packages
import 'package:flutter/material.dart';

// Data Models
import 'package:whats_that_anime/models/user_preferences.dart';

// Widgets
import 'package:whats_that_anime/widgets/adaptive_action.dart';

class ChildFilterTile extends StatefulWidget {
  const ChildFilterTile({super.key});

  @override
  State<ChildFilterTile> createState() => _ChildFilterTileState();
}

class _ChildFilterTileState extends State<ChildFilterTile> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = UserPreferences().childFilterEnabled;

    return SwitchListTile(
      value: isChecked,
      onChanged: (bool value) async {
        if (value) {
          UserPreferences().childFilterEnabled = value;
        } else {
          bool confirm =
              await showAdaptiveDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog.adaptive(
                    title: const Text('Child Filter'),
                    content: const Text(
                      'Are you sure you want to disable the child filter?',
                    ),
                    actions: <Widget>[
                      AdaptiveAction(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('YES'),
                      ),
                      AdaptiveAction(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('NO'),
                      ),
                    ],
                  );
                },
              ) ??
              true;
          UserPreferences().childFilterEnabled = confirm;
        }
        setState(() {});
      },
      title: const Text('Child Filter'),
      secondary: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Icon(
          isChecked ? Icons.no_adult_content : Icons.warning,
          key: ValueKey('child-filter-switch: $isChecked'),
        ),
      ),
    );
  }
}
