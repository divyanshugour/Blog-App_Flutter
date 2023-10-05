import 'package:blog_explorer/BlogsScreen/blogs.dart';
import 'package:blog_explorer/Database/database_helper.dart';
import 'package:blog_explorer/FavoriteBlogsScreen/favorite_blogs.dart';
import 'package:flutter/material.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoaded = false;
  DatabaseHelper dbHelper = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) => setState(() {
          isLoaded = true;
        }));
    dbHelper.init();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      backgroundColor: Color(0xff1B1B1A),
      navigateWhere: isLoaded,
      navigateRoute: const Blogs(),
      logoSize: 120,
      text: FadeAnimatedText(
        "Blog Explorer",
        duration: const Duration(seconds: 5),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 50.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      imageSrc: 'assets/images/splash_icon.png',
      //  displayLoading: false,
    );
  }
}
