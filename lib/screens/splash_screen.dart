import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_quran_app/constant/app_text_style.dart';
import 'package:flutter_quran_app/screens/home_screen.dart';

import '../constant/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  /// ANIMATION CONTROLLER
  late AnimationController _controller;

  /// ANIMATION
  late Animation<double> _animation;

  /// OFFSET ANIMATION
  late Animation<Offset> _offsetAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// INITIALING THE CONTROLLER
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    /// INITIALING THE ANIMATION
    _animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);

    /// INITIALING THE  OFFSET ANIMATION
    _offsetAnimation = _controller
        .drive(CurveTween(curve: Curves.easeInOut))
        .drive(Tween<Offset>(begin: Offset(0.0, 10.0), end: Offset(0.0, 0.0)));

    /// STARTING THE ANIMATION
    _controller.forward();

    /// TIMER FOR SPLASH DURATION
    Timer(const Duration(seconds: 3), () {
      /// NAVIGATING TO HOME SCREEN
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _animation,
                child: Hero(
                  tag: AppStrings.appLogo,
                  child: Image.asset(AppStrings.appLogo),
                ),
              ),
              SlideTransition(
                position: _offsetAnimation,
                child: AppTextStyle.headlineText(context, AppStrings.alQuran),
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: AppTextStyle.titleMediumText(
                context,
                AppStrings.developerBranding,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
