// Copyright (C) 2022 OutdatedGuy
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// Flutter Packages
import 'package:flutter/material.dart';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';

// Widgets
import 'other_result.dart';

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
                builder: (context) => OtherResult(anime: animeInfo),
              ),
            );
          },
        ),
      ),
    );
  }
}
