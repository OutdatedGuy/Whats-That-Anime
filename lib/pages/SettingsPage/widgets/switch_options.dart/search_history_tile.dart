// Flutter Packages
import 'package:flutter/material.dart';

// Data Models
import 'package:whats_that_anime/models/user_preferences.dart';

class SearchHistoryTile extends StatefulWidget {
  const SearchHistoryTile({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchHistoryTile> createState() => _SearchHistoryTileState();
}

class _SearchHistoryTileState extends State<SearchHistoryTile> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = UserPreferences().searchHistoryEnabled;

    return SwitchListTile(
      value: isChecked,
      onChanged: (bool value) {
        UserPreferences().searchHistoryEnabled = value;
        setState(() {});
      },
      title: const Text('Search History'),
      secondary: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
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
          isChecked ? Icons.history : Icons.history_toggle_off,
          key: ValueKey('search-history-switch: $isChecked'),
        ),
      ),
    );
  }
}
