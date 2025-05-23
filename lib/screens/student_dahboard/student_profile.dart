import 'package:flutter/material.dart';
import '../../repository/handleAuthLogin.dart';
import '../../repository/student_repository.dart';
import 'students_attendance.dart';

class StudentProfileCard extends StatelessWidget {
  const StudentProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getStudentData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred while fetching data.'),
            );
          }

          final studentData = snapshot.data;

          if (studentData == null) {
            return const Center(
              child: Text('No student data found.'),
            );
          }
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/home_student_cover.png',
                  height: 250,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: IconButton(
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed:()=>AuthSignout(context),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 650,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/home_student_gradient.png'),
                      fit: BoxFit.cover,
                    ),
                    color: Color(0xFF0066CC),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          studentData['profile_image_url'],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Hi ${studentData['student_name'] ?? 'Student'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailText('Student ID: ${studentData['student_id'] ?? 'N/A'}'),
                            const SizedBox(height: 10),
                            _buildDetailText('Date of Birth: ${studentData['date_of_birth'] ?? 'N/A'}'),
                            const SizedBox(height: 10),
                            _buildDetailText('School: ${studentData['school'] ?? 'N/A'}'),
                            const SizedBox(height: 10),
                            _buildDetailText('Class: ${studentData['class'] ?? 'N/A'}'),
                            const SizedBox(height: 10),
                        
                            _buildDetailText('Guardian’s Name: ${studentData['guardian_name'] ?? 'N/A'}'),
                            const SizedBox(height: 10),
                            _buildDetailText('Guardian’s Phone No: ${studentData['guardian_phone'] ?? 'N/A'}'),
                            const SizedBox(height: 10),
                             _buildDetailText('Subjects: ${studentData['subjects'].take(2).join(', ')}${studentData['subjects'].length > 2 ? '...' : ''}',),
                             
 
                            const SizedBox(height: 30),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AttendanceSheetScreen(studentID: studentData['student_id'],),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF265D72),
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'VIEW ATTENDANCE',
                                  style: TextStyle(
                                    color: Colors.white,
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

  Widget _buildDetailText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}


