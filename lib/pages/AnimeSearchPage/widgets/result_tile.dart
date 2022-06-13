// Flutter Packages
import 'package:flutter/material.dart';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';

class ResultTile extends StatelessWidget {
  const ResultTile({Key? key, required this.animeInfo}) : super(key: key);

  final AnimeInfo animeInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          animeInfo.englishTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(animeInfo.romajiTitle),
        trailing: Text('Ep ${animeInfo.episode}'),
      ),
    );
  }
}
