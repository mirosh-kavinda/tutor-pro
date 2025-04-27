  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, dynamic>?> getStudentData() async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;

    if (userEmail == null) {
      return null;
    }

    final querySnapshot = await FirebaseFirestore.instance
        .collection('students')
        .where('email', isEqualTo: userEmail)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data();
    } else {
      return null;
    }
  }


Future<List<Map<String, dynamic>>> fetchAttendanceData({required String studentId}) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('attendance')
      .where('student_id', isEqualTo: studentId) 
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  } else {
    return [];
  }
}

Future<List<Map<String, dynamic>>> fetchPaymentData({required String studentId}) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('payments')
      .where('student_id', isEqualTo: studentId) 
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  } else {
    return [];
  }
}