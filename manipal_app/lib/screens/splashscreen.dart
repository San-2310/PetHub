import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:manipal_app/components/navbar.dart';
import 'package:manipal_app/screens/auth_screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _logoOpacity = 0.0;
  double _animationOpacity = 0.0;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _playSplashSequence();
  }

  void _playSplashSequence() {
    // Step 1: Fade in Lottie animation in the first 2 seconds
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _animationOpacity = 1.0;
      });
    });

    // Step 2: Fade in and out logo after 2 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _logoOpacity = 1.0;
      });

      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          _logoOpacity = 0.0;
        });
      });
    });

    // Step 3: Navigate to the next page after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (auth.currentUser == null) {
        Get.offAll(() => LoginScreen());
      } else {
        Get.offAll(() => MainLayout());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: LinearGradient(colors: ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 248, 248, 1),
              Color.fromRGBO(222, 249, 196, 1),
            ], // Specify your gradient colors here
            begin:
                Alignment.topCenter, // Define the start point of the gradient
            end: Alignment.bottomCenter, // Define the end point of the gradient
          ),
        ),
        child: Center(
          child: Stack(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lottie Animation with fade in

              // Logo fade in and out
              AnimatedOpacity(
                opacity: _logoOpacity,
                duration: const Duration(seconds: 2),
                child: Image.asset(
                  'assets/logo.png', // Replace with your logo
                  width: 200,
                ),
              ),
              AnimatedOpacity(
                opacity: _animationOpacity,
                duration: const Duration(seconds: 2),
                child: Lottie.asset(
                  'assets/splash_animation.json', // Replace with your Lottie animation file
                  width: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}