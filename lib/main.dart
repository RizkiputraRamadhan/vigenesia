import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigenesia/pages/Auth/Register.dart';
import 'package:vigenesia/pages/Following.dart';
import 'package:vigenesia/pages/MyPost.dart';
import 'package:vigenesia/pages/Profile.dart';
import 'package:vigenesia/pages/SplashView.dart';
import 'pages/Auth/Login.dart';
import 'pages/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vigenesia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashView()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/following', page: () => const FollowingPage()),
        GetPage(name: '/myPost', page: () => const MyPostPages()),
        GetPage(name: '/profile', page: () => const ProfilePage()),
      ],
    );
  }
}
