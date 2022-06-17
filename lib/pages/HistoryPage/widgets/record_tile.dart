// Flutter Packages
import 'package:flutter/material.dart';

// Firebase Packages
import 'package:cloud_firestore/cloud_firestore.dart';

// Third Party Packages
import 'package:cached_network_image/cached_network_image.dart';

// Pages
import 'package:whats_that_anime/pages/AnimeSearchPage/anime_search_page.dart';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';

// Functions
import 'package:whats_that_anime/functions/get_formatted_time.dart';

class RecordTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    String from = getFormattedDuration(anime.timeStart.truncate());
    String to = getFormattedDuration(anime.timeEnd.truncate());

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnimeSearchPage(
                imageURL: imageURL,
                alreadySearched: true,
                recordRef: recordRef.collection('contents').doc('result'),
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(10.0),
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
                    image: CachedNetworkImageProvider(imageURL),
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
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          anime.englishTitle,
                          style: Theme.of(context).textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          anime.romajiTitle,
                          style: Theme.of(context).textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Episode: ${anime.episode}',
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
                          recordRef.delete();
                        },
                        color: Colors.red,
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
      ),
    );
  }
}
