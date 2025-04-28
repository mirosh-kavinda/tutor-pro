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


Future<List<Map<String, dynamic>>> fetchSchedules() async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('schedule').get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  } else {
    return [];
  }
}

Future<List<Map<String, dynamic>>> fetchPayments({required String classId}) async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('payments').where('class_id',isEqualTo: classId).get();

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
  String adminEmail = "admin@gmail.com"; // Your admin email
  String adminPassword = "123456"; // Your admin password

  try {
    String email = attendanceData['email'];
    String defaultPassword = "Password123";

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: defaultPassword,
    );

    // Add teacher to Firestore
    await FirebaseFirestore.instance.collection('teachers').add(attendanceData);

    // Add role
    await FirebaseFirestore.instance
        .collection('user_role')
        .doc(attendanceData["email"])
        .set(
      {"email": attendanceData["email"], "role": "teacher"},
      SetOptions(merge: true),
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        'Teacher added successfully! Teachers default password : Password123 Share it!',
        style: TextStyle(
            fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.green[400],
    ));

    await FirebaseAuth.instance.signOut(); // sign out the teacher user
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: adminEmail,
      password: adminPassword,
    );
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
    // Fetch the student document(s) to delete
    final querySnapshot = await FirebaseFirestore.instance
        .collection('students')
        .where('student_id', isEqualTo: studentId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        // Remove the student from the 'students' collection
        await doc.reference.delete();

        // Remove the student from the 'user_role' collection
        final studentEmail = doc.data()['email'];
        await FirebaseFirestore.instance
            .collection('user_role')
            .doc(studentEmail)
            .delete();

        // Remove the student from the 'students' array in the 'classes' collection
        final studentName = doc.data()["student_name"];
        await FirebaseFirestore.instance
            .collection('classes')
            .where('students', arrayContains: {"student_id": studentId})
            .get()
            .then((classQuerySnapshot) async {
              for (var classDoc in classQuerySnapshot.docs) {
                await classDoc.reference.update({
                  "students": FieldValue.arrayRemove([
                    {"student_name": studentName, "student_id": studentId}
                  ])
                });
              }
            });
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'Student deleted successfully!',
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
        'Error deleting student: $e',
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

Future<void> updateStudentData(String studentId,
    Map<String, dynamic> updatedData, BuildContext context) async {
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

Future<void> addStudent(Map<String, dynamic> studentData, BuildContext context,
    String classId) async {
  try {
    String email = studentData['email'];
    String defaultPassword = "Student123"; // Replace with your default password

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: defaultPassword,
    );

    // Add the document to the 'students' collection
    DocumentReference studentDocRef = await FirebaseFirestore.instance
        .collection('students')
        .add(studentData);

    // Add the student role to the 'user_role' collection
    await FirebaseFirestore.instance
        .collection('user_role')
        .doc(studentData["email"])
        .set(
      {"email": studentData["email"], "role": "student"},
      SetOptions(merge: true),
    );

    // Update the class document with the student data
    final querySnapshot = await FirebaseFirestore.instance
        .collection('classes')
        .where('class_id', isEqualTo: classId)
        .get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.update({
        "students": FieldValue.arrayUnion([
          {
            "student_name": studentData["student_name"],
            "student_id": studentData["student_id"],
          }
        ])
      });
    }

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




Future<void> addschedule(Map<String, dynamic> schedule, BuildContext context) async {
  try {
    
    await FirebaseFirestore.instance
        .collection('schedule')
        .add(schedule);

   
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        'Schedule added successfully!',
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


Future<void> updatePaymentStatus(String paymentId, bool isPaid) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('payments')
        .where('payment_id', isEqualTo: paymentId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      await FirebaseFirestore.instance
          .collection('payments')
          .doc(docId)
          .update({
            'payment': isPaid ? 2000 : 0, // Assuming 2000 as the payment amount when paid, 0 when unpaid
            'timestamp': FieldValue.serverTimestamp(),
          });
      debugPrint('Payment status updated successfully for paymentId: $paymentId');
    } else {
      debugPrint('Payment not found for paymentId: $paymentId');
    }
  } catch (e) {
    debugPrint('Error updating payment status: $e');
  }
}