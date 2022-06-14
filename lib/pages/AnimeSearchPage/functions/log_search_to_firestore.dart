// Firebase Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Data Models
import 'package:whats_that_anime/models/user_preferences.dart';

void logSearchToFirestore({
  required String imageURL,
  required List result,
  required Map topResult,
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
      'result': result,
      'imageURL': imageURL,
      'uid': userId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  });
}
