// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Dart Packages
import 'dart:async';

// Firebase Packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Third Party Packages
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

// Data Models
import 'package:whats_that_anime/models/user_preferences.dart';

// Themes
import 'themes/app_theme.dart';

// Screens
import 'screens/MainScreen/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Awaiting all asynchronous tasks simultaneously
  await Future.wait(
    <Future<dynamic>>[
      // Initialize Firebase app
      Firebase.initializeApp(),

      // Seeting oritation to portrait only
      SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      ),
    ],
  );
  await GetStorage.init(
    FirebaseAuth.instance.currentUser?.uid ?? 'GetStorage',
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> _userSubscription;

  @override
  void initState() {
    super.initState();
    _userSubscription = FirebaseAuth.instance.userChanges().listen(
      (User? user) async {
        await GetStorage.init(user?.uid ?? 'GetStorage');
        GetStorage(
          user?.uid ?? 'GetStorage',
        ).listenKey('theme', (value) => setState(() {}));

        setState(() {});
      },
    );
    FirebaseAuth.instance.signInAnonymously();
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'What\'s That Anime',
      theme: appTheme(Brightness.light),
      darkTheme: appTheme(Brightness.dark),
      themeMode: UserPreferences().theme,
      home: const MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}
