import 'package:flutter/material.dart';
import 'package:tutorpro/screens/admin_dashboard/AG6MStudentList.dart';
import 'package:tutorpro/screens/onboarding/onboarding_screen.dart';

class Adminstudentprofile extends StatelessWidget {
  const Adminstudentprofile({super.key});

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
              'assets/images/studentatte.png',
              height: 250,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.logout_outlined, color: Colors.black, size: 30),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnboardingScreen(),
                  ),
                  (route) => false, // This ensures all previous routes are removed
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
                  image: AssetImage('assets/images/admin_backgroun.png'),
                  fit: BoxFit.cover,
                ),
                color: Color(0xFF0066CC),
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
                        _buildDetailText('Name : Thepuli'),
                        const SizedBox(height: 10),
                        _buildDetailText('Student Id: 001'),
                        const SizedBox(height: 10),
                        _buildDetailText('Date Of Birth: 2002.06.21'),
                        const SizedBox(height: 10),
                        _buildDetailText('School: SMV'),
                        const SizedBox(height: 10),
                        _buildDetailText('Class: Grade 6'),
                        const SizedBox(height: 10),
                        _buildDetailText('Subject: English'),
                        const SizedBox(height: 20),

                        // Buttons Row: Update and Delete
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Handle Update button press here
                                  // For now showing a snackbar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Update button pressed')),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF4CAF50), // Green color for Update
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Update',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20), // Space between buttons
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Ag6mstudentlist(classId: 1),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF265D72), // Color for Delete
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
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
