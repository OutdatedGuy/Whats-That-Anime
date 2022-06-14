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
    return SwitchListTile(
      value: UserPreferences().searchHistoryEnabled,
      onChanged: (bool value) {
        UserPreferences().searchHistoryEnabled = value;
        setState(() {});
      },
      title: const Text('Search History'),
      secondary: const Icon(Icons.manage_history),
    );
  }
}
