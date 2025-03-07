import 'package:flutter/material.dart';
import 'package:flutter_quran_app/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constant/app_colors.dart';

void main(){

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor:AppColors.backgroundColor,
        primaryColorLight:AppColors.primaryLightColor,
        textTheme: GoogleFonts.amiriTextTheme(),
      ),
      home: SplashScreen(),
    );
  }
}
