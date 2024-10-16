import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:manipal_app/components/navbar.dart';
import 'package:manipal_app/screens/auth_screens/login.dart';
import 'package:manipal_app/screens/home_screen/home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _fadeIn();
    _navigateToRoomPage();
  }

  void _fadeIn() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  void _navigateToRoomPage() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (auth.currentUser == null) {
          Get.offAll(() => LoginScreen());
        } else {
          Get.offAll(() => MainLayout());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 500),
              // child: SvgPicture.asset(
              //   IconsPath.applogo,
              //   width: 200,
              // ),
            ),
            const SizedBox(height: 10),
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 500),
              child: Text(
                'Pet Hub',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}