import 'package:flutter/material.dart';
import 'package:tutorpro/screens/admin_dashboard/AddStudent.dart';
import 'package:tutorpro/screens/admin_dashboard/AddTeacher.dart';
import 'package:tutorpro/widgets/teacher_list.dart';

class TeacherListScreen extends StatelessWidget {
  final int classId;
  const TeacherListScreen({super.key, required this.classId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;

          return Stack(
            children: [
              // Background image
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: screenWidth <= 640 ? 200 : 276,
                child: Image.asset(
                  'assets/images/adminteacherlist.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Back button
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              // Content
              Positioned(
                top: screenWidth <= 640 ? 200 : 276,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/admin_backgroun.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align text to start
                          children: [
                            Text(
                              "Teacher List",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 4), // space between text and line
                            Container(
                              height: 2, // thickness of the line
                              width:
                                  80, // length of the line (adjust as needed)
                              color: Colors.white, // color of the line
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Table header
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        color: Colors.black.withOpacity(0.3),
                        child: Row(
                          children: const [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'T.No',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Name',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Grade',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Class',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Divider(color: Colors.grey, thickness: 1),

                      // List items
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: const [
                            TeacherListItem(
                                date: '0001',
                                name: 'Alice Johnson',
                                grade: 'G.6',
                                className: 'Maths'),
                            TeacherListItem(
                                date: '0002',
                                name: 'Bob Smith',
                                grade: 'G.7',
                                className: 'Science'),
                            TeacherListItem(
                                date: '0003',
                                name: 'Charlie Brown',
                                grade: 'G.8',
                                className: 'History'),
                            TeacherListItem(
                                date: '0004',
                                name: 'David Lee',
                                grade: 'G.9',
                                className: 'English'),
                            TeacherListItem(
                                date: '0005',
                                name: 'Ella Green',
                                grade: 'G.5',
                                className: 'Physics'),
                          ],
                        ),
                      ),

                      // Button
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddTeacher()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Add Teacher',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
