// Dart Packages
import 'package:http/http.dart' as http;
import 'dart:convert';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';

// Functions
import 'log_search_to_firestore.dart';

Future<List<AnimeInfo>> getImageSearch({
  required String imageURL,
  required bool alreadySearched,
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
  if (response.statusCode != 200) return [];

  final jsonResponse = json.decode(response.body);
  List<dynamic> result = (jsonResponse['result'] as List<dynamic>)
      .where((e) => !(e['anilist']['isAdult'] as bool))
      .toList();
  if (result.isEmpty) return [];

  if (!alreadySearched) {
    logSearchToFirestore(
      imageURL: imageURL,
      result: result,
      topResult: result.first,
    );
  }

  return result.map((e) => AnimeInfo.fromAPIJson(e)).toList();
}
