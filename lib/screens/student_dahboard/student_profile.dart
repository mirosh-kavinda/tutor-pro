import 'package:flutter/material.dart';
import 'package:tutorpro/screens/onboarding/onboarding_screen.dart';

import 'students_attendance.dart';

class StudentProfileCard extends StatelessWidget {
  const StudentProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              icon: const Icon(Icons.logout_outlined, color:Colors.black ,size: 30,),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnboardingScreen(),
                  ),
                  (route) =>
                      false, // This ensures all previous routes are removed
                );
              },
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
                  fit: BoxFit
                      .cover, // Adjust the fit as needed (cover, contain, etc.)
                ),
                color: Color(0xFF0066CC), // Optional background color
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Profile Picture
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://cdn.builder.io/api/v1/image/assets/TEMP/7886357d2123a98c922b28ff8036ce34175bbd44?placeholderIfAbsent=true',
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Welcome Text
                  const Text(
                    'Hi Mr. Avishka!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Details Card
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
                        _buildDetailText('Student ID: Lorem Ipsum'),
                        const SizedBox(height: 10),
                        _buildDetailText('Date of Birth: Lorem Ipsum'),
                        const SizedBox(height: 10),
                        _buildDetailText('School: Lorem Ipsum'),
                        const SizedBox(height: 10),
                        _buildDetailText('Class: Lorem Ipsum'),
                        const SizedBox(height: 10),
                        _buildDetailText('Subjects: Lorem Ipsum'),
                        const SizedBox(height: 10),
                        _buildDetailText('Guardian’s Name: Lorem Ipsum'),
                        const SizedBox(height: 10),
                        _buildDetailText('Guardian’s Phone No: Lorem Ipsum'),
                        const SizedBox(height: 20),
                        // View Attendance Button
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AttendanceSheetScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF265D72),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'VIEW ATTENDENCE', // You may want to correct spelling: ATTENDANCE
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
