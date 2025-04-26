import 'package:flutter/material.dart';
import 'screens/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp(appTitle: 'TutorPro Admin'));
}

class MyApp extends StatelessWidget {
  final String appTitle;
 
  const MyApp({super.key, required this.appTitle});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(),
      home: OnboardingScreen(),
    );
  }
}