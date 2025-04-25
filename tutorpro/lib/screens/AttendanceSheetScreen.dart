// import 'package:flutter/material.dart';

// class AttendanceSheetScreen extends StatefulWidget {
//   @override
//   _AttendanceSheetScreenState createState() => _AttendanceSheetScreenState();
// }

// class _AttendanceSheetScreenState extends State<AttendanceSheetScreen> {
//   List<Map<String, dynamic>> students = [
//     {'sno': '0001', 'name': 'Lorem spein', 'present': false},
//     {'sno': '0002', 'name': 'Lorem spein', 'present': false},
//     {'sno': '0003', 'name': 'Lorem spein', 'present': false},
//     {'sno': '0004', 'name': 'Lorem spein', 'present': false},
//     {'sno': '0005', 'name': 'Lorem spein', 'present': false},
//     {'sno': '0006', 'name': 'Lorem spein', 'present': false},
//     {'sno': '0007', 'name': 'Lorem spein', 'present': false},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('STUDENT LIST'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Date Section
//             Row(
//               children: [
//                 Text('Date: ', style: TextStyle(fontSize: 16)),
//                 TextButton(
//                   onPressed: () => _selectDate(context),
//                   child: Text(
//                     'Select Date',
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),

//             // Attendance Sheet Header
//             Text('Attendance Sheet', 
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),

//             // Table Header
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('S.No', style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text('Present', style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text('Absent', style: TextStyle(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//             Divider(thickness: 2),

//             // Student List
//             Expanded(
//               child: ListView.separated(
//                 itemCount: students.length,
//                 separatorBuilder: (context, index) => Divider(),
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(students[index]['sno']),
//                         Text(students[index]['name']),
//                         IconButton(
//                           icon: Icon(
//                             Icons.check_circle,
//                             color: students[index]['present'] 
//                                 ? Colors.green 
//                                 : Colors.grey,
//                           ),
//                           onPressed: () => _toggleAttendance(index, true),
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             Icons.cancel,
//                             color: !students[index]['present'] 
//                                 ? Colors.red 
//                                 : Colors.grey,
//                           ),
//                           onPressed: () => _toggleAttendance(index, false),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // Exit Button
//             Center(
//               child: ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('EXIT'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.red,
//                   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                 ),