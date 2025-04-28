  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, dynamic>?> getStudentData({String? studentId}) async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
final querySnapshot;
    if (userEmail == null) {
      return null;
    }
    if(studentId!=null){
   
     querySnapshot  = await FirebaseFirestore.instance
        .collection('students')
        .where('student_id', isEqualTo: studentId)
        .limit(1)
        .get();
    }else{
      
   querySnapshot = await FirebaseFirestore.instance
        .collection('students')
        .where('email', isEqualTo: userEmail)
        .limit(1)
        .get();
    }
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data();
    } else {
      return null;
    }
  }


Future<List<Map<String, dynamic>>> fetchAttendanceData({ String?studentId,String? classId}) async {
 
  QuerySnapshot<Map<String, dynamic>> querySnapshot;
  if(studentId!=null){
 querySnapshot = await FirebaseFirestore.instance
      .collection('attendance')
      .where('student_id', isEqualTo: studentId) 
      .get();
  }else{
    querySnapshot = await FirebaseFirestore.instance
      .collection('attendance')
      .where('class_id',isEqualTo:classId )
      .get();
  }
  

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