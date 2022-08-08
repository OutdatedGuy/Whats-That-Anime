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
import 'package:flutter/services.dart';

// Dart Packages
import 'dart:async';

// Firebase Packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

// Third Party Packages
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// Screens
import 'screens/MainScreen/main_screen.dart';

// Pages
import 'pages/OfflinePage/offline_page.dart';

// Data Models
import 'package:whats_that_anime/models/user_preferences.dart';

// Themes
import 'themes/app_theme.dart';
import 'themes/system_ui_theme.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Awaiting all asynchronous tasks simultaneously
  await Future.wait(
    <Future<dynamic>>[
      // Initialize Firebase app
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),

      // Setting orientation to portrait only
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
  late StreamSubscription<InternetConnectionStatus> connectionSub;
  VoidCallback? disposeListener;
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    _userSubscription = FirebaseAuth.instance.userChanges().listen(
      (User? user) async {
        disposeListener?.call();

        await GetStorage.init(user?.uid ?? 'GetStorage');
        disposeListener = GetStorage(
          user?.uid ?? 'GetStorage',
        ).listenKey('theme', (value) => setState(() {}));

        setState(() {});
      },
    );

    connectionSub = InternetConnectionCheckerPlus().onStatusChange.listen(
      (status) {
        isConnected = status == InternetConnectionStatus.connected;

        isConnected && FirebaseAuth.instance.currentUser?.uid == null
            ? FirebaseAuth.instance.signInAnonymously()
            : setState(() {});
      },
    );

    Timer(const Duration(milliseconds: 690), FlutterNativeSplash.remove);
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    connectionSub.cancel();
    disposeListener?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = UserPreferences().theme;

    return MaterialApp(
      title: 'What\'s That Anime',
      theme: appTheme(Brightness.light),
      darkTheme: appTheme(Brightness.dark),
      themeMode: themeMode,
      home: IndexedStack(
        index: isConnected ? 0 : 1,
        children: [
          MainScreen(
            uid: FirebaseAuth.instance.currentUser?.uid,
          ),
          const OfflinePage(),
        ],
      ),
      builder: EasyLoading.init(
        builder: (context, child) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: systemUITheme(context: context, themeMode: themeMode),
            child: child ?? Container(),
          );
        },
      ),
    );
  }
}
