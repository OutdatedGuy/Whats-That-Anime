class AnimeInfo {
  String englishTitle, romajiTitle;

  dynamic episode;
  num timeStart, timeEnd;

  String imageURL, videoURL;

  AnimeInfo({
    required this.englishTitle,
    required this.romajiTitle,
    required this.episode,
    required this.timeStart,
    required this.timeEnd,
    required this.imageURL,
    required this.videoURL,
  });

  factory AnimeInfo.fromAPIJson(Map<String, dynamic> data) {
    return AnimeInfo(
      englishTitle: data['anilist']['title']['english'] ?? 'N.A.',
      romajiTitle: data['anilist']['title']['romaji'] ?? 'N.A.',
      episode: data['episode'] as dynamic ?? 0,
      timeStart: data['from'] ?? 0,
      timeEnd: data['to'] ?? 0,
      imageURL: data['image'] ?? '',
      videoURL: data['video'] ?? '',
    );
  }
}
