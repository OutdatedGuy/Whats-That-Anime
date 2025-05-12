// Flutter Packages
import 'package:flutter/material.dart';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';

// Widgets
import 'top_result.dart';

class OtherResult extends StatelessWidget {
  const OtherResult({super.key, required this.anime});

  final AnimeInfo anime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Hero(
        tag: anime,
        child:
            MediaQuery.of(context).size.width > 650
                ? Center(child: TopResult(anime: anime))
                : TopResult(anime: anime),
      ),
    );
  }
}
