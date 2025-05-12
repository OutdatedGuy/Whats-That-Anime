// Flutter Packages
import 'package:flutter/material.dart';

// Firebase Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Third Party Packages
import 'package:firebase_pagination/firebase_pagination.dart';

// Data Models
import 'package:whats_that_anime/models/anime_info.dart';

// Widgets
import 'widgets/record_tile.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _query = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('animeSearches')
      .orderBy('timestamp', descending: true);

  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('Search History')),
      body:
          uid == null
              ? const Center(
                child: CircularProgressIndicator.adaptive(strokeWidth: 2),
              )
              : FirestorePagination(
                query: _query,
                isLive: true,
                itemBuilder: (context, snapshots, i) {
                  final data = snapshots[i].data() as Map?;
                  if (data == null) return Container();

                  final animeInfo = AnimeInfo.fromMap(
                    data['topResult'] as Map<String, dynamic>,
                  );

                  return Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    margin: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: snapshots[i].reference,
                      child: RecordTile(
                        anime: animeInfo,
                        imageURL: data['imageURL'] as String,
                        recordRef: snapshots[i].reference,
                      ),
                    ),
                  );
                },
                viewType: ViewType.wrap,
                onEmpty: const Center(child: Text('No records found')),
              ),
    );
  }
}
