// Firebase Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void logSearchToFirestore({required Map topResult, required String imageURL}) {
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
  });
}
