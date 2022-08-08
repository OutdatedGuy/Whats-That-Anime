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

// Dart Packages
import 'package:http/http.dart' as http;
import 'dart:convert';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';
import 'package:whats_that_anime/models/user_preferences.dart';

Future<List<AnimeInfo>> getImageSearch({
  required String imageURL,
  int retryNum = 0,
}) async {
  Uri searchUri = Uri(
    scheme: 'https',
    host: 'api.trace.moe',
    path: 'search',
    queryParameters: {
      'anilistInfo': 'true',
      'cutBorders': 'true',
      'url': imageURL,
    },
  );
  final response = await http.get(searchUri, headers: {
    'Content-Type': 'application/json',
  });
  final jsonResponse = json.decode(response.body);

  String error = jsonResponse['error'] as String;
  if (error == 'Concurrency limit exceeded' && retryNum < 2) {
    await Future.delayed(const Duration(seconds: 5));
    return getImageSearch(imageURL: imageURL, retryNum: retryNum + 1);
  }
  if (response.statusCode != 200) throw Exception(error);

  bool childFilterEnabled = UserPreferences().childFilterEnabled;
  List<dynamic> result = (jsonResponse['result'] as List<dynamic>)
      .where((e) => !childFilterEnabled || !(e['anilist']['isAdult'] as bool))
      .toList();

  return result.map((e) => AnimeInfo.fromAPIJson(e)).toList();
}
