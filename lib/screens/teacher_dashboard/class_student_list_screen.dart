import 'package:flutter/material.dart';
import 'package:tutorpro/repository/teacher_repository.dart';
import '../../widgets/attendance_list_item.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/download_pdf.dart';
import 'class_student_attendance_screen.dart';

class ClassStudentListScreen extends StatefulWidget {
  final String classId;
  const ClassStudentListScreen({super.key, required this.classId});

  @override
  State<ClassStudentListScreen> createState() => _ClassStudentListScreenState();
}

class _ClassStudentListScreenState extends State<ClassStudentListScreen> {
  List<dynamic>? classData;
  List<dynamic>? originalClassData;

  void _downloadPDF(context, List<dynamic> mappedData) {
    if (mappedData.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => DownloadAttendanceDialog(
          data: mappedData,
          documentType: "studentlist",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;

          return Container(
            width: screenWidth,
            color: Colors.white,
            child: Stack(
              children: [
                // Background Image
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: screenWidth <= 640 ? 200 : 276,
                  child: Image.asset(
                    'assets/images/student_attendent_sheetheader.png',
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                // Main Content Container
                Positioned(
                  top: screenWidth <= 640 ? 200 : 276,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/home_teacher_gradient.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomAppBar(
                            title: "Student List",
                            onDownloadPressed: () => _downloadPDF(
                                context, classData?[0]['students'] ?? [])),

                        // Header Row
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth <= 640 ? 15 : 20),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'S.No',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 2 / 3,
                          child: const Divider(
                            color: Colors.grey,
                            thickness: 1,
                            height: 20,
                          ),
                        ),
                        // Attendance List
                        Expanded(
                          child: FutureBuilder<List<Map<String, dynamic>>>(
                            future:
                                fetchClassStudentData(classId: widget.classId),
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
                                    child:
                                        Text('No attendance records found.'));
                              } else {
                                // Store original attendance list once
                                if (originalClassData == null) {
                                  originalClassData = snapshot.data!;
                                  classData ??= snapshot.data!;
                                }

                                return classData == null || classData!.isEmpty
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
                                        itemCount:
                                            classData![0]['students']!.length,
                                        itemBuilder: (context, index) {
                                          final record =
                                              classData![0]['students'][index];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    record['student_id'],
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    record['student_name'],
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                              }
                            },
                          ),
                        ),
                        // View Payments Button
                        Padding(
                          padding: EdgeInsets.all(screenWidth <= 640 ? 15 : 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () async {
                                bool isExist =
                                    await isAttendanceSubmitted(widget.classId);
                                if (!isExist) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ClassStudentAttendanceScreen(
                                              classId: widget.classId,
                                              studentList: classData?[0]
                                                  ['students']??[],
                                            )),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                        "Attendance Already Submited For today",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      backgroundColor: Colors.red[400],
                                    ),
                                  );
                                }
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
                                'Mark Attendance',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
