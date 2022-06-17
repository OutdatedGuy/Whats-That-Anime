// Dart Packages
import 'package:http/http.dart' as http;
import 'dart:convert';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';
import 'package:whats_that_anime/models/user_preferences.dart';

Future<List<AnimeInfo>> getImageSearch({required String imageURL}) async {
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
  if (response.statusCode == 402 || error.isNotEmpty) {
    await Future.delayed(const Duration(seconds: 5));
    return getImageSearch(imageURL: imageURL);
  }
  if (response.statusCode != 200) return [];

  bool childFilterEnabled = UserPreferences().childFilterEnabled;
  List<dynamic> result = (jsonResponse['result'] as List<dynamic>)
      .where((e) => !childFilterEnabled || !(e['anilist']['isAdult'] as bool))
      .toList();

  if (result.isEmpty) return [];

  return result.map((e) => AnimeInfo.fromAPIJson(e)).toList();
}
