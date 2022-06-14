// Flutter Packages
import 'package:flutter/material.dart';

// Firebase Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Third Party Packages
import 'package:get_storage/get_storage.dart';

class UserPreferences {
  ThemeMode get theme {
    GetStorage storage = GetStorage(
      FirebaseAuth.instance.currentUser?.uid ?? 'GetStorage',
    );
    String theme = storage.read<String>('theme') ?? 'dark';
    return theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  set theme(ThemeMode theme) {
    GetStorage storage = GetStorage(
      FirebaseAuth.instance.currentUser?.uid ?? 'GetStorage',
    );
    storage.write('theme', theme == ThemeMode.dark ? 'dark' : 'light');
  }

  bool get isDarkMode => theme == ThemeMode.dark;

  bool get searchHistoryEnabled {
    GetStorage storage = GetStorage(
      FirebaseAuth.instance.currentUser?.uid ?? 'GetStorage',
    );
    return storage.read<bool>('searchHistory') ?? true;
  }

  set searchHistoryEnabled(bool enabled) {
    GetStorage storage = GetStorage(
      FirebaseAuth.instance.currentUser?.uid ?? 'GetStorage',
    );
    storage.write('searchHistory', enabled);
  }

  bool get shouldAutoplay {
    GetStorage storage = GetStorage(
      FirebaseAuth.instance.currentUser?.uid ?? 'GetStorage',
    );
    return storage.read<bool>('autoplay') ?? false;
  }

  set shouldAutoplay(bool autoplay) {
    GetStorage storage = GetStorage(
      FirebaseAuth.instance.currentUser?.uid ?? 'GetStorage',
    );
    storage.write('autoplay', autoplay);
  }

  bool get shouldLoop {
    GetStorage storage = GetStorage(
      FirebaseAuth.instance.currentUser?.uid ?? 'GetStorage',
    );
    return storage.read<bool>('loop') ?? false;
  }

  set shouldLoop(bool loop) {
    GetStorage storage = GetStorage(
      FirebaseAuth.instance.currentUser?.uid ?? 'GetStorage',
    );
    storage.write('loop', loop);
  }

  bool get childFilterEnabled {
    GetStorage storage = GetStorage(
      FirebaseAuth.instance.currentUser?.uid ?? 'GetStorage',
    );
    return storage.read<bool>('childFilter') ?? true;
  }

  set childFilterEnabled(bool enabled) {
    GetStorage storage = GetStorage(
      FirebaseAuth.instance.currentUser?.uid ?? 'GetStorage',
    );
    storage.write('childFilter', enabled);
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
    await batch.commit();
  }
}
