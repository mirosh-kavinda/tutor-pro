// import 'package:flutter/material.dart';

// class AttendanceScreen extends StatelessWidget {
//   final List<Map<String, String>> students = [
//     {'sno': '0001', 'name': 'Avishka'},
//     {'sno': '0002', 'name': 'Lorem spein'},
//     {'sno': '0003', 'name': 'Lorem spein'},
//     {'sno': '0004', 'name': 'Lorem spein'},
//     {'sno': '0005', 'name': 'Lorem spein'},
//     {'sno': '0006', 'name': 'Lorem spein'},
//     {'sno': '0007', 'name': 'Lorem spein'},
//     {'sno': '0008', 'name': 'Lorem spein'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Attendance'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             const Text(
//               'VIEW ATTENDANCE',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
            
//             // Student List Header
//             const Text(
//               'Student List',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 10),
            
//             // Table Header
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(vertical: 8.0),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //     children: const [
//             //       Text('S.No', style: TextStyle(fontWeight: FontWeight.bold)),
//             //       Text('Name', style: TextStyle(fontWeight: FontWeight)