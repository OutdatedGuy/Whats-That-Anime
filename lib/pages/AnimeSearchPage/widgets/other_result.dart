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
import 'top_result.dart';

class OtherResult extends StatelessWidget {
  const OtherResult({Key? key, required this.anime}) : super(key: key);

  final AnimeInfo anime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Hero(
        tag: anime,
        child: MediaQuery.of(context).size.width > 650
            ? Center(
                child: TopResult(anime: anime),
              )
            : TopResult(anime: anime),
      ),
    );
  }
}
