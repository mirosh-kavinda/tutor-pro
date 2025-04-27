import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/student_dahboard/student_profile.dart';
import '../screens/teacher_dashboard/teacher_profile.dart';

Future<void> AuthSignout(BuildContext context) async {
  FirebaseAuth.instance.signOut().then((value) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const OnboardingScreen(),
      ),
      (route) => false,
    );
  }).catchError((error) {
    SnackBar(
          content: Text(
            error.toString(),
            style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red[400],
        );
  });
}
 Future <void> userAuth(BuildContext context,String typeId, String email, String pw) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email:email,
        password: pw,
      );
      debugPrint(credential.user?.toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => typeId == "student"
              ? const StudentProfileCard()
              : const TeacherProfileCard(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      final message = e.message ?? 'An error occurred. Please try again.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red[400],
        ),
      );
    }
  }