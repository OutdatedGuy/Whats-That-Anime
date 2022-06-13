// Flutter Packages
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// Third Party Packages
import 'package:chewie/chewie.dart';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';

// Functions
import '../functions/get_formatted_time.dart';

class TopResult extends StatefulWidget {
  const TopResult({Key? key, required this.anime}) : super(key: key);

  final AnimeInfo anime;

  @override
  State<TopResult> createState() => _TopResultState();
}

class _TopResultState extends State<TopResult> {
  late final ChewieController _chewieController = ChewieController(
    videoPlayerController: VideoPlayerController.network(
      widget.anime.videoURL,
    ),
    showOptions: false,
    autoInitialize: true,
    aspectRatio: 16 / 9,
  )..addListener(updateVideo);

  // * Updates the video player when the video is ready
  void updateVideo() => setState(() {});

  @override
  void dispose() {
    _chewieController.removeListener(updateVideo);
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String from = getFormattedDuration(widget.anime.timeStart.truncate());
    String to = getFormattedDuration(widget.anime.timeEnd.truncate());

    return Card(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Chewie(controller: _chewieController),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(),
                Text(
                  'English Title: ${widget.anime.englishTitle}',
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  'Romaji Title: ${widget.anime.romajiTitle}',
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  'Episode: ${widget.anime.episode}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Timestamp: $from - $to',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
