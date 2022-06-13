// Dart Packages
import 'package:http/http.dart' as http;
import 'dart:convert';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';

Future<List<AnimeInfo>> getImageSearch(String imageURL) async {
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
  if ((jsonResponse['result'] as List<dynamic>).isEmpty) return [];

  List<AnimeInfo> animeInfoList = [];
  for (var anime in jsonResponse['result']) {
    animeInfoList.add(AnimeInfo(
      englishTitle: anime['anilist']['title']['english'] ?? 'N.A.',
      romajiTitle: anime['anilist']['title']['romaji'] ?? 'N.A.',
      episode: anime['episode'] ?? 0,
      timeStart: anime['from'] ?? 0,
      timeEnd: anime['to'] ?? 0,
      imageURL: anime['image'] ?? '',
      videoURL: anime['video'] ?? '',
    ));
  }
  return animeInfoList;
}
