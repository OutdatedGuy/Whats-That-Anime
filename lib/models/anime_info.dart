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
}
