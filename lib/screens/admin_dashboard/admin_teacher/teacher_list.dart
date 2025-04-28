import 'package:flutter/material.dart';
import 'package:tutorpro/screens/admin_dashboard/admin_teacher/AddTeacher.dart';
import 'package:tutorpro/widgets/teacher_list.dart';

import '../../../repository/admin_repository.dart';

class TeacherListScreen extends StatelessWidget {
  TeacherListScreen({super.key});
  List<dynamic>? teachersData;
  List<dynamic>? originalTeachersData;
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
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align text to start
                          children: [
                            const Text(
                              "Teacher List",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                                height: 4), // space between text and line
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
                            horizontal: 14, vertical: 10),
                        color: Colors.black.withOpacity(0.3),
                        child: const Row(
                          children: [
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
                              flex: 4,
                              child: Text(
                                'Classes',
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

                      Expanded(
                        child: FutureBuilder<List<Map<String, dynamic>>>(
                          future: fetchTeachersData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                  child: Text('No attendance records found.'));
                            } else {
                              // Store original attendance list once
                              if (originalTeachersData == null) {
                                originalTeachersData = snapshot.data!;
                                teachersData ??= snapshot.data!;
                              }

                              return teachersData == null ||
                                      teachersData!.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'No records found.',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      padding: const EdgeInsets.only(top: 10),
                                      itemCount: teachersData!.length,
                                      itemBuilder: (context, index) {
                                        final record = teachersData![index];
                                        return TeacherListItem(
                                          date: record['teacher_id'] ??
                                              "Unknown Data",
                                          name: record['teacher_name'] ??
                                              "Unknown Data",
                                          className: record['classes']
                                              .map((classItem) =>
                                                  classItem['class_name']
                                                      .toString())
                                              .join(', '),
                                        );
                                      });
                            }
                          },
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
