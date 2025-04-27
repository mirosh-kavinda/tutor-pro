import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutorpro/screens/admin_dashboard/AdminScreen.dart';

Future<List<Map<String, dynamic>>> fetchTeachersData() async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('teachers').get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  } else {
    return [];
  }
}

Future<List<Map<String, dynamic>>> fetchClassData() async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('classes').get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  } else {
    return [];
  }
}

Future<void> addTeacher(var attendanceData, BuildContext context) async {
  try {
    String email = attendanceData['email'];
    String defaultPassword =
        "Password123"; // Replace with your default password

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: defaultPassword,
    );

    // Add the document to the 'class_attendance' collection
    await FirebaseFirestore.instance.collection('teachers').add(attendanceData);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        'Teacher added successfully! Teachers default password : Password123 Share it!',
        style: TextStyle(
            fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.green[400],
    ));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Error adding attendance: $e',
        style: const TextStyle(
            fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.red[400],
    ));
  } finally {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminScreen(),
      ),
      (route) => false,
    );
  }
}

Future<void> deleteStudent(String studentId, BuildContext context) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('students')
        .where('student_id', isEqualTo: studentId)
        .get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        'Student deleted successfully!',
        style: TextStyle(
            fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.green[400],
    ));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Error deleting student: $e',
        style: const TextStyle(
            fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.red[400],
    ));
  }finally{
      Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminScreen(),
      ),
      (route) => false,
    );
  }
}

Future<void> updateStudentData(String studentId, Map<String, dynamic> updatedData, BuildContext context) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('students')
        .where('student_id', isEqualTo: studentId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        await doc.reference.update(updatedData);
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'Student data updated successfully!',
          style: TextStyle(
              fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[400],
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'No student found with the provided ID.',
          style: TextStyle(
              fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange[400],
      ));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Error updating student data: $e',
        style: const TextStyle(
            fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.red[400],
    ));
  } finally {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminScreen(),
      ),
      (route) => false,
    );
  }
}

Future<void> addStudent(Map<String, dynamic> studentData, BuildContext context, String subjectId ,String classId) async {
  try {
    String email = studentData['email'];
    String defaultPassword = "Student123"; // Replace with your default password

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: defaultPassword,
    );

    // Add the document to the 'students' collection
    await FirebaseFirestore.instance.collection('students').add(studentData);




    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        'Student added successfully! Student default password: Student123 Share it!',
        style: TextStyle(
            fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.green[400],
    ));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Error adding student: $e',
        style: const TextStyle(
            fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.red[400],
    ));
  } finally {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminScreen(),
      ),
      (route) => false,
    );
  }
}