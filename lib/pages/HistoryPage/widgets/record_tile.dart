// Flutter Packages
import 'package:flutter/material.dart';

// Firebase Packages
import 'package:cloud_firestore/cloud_firestore.dart';

// Third Party Packages
import 'package:cached_network_image/cached_network_image.dart';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';

// Functions
import 'package:whats_that_anime/functions/get_formatted_time.dart';

class RecordTile extends StatefulWidget {
  const RecordTile({
    Key? key,
    required this.imageURL,
    required this.anime,
    required this.recordRef,
  }) : super(key: key);

  final String imageURL;
  final AnimeInfo anime;
  final DocumentReference recordRef;

  @override
  State<RecordTile> createState() => _RecordTileState();
}

class _RecordTileState extends State<RecordTile> {
  @override
  Widget build(BuildContext context) {
    String from = getFormattedDuration(widget.anime.timeStart.truncate());
    String to = getFormattedDuration(widget.anime.timeEnd.truncate());

    return Card(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Colors.black87,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(widget.imageURL),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Top Result:',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.anime.englishTitle,
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.anime.romajiTitle,
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
                Expanded(
                  flex: 1,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        widget.recordRef.delete();
                      },
                      tooltip: 'Delete Record',
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
