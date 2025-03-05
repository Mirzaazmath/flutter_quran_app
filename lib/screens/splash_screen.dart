import 'package:flutter/material.dart';
import 'package:flutter_quran_app/constant/app_text_style.dart';

import '../constant/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppStrings.appLogo),
          AppTextStyle.headlineText(context, AppStrings.alQuran)
        ],
      ),
      
    );
  }
}
