



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<Map<String, dynamic>?> getTeacherData() async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;

    if (userEmail == null) {
      return null;
    }

    final querySnapshot = await FirebaseFirestore.instance
        .collection('teachers')
        .where('email', isEqualTo: userEmail)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data();
    } else {
      return null;
    }
  }

  
Future<List<Map<String, dynamic>>> fetchClassStudentData({required String classId}) async {
  debugPrint(classId);
  final querySnapshot = await FirebaseFirestore.instance
      .collection('classes')
      .where('class_id', isEqualTo: classId) 
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  } else {
    return [];
  }
}

Future<void> addClassAttendance(String classId, String date, List<dynamic> students) async {
  try {
    // Prepare the attendance data
    final attendanceData = {
      'class_id': classId,
      'date': date,
      'students': students.map((student) {
        return {
          'student_id': student['student_id'],
          'student_name': student['student_name'],
          'isPresent': student['isPresent'],
        };
      }).toList(),
      'timestamp': FieldValue.serverTimestamp(),
    };

    // Add the document to the 'class_attendance' collection
    await FirebaseFirestore.instance.collection('class_attendance').add(attendanceData);

    debugPrint('Attendance added successfully!');
  } catch (e) {
    debugPrint('Error adding attendance: $e');
  }
}


Future<bool> isAttendanceSubmitted(String classId) async {
  try {
    // Get today's date in 'yyyy-MM-dd' format
    final today = DateTime.now();
    final formattedDate = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    // Query Firestore to check if attendance exists for the given classId and today's date
    final querySnapshot = await FirebaseFirestore.instance
        .collection('class_attendance')
        .where('class_id', isEqualTo: classId)
        .where('date', isEqualTo: formattedDate)
        .get();

    // Return true if any documents are found, otherwise false
    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    debugPrint('Error checking attendance: $e');
    return false;
  }
}