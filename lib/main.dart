import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff00613c),
        scaffoldBackgroundColor: Colors.white,
        primaryColorLight: Color(0xffcdad1a),
        textTheme: GoogleFonts.amiriTextTheme(),
      ),
    );
  }
}
