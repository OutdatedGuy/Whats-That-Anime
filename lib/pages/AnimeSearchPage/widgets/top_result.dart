// Flutter Packages
import 'package:flutter/material.dart';

// Third Party Packages
import 'package:better_player/better_player.dart';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';

// Functions
import 'package:whats_that_anime/functions/get_formatted_time.dart';

class TopResult extends StatefulWidget {
  const TopResult({Key? key, required this.anime}) : super(key: key);

  final AnimeInfo anime;

  @override
  State<TopResult> createState() => _TopResultState();
}

class _TopResultState extends State<TopResult> {
  late BetterPlayerController _betterPlayerController;

  void _handleControlVisibility(BetterPlayerEvent event) async {
    switch (event.betterPlayerEventType) {
      case BetterPlayerEventType.play:
        await Future.delayed(const Duration(milliseconds: 200));
        _betterPlayerController.setControlsVisibility(false);
        break;
      case BetterPlayerEventType.exception:
        _betterPlayerController.retryDataSource();
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    const betterPlayerConfiguration = BetterPlayerConfiguration(
      fit: BoxFit.contain,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        enableOverflowMenu: false,
      ),
    );
    final dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.anime.videoURL,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.addEventsListener(_handleControlVisibility);
  }

  @override
  void dispose() {
    _betterPlayerController.removeEventsListener(_handleControlVisibility);
    _betterPlayerController.dispose();
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
              child: BetterPlayer(controller: _betterPlayerController),
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
