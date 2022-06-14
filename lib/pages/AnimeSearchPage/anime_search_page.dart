// Flutter Packages
import 'package:flutter/material.dart';

// Third Party Packages
import 'package:flutter_easyloading/flutter_easyloading.dart';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';

// Widgets
import 'widgets/top_result.dart';
import 'widgets/result_tile.dart';

// Functions
import 'functions/get_image_search.dart';
import 'functions/style_loading.dart';

class AnimeSearchPage extends StatefulWidget {
  const AnimeSearchPage({
    Key? key,
    required this.imageURL,
    this.alreadySearched = false,
  }) : super(key: key);

  final String imageURL;
  final bool alreadySearched;

  @override
  State<AnimeSearchPage> createState() => _AnimeSearchPageState();
}

class _AnimeSearchPageState extends State<AnimeSearchPage> {
  List<AnimeInfo>? _animeInfoList;

  void _getResults() async {
    styleLoading();
    EasyLoading.show(
      status: widget.alreadySearched ? 'Loading Record...' : 'Searching...',
    );
    final results = await getImageSearch(
      imageURL: widget.imageURL,
      alreadySearched: widget.alreadySearched,
    );
    if (!mounted) return;
    setState(() {
      _animeInfoList = results;
    });
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    super.initState();
    _getResults();
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
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Top Result:', style: text),
                        ),
                        const SizedBox(height: 5),
                        TopResult(anime: _animeInfoList!.first),
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
                          ResultTile(animeInfo: animeInfo),
                      ],
                    ),
                  ),
      ),
    );
  }
}
