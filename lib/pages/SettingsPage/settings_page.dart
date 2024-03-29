// Copyright (C) 2022 OutdatedGuy
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// Flutter Packages
import 'package:flutter/material.dart';

// Third Party Packages
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

// Pages
import 'package:whats_that_anime/pages/MyLicensePage/my_license_page.dart';

// Data Models
import 'package:whats_that_anime/models/user_preferences.dart';

// Widgets
import 'widgets/switch_options.dart/dark_mode_tile.dart';
import 'widgets/switch_options.dart/search_history_tile.dart';
import 'widgets/switch_options.dart/auto_play_tile.dart';
import 'widgets/switch_options.dart/loop_tile.dart';
import 'widgets/switch_options.dart/child_filter_lite.dart';

// Functions
import 'functions/style_loading.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const DarkModeTile(),
            const SearchHistoryTile(),
            const AutoPlayTile(),
            const LoopTile(),
            const ChildFilterTile(),
            ListTile(
              title: const Text(
                'Clear Search History',
                style: TextStyle(color: Colors.red),
              ),
              leading: const Icon(Icons.delete, color: Colors.red),
              onTap: () {
                showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Clear Search History'),
                      content: const Text(
                        'This will clear your search history. Are you sure?\n\nThis action cannot be undone.',
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('YES'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                        TextButton(
                          child: const Text('NO'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                      ],
                    );
                  },
                ).then((bool? value) async {
                  if (value == true) {
                    styleLoading();
                    EasyLoading.show(status: 'Clearing search history...');

                    try {
                      await UserPreferences.clearSearchHistory();
                    } on Exception {
                      EasyLoading.showError('Error clearing search history.');
                    } finally {
                      EasyLoading.dismiss();
                    }
                  }
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings_rounded),
              title: const Text('About Developer'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                final Uri launchUri = Uri(
                  scheme: 'https',
                  host: 'OutdatedGuy.rocks',
                );
                launchUrl(launchUri, mode: LaunchMode.externalApplication);
              },
            ),
            ListTile(
              leading: const Icon(Icons.api_rounded),
              title: const Text('API Creator'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                final Uri launchUri = Uri(
                  scheme: 'https',
                  host: 'github.com',
                  path: 'soruly',
                );
                launchUrl(launchUri, mode: LaunchMode.externalApplication);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bug_report),
              title: const Text('Report a bug'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                final Uri launchUri = Uri(
                  scheme: 'https',
                  host: 'github.com',
                  path: 'OutdatedGuy/Whats-That-Anime/issues/new',
                  queryParameters: {
                    'assignees': '',
                    'labels': '',
                    'template': 'bug_report.md',
                    'title': '',
                  },
                );
                launchUrl(launchUri, mode: LaunchMode.externalApplication);
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text('Contribute to the project'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                final Uri launchUri = Uri(
                  scheme: 'https',
                  host: 'github.com',
                  path: 'OutdatedGuy/Whats-That-Anime/discussions',
                );
                launchUrl(launchUri, mode: LaunchMode.externalApplication);
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_fire_department_rounded),
              title: const Text('Request a feature'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                final Uri launchUri = Uri(
                  scheme: 'https',
                  host: 'github.com',
                  path: 'OutdatedGuy/Whats-That-Anime/issues/new',
                  queryParameters: {
                    'assignees': '',
                    'labels': '',
                    'template': 'feature_request.md',
                    'title': '',
                  },
                );
                launchUrl(launchUri, mode: LaunchMode.externalApplication);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('App Info & Licenses'),
              trailing: const Icon(Icons.arrow_forward),
              textColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const MyLicensePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
