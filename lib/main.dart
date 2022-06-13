// Flutter Packages
import 'package:flutter/material.dart';

// Themes
import 'themes/app_theme.dart';

// Pages
import 'pages/HomePage/home_page.dart';

void main() {
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
