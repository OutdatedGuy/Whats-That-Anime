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
import 'package:firebase_auth/firebase_auth.dart';

// Third Party Packages
import 'package:firebase_pagination/firebase_pagination.dart';

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
  List<Widget> records = [];

  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('Search History')),
      body: uid == null
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              width: double.infinity,
              child: FirestorePagination(
                limit: 6,
                viewType: ViewType.wrap,
                onEmpty: const Center(child: Text('No records found')),
                isLive: true,
                wrapOptions: const WrapOptions(
                  alignment: WrapAlignment.center,
                  runSpacing: 0.0,
                ),
                query: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('animeSearches')
                    .orderBy('timestamp', descending: true),
                itemBuilder: (context, documentSnapshot, index) {
                  final data = documentSnapshot.data() as Map<String, dynamic>?;

                  if (data == null) return Container();

                  AnimeInfo animeInfo = AnimeInfo.fromMap(
                    data['topResult'] as Map<String, dynamic>,
                  );

                  return Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    margin: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: documentSnapshot.reference,
                      child: RecordTile(
                        anime: animeInfo,
                        imageURL: data['imageURL'] as String,
                        recordRef: documentSnapshot.reference,
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
