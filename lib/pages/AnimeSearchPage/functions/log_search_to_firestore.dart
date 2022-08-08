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

// Firebase Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Data Models
import 'package:whats_that_anime/models/user_preferences.dart';
import 'package:whats_that_anime/models/anime_info.dart';

void logSearchToFirestore({
  required String imageURL,
  required List<AnimeInfo> result,
  required Map<String, dynamic> topResult,
}) {
  if (!UserPreferences().searchHistoryEnabled) return;

  String userId = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('animeSearches')
      .add({
    'topResult': topResult,
    'imageURL': imageURL,
    'uid': userId,
    'timestamp': FieldValue.serverTimestamp(),
  }).then((value) {
    value.collection('contents').doc('result').set({
      'result': result.map((e) => e.toMap()).toList(),
      'imageURL': imageURL,
      'uid': userId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  });
}
