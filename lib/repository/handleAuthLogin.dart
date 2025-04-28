import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutorpro/screens/admin_dashboard/AdminScreen.dart';
import 'package:tutorpro/screens/login/login_dashboard.dart';
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
     ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        error.toString(),
        style: const TextStyle(
            fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.red[400],
    )
     );
  });
}

Future<void> userAuth(
    BuildContext context, String typeId, String email, String pw) async {
  try {
    if (typeId != "admin") {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pw,
      );

      final querySnapshot = await FirebaseFirestore.instance
          .collection('user_role')
          .where('email', isEqualTo: credential.user?.email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        if (querySnapshot.docs.first.data()['role'] == typeId) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => typeId == "student"
                  ? const StudentProfileCard()
                  : const TeacherProfileCard(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "You need to Log as ${querySnapshot.docs.first.data()['role']}",
                style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.red[400],
            ),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LoginScreenDashboard()),
          );
        }
      }
    }else{
       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "admin@gmail.com",
        password: pw,
      );

      Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>const AdminScreen()
            ),
          );
    }
  } on FirebaseAuthException catch (e) {
    final message = e.message ?? 'An error occurred. Please try again.';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
              fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red[400],
      ),
    );
  }
}
