// Dart Packages
import 'dart:async';
import 'dart:io';

// Flutter Packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

// Firebase Packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

// Third Party Packages
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:window_size/window_size.dart';

// Screens
import 'screens/MainScreen/main_screen.dart';

// Pages
import 'pages/OfflinePage/offline_page.dart';

// Data Models
import 'package:whats_that_anime/models/user_preferences.dart';

// Themes
import 'themes/app_theme.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  usePathUrlStrategy();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
    ),
  );

  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    setWindowMinSize(const Size(400, 800));
    // Open the app in the center of the screen
    await getCurrentScreen().then((screen) {
      setWindowFrame(
        Rect.fromCenter(
          center: Offset(
            (screen?.visibleFrame.width ?? 1920) / 2,
            (screen?.visibleFrame.height ?? 1080) / 2,
          ),
          width: 1080,
          height: 800,
        ),
      );
    });
  }

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

      // Setting system UI mode to edge-to-edge
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
    ],
  );
  await GetStorage.init(
    FirebaseAuth.instance.currentUser?.uid ?? 'GetStorage',
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> _userSubscription;
  late StreamSubscription<InternetStatus> _connectionSub;
  VoidCallback? _disposeListener;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _userSubscription = FirebaseAuth.instance.userChanges().listen(
      (User? user) async {
        _disposeListener?.call();

        await GetStorage.init(user?.uid ?? 'GetStorage');
        _disposeListener = GetStorage(
          user?.uid ?? 'GetStorage',
        ).listenKey('theme', (value) => setState(() {}));

        setState(() {});
      },
    );

    _connectionSub = InternetConnection().onStatusChange.listen(
      (status) {
        _isConnected = status == InternetStatus.connected;

        _isConnected && FirebaseAuth.instance.currentUser?.uid == null
            ? FirebaseAuth.instance.signInAnonymously()
            : setState(() {});
      },
    );

    Timer(const Duration(milliseconds: 690), FlutterNativeSplash.remove);
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    _connectionSub.cancel();
    _disposeListener?.call();
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
        index: _isConnected ? 0 : 1,
        children: [
          MainScreen(
            uid: FirebaseAuth.instance.currentUser?.uid,
          ),
          const OfflinePage(),
        ],
      ),
      builder: EasyLoading.init(),
    );
  }
}
