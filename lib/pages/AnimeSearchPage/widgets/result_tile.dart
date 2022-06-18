// Flutter Packages
import 'package:flutter/material.dart';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';

// Widgets
import 'top_result.dart';

class ResultTile extends StatelessWidget {
  const ResultTile({Key? key, required this.animeInfo}) : super(key: key);

  final AnimeInfo animeInfo;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: animeInfo,
      child: Card(
        child: ListTile(
          title: Text(
            animeInfo.englishTitle,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          subtitle: Text(animeInfo.romajiTitle),
          trailing: Text('Ep ${animeInfo.episode}'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) => Align(
                  child: Hero(
                    tag: animeInfo,
                    child: SafeArea(
                      child: TopResult(anime: animeInfo),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
