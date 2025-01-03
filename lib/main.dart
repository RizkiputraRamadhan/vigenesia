import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigenesia/Helpers/Sessions.dart';
import 'package:vigenesia/pages/Auth/Register.dart';
import 'package:vigenesia/pages/Following.dart';
import 'package:vigenesia/pages/NoFriends.dart';
import 'package:vigenesia/pages/Profile.dart';
import 'package:vigenesia/pages/SplashView.dart';
import 'package:vigenesia/utils/global.color.dart';
import 'pages/Auth/Login.dart';
import 'pages/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Sessions.init();
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
        colorScheme: ColorScheme.fromSeed(seedColor: GlobalColors.mainColor),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashView()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/following', page: () => const FollowingPage()),
        GetPage(name: '/profile', page: () => const ProfilePage()),
        GetPage(name: '/no_friends', page: () => const NoFriendsPage()),
      ],
    );
  }
}
