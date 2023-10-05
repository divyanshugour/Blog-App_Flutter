import 'package:blog_explorer/FavoriteBlogsScreen/favorite_blogs.dart';
import 'package:blog_explorer/SplashScreen/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Explorer',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff1B1B1A),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 35),
        ),
        primaryColor: Colors.white,
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: const Color(0xff1B1B1A),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
