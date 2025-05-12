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

  factory AnimeInfo.fromMap(Map<String, dynamic> data) {
    return AnimeInfo(
      englishTitle: data['englishTitle'] ?? 'N.A.',
      romajiTitle: data['romajiTitle'] ?? 'N.A.',
      episode: data['episode'] as dynamic ?? 0,
      timeStart: data['timeStart'] ?? 0,
      timeEnd: data['timeEnd'] ?? 0,
      imageURL: data['imageURL'] ?? '',
      videoURL: data['videoURL'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'englishTitle': englishTitle,
      'romajiTitle': romajiTitle,
      'episode': episode,
      'timeStart': timeStart,
      'timeEnd': timeEnd,
      'imageURL': imageURL,
      'videoURL': videoURL,
    };
  }
}
