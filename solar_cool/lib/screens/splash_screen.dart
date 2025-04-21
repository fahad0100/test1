import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait 3 seconds then navigate to HomeScreen
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const MainScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Match the background
      body: Center(
        child: Image.asset('assets/images/logo.jpeg', fit: BoxFit.cover),
      ),
    );
  }
}

//Timer(Duration(seconds: 3), checkAutoLogin);
