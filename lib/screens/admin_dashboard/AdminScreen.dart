import 'package:flutter/material.dart';
import 'package:tutorpro/screens/admin_dashboard/payement/payement1.dart';
import 'package:tutorpro/screens/admin_dashboard/shedule/shedulescreen.dart';
import '../onboarding/onboarding_screen.dart';
import 'admin_teacher/teacher_list.dart';
import 'admin_student/AdminStudent.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  void _onGridItemTap(BuildContext context, String label, int index) {
    if (label == 'Teacher') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  TeacherListScreen(),
        ),
      );
    } else if (label == 'Student') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const Adminstudent(), // you can change classId if needed
        ),
      );
    } else if (label == 'Payment') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const Payement1(), // you can change classId if needed
        ),
      );
    } else if (label == 'Schedule') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ScheduleScreen (), // you can change classId if needed
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$label clicked')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> gridItems = [
      {'label': 'Teacher', 'image': 'assets/images/teacher.png'},
      {'label': 'Student', 'image': 'assets/images/student.png'},
      {'label': 'Payment', 'image': 'assets/images/payment.png'},
      {'label': 'Schedule', 'image': 'assets/images/schedule.png'},
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/adminLogin.png',
              fit: BoxFit.cover,
            ),
          ),
          // Logout button
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.logout_outlined,
                  color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnboardingScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
          ),
          // Main Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/admin_backgroun.png'),
                  fit: BoxFit.cover,
                ),
                color: Color(0xFF8E7EC6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Hi Mr. Admin!",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Here's your options",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: gridItems.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (context, index) {
                        final item = gridItems[index];
                        return InkWell(
                          onTap: () =>
                              _onGridItemTap(context, item['label']!, index),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(2, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  item['image']!,
                                  height: 130,
                                  width: 140,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    item['label']!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
