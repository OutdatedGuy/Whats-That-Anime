// Flutter Packages
import 'package:flutter/material.dart';

// Data Models
import 'package:whats_that_anime/models/user_preferences.dart';

class ChildFilterTile extends StatefulWidget {
  const ChildFilterTile({
    Key? key,
  }) : super(key: key);

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
          bool confirm = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Child Filter'),
                    content: const Text(
                      'Are you sure you want to disable the child filter?',
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('YES'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      TextButton(
                        child: const Text('NO'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
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
          key: ValueKey('childfilter-switch: $isChecked'),
        ),
      ),
    );
  }
}
