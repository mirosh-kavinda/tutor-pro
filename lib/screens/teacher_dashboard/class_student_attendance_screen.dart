import 'package:flutter/material.dart';

import '../student_dahboard/student_payments.dart';
import 'teacher_profile.dart';

class ClassStudentAttendanceScreen extends StatefulWidget {
  const ClassStudentAttendanceScreen({super.key});

  @override
  State<ClassStudentAttendanceScreen> createState() =>
      _ClassStudentAttendanceScreenState();
}

class _ClassStudentAttendanceScreenState
    extends State<ClassStudentAttendanceScreen> {
  late List<Map<String, dynamic>> students;

  @override
  void initState() {
    super.initState();
    students = List.generate(
      8,
      (index) => {
        'name': 'Student ${index + 1}',
        'image': 'assets/images/Teacher3.png',
        'isPresent':
            null, // null means no selection, true for present, false for absent
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Top Image/Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/home_teacher_gradient.png'),
                  fit: BoxFit.cover,
                ),
                color: Color(0xFF0066CC),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    width: screenWidth * 2 / 3,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth <= 640 ? 15 : 20,
                      vertical: screenWidth <= 640 ? 15 : 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Date :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Image.network(
                          'https://cdn.builder.io/api/v1/image/assets/TEMP/ab740c0f7069c364ea2d25e2c7e3e09a38bf7bdc?placeholderIfAbsent=true',
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Attendance Sheet",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
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
                          flex: 3,
                          child: Text(
                            'Name',
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
                            'Present',
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
                            'Absent',
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
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                    height: 20,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return ListTile(
                          leading: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          title: Text(
                            student['name']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                fillColor: MaterialStateProperty.all(
                                  student['isPresent'] == true
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                value: student['isPresent'] == true,
                                onChanged: (value) {
                                  setState(() {
                                    students[index]['isPresent'] = true;
                                  });
                                },
                              ),
                              const SizedBox(width: 8),
                              Checkbox(
                                fillColor: MaterialStateProperty.all(
                                  student['isPresent'] == false
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                value: student['isPresent'] == false,
                                onChanged: (value) {
                                  setState(() {
                                    students[index]['isPresent'] = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenWidth <= 640 ? 15 : 20),
                    child: Align(
                      alignment: screenWidth <= 640
                          ? Alignment.center
                          : Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TeacherProfileCard()),
                            (_) => false,
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
                          'Submit',
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
  }
}
