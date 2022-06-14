// Flutter Packages
import 'package:flutter/material.dart';

// Firebase Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Third Party Packages
import 'package:paginate_firestore/paginate_firestore.dart';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';

// Widgets
import 'widgets/record_tile.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search History')),
      body: PaginateFirestore(
        //item builder type is compulsory.
        itemBuilder: (context, documentSnapshots, index) {
          final data = documentSnapshots[index].data() as Map?;
          if (data == null) return Container();
          AnimeInfo animeInfo = AnimeInfo.fromAPIJson(
            data['topResult'] as Map<String, dynamic>,
          );
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: RecordTile(
              anime: animeInfo,
              imageURL: data['imageURL'] as String,
            ),
          );
        },
        itemsPerPage: 1,
        // orderBy is compulsory to enable pagination
        query: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('animeSearches')
            .orderBy('timestamp', descending: true),
        //Change types accordingly
        itemBuilderType: PaginateBuilderType.listView,
        // to fetch real-time data
        isLive: true,
      ),
    );
  }
}
