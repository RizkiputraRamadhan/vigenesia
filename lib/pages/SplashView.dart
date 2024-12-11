import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigenesia/pages/Auth/Login.dart';
import 'package:vigenesia/utils/global.color.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), 
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );

    Timer(const Duration(seconds: 5), () {
      Get.toNamed('/login');
    });
  }

  @override
  void dispose() {
    _controller.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation.value * -30), 
              child: child,
            );
          },
          child: Image.asset(
            'assets/images/logo.png', 
            width: 150,               
            height: 150,              
          ),
        ),
      ),
    );
  }
}
