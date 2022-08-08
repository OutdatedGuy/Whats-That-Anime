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

// Firebase Packages
import 'package:cloud_firestore/cloud_firestore.dart';

// Third Party Packages
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:motion_toast/motion_toast.dart';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';

// Widgets
import 'widgets/top_result.dart';
import 'widgets/result_tile.dart';

// Functions
import 'functions/get_image_search.dart';
import 'functions/style_loading.dart';
import 'functions/log_search_to_firestore.dart';

class AnimeSearchPage extends StatefulWidget {
  const AnimeSearchPage({
    Key? key,
    required this.imageURL,
    this.alreadySearched = false,
    this.recordRef,
  })  : assert(
          !alreadySearched || recordRef != null,
          'recordRef must not be null if alreadySearched is true',
        ),
        super(key: key);

  final String imageURL;
  final bool alreadySearched;
  final DocumentReference? recordRef;

  @override
  State<AnimeSearchPage> createState() => _AnimeSearchPageState();
}

class _AnimeSearchPageState extends State<AnimeSearchPage> {
  List<AnimeInfo>? _animeInfoList;

  void _getResultsFromAPI() async {
    EasyLoading.show(
      status: widget.alreadySearched ? 'Refreshing Video Urls' : 'Searching...',
    );
    try {
      final results = await getImageSearch(imageURL: widget.imageURL);

      if (!mounted) return;

      if (!widget.alreadySearched) {
        logSearchToFirestore(
          imageURL: widget.imageURL,
          result: results,
          topResult: results.first.toMap(),
        );
      }
      setState(() {
        _animeInfoList = results;
      });
    } on Exception catch (e) {
      Navigator.pop(context);
      MotionToast.error(
        description: Text(
          e.toString().replaceFirst('Exception: ', ''),
          style: const TextStyle(color: Colors.black),
        ),
      ).show(context);
    } finally {
      EasyLoading.dismiss();
    }
  }

  void _getResultsFromFirestore() async {
    EasyLoading.show(status: 'Loading Record...');
    if (widget.recordRef == null) {
      setState(() {
        _animeInfoList = [];
      });
      return;
    }
    final record = await widget.recordRef!.get();
    if (!mounted) return;

    if (record.exists) {
      _animeInfoList =
          (record['result'] as List).map((e) => AnimeInfo.fromMap(e)).toList();
      setState(() {});
    }
    _getResultsFromAPI();
  }

  @override
  void initState() {
    super.initState();
    styleLoading();
    widget.alreadySearched ? _getResultsFromFirestore() : _getResultsFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? text = Theme.of(context).textTheme.headline4?.copyWith(
          color: Theme.of(context).textTheme.bodyText1?.color,
        );

    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Anime Search'),
        ),
        body: _animeInfoList == null
            ? null
            : _animeInfoList!.isEmpty
                ? const Center(
                    child: Text('No results found.'),
                  )
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: [
                      Align(
                        child: Text('Top Result', style: text),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        child: Hero(
                          tag: widget.recordRef?.parent.parent ??
                              widget.imageURL,
                          child: TopResult(
                            key: ValueKey(_animeInfoList!.first),
                            anime: _animeInfoList!.first,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Other Results:',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      const SizedBox(height: 10),
                      for (final animeInfo in _animeInfoList!.skip(1))
                        ResultTile(
                          key: ValueKey(animeInfo),
                          animeInfo: animeInfo,
                        ),
                    ],
                  ),
      ),
    );
  }
}
