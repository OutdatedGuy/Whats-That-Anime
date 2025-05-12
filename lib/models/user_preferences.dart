// Flutter Packages
import 'package:flutter/material.dart';

// Firebase Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Third Party Packages
import 'package:get_storage/get_storage.dart';

class UserPreferences {
  GetStorage get _storage {
    return GetStorage(
      FirebaseAuth.instance.currentUser?.uid ?? 'GetStorage',
    );
  }

  ThemeMode get theme {
    String theme = _storage.read<String>('theme') ?? 'dark';
    return theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  set theme(ThemeMode theme) {
    _storage.write('theme', theme == ThemeMode.dark ? 'dark' : 'light');
  }

  bool get isDarkMode => theme == ThemeMode.dark;

  bool get searchHistoryEnabled {
    return _storage.read<bool>('searchHistory') ?? true;
  }

  set searchHistoryEnabled(bool enabled) {
    _storage.write('searchHistory', enabled);
  }

  bool get shouldAutoplay {
    return _storage.read<bool>('autoplay') ?? false;
  }

  set shouldAutoplay(bool autoplay) {
    _storage.write('autoplay', autoplay);
  }

  bool get shouldLoop {
    return _storage.read<bool>('loop') ?? false;
  }

  set shouldLoop(bool loop) {
    _storage.write('loop', loop);
  }

  bool get childFilterEnabled {
    return _storage.read<bool>('childFilter') ?? true;
  }

  set childFilterEnabled(bool enabled) {
    _storage.write('childFilter', enabled);
  }

  static Future<void> clearSearchHistory() async {
    final instance = FirebaseFirestore.instance;

    final batch = instance.batch();
    CollectionReference collection = instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('animeSearches');

    QuerySnapshot snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }

    return batch.commit();
  }
}
