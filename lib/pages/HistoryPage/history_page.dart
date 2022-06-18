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

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('Search History')),
      body: uid == null
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : PaginateFirestore(
              //item builder type is compulsory.
              itemBuilder: (context, documentSnapshots, index) {
                final data = documentSnapshots[index].data() as Map?;
                if (data == null) return Container();
                AnimeInfo animeInfo = AnimeInfo.fromMap(
                  data['topResult'] as Map<String, dynamic>,
                );
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Hero(
                        tag: documentSnapshots[index].reference,
                        child: RecordTile(
                          anime: animeInfo,
                          imageURL: data['imageURL'] as String,
                          recordRef: documentSnapshots[index].reference,
                        ),
                      ),
                    ),
                  ),
                );
              },
              onEmpty: const Center(child: Text('No records found')),
              itemsPerPage: 5,
              // orderBy is compulsory to enable pagination
              query: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
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
