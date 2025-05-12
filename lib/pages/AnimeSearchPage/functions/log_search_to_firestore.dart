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
      })
      .then((value) {
        value.collection('contents').doc('result').set({
          'result': result.map((e) => e.toMap()).toList(),
          'imageURL': imageURL,
          'uid': userId,
          'timestamp': FieldValue.serverTimestamp(),
        });
      });
}
