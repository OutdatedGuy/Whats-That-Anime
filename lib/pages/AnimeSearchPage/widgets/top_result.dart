// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Third Party Packages
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';
import 'package:whats_that_anime/models/user_preferences.dart';

// Functions
import 'package:whats_that_anime/functions/get_formatted_time.dart';

class TopResult extends StatefulWidget {
  const TopResult({super.key, required this.anime});

  final AnimeInfo anime;

  @override
  State<TopResult> createState() => _TopResultState();
}

class _TopResultState extends State<TopResult> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.anime.videoURL),
    )..initialize().then((_) {
        final userPrefs = UserPreferences();

        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            aspectRatio: _videoPlayerController.value.aspectRatio,
            autoPlay: userPrefs.shouldAutoplay,
            looping: userPrefs.shouldLoop,
            showOptions: false,
            allowFullScreen: !kIsWeb,
            hideControlsTimer: const Duration(seconds: 1),
          );
        });
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String from = getFormattedDuration(widget.anime.timeStart.truncate());
    String to = getFormattedDuration(widget.anime.timeEnd.truncate());

    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                color: Colors.black,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: _chewieController == null
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : Chewie(controller: _chewieController!),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(),
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
      ),
    );
  }
}
