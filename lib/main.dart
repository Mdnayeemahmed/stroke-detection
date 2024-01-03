import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:stroke_detection/predModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/logo.png'), // Replace with your splash image
        splashIconSize: double.infinity,
        nextScreen: PredModel(),
        splashTransition: SplashTransition.sizeTransition,

        duration: 500, // Adjust the duration as needed (milliseconds)
      ),
    );
  }
}


