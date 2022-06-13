// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Firebase Packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Themes
import 'themes/app_theme.dart';

// Pages
import 'pages/HomePage/home_page.dart';

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

  FirebaseAuth.instance.signInAnonymously();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: appTheme(Brightness.light),
      darkTheme: appTheme(Brightness.dark),
      home: const HomePage(),
    );
  }
}
