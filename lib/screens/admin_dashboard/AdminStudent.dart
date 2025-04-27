import 'package:flutter/material.dart';
import 'package:tutorpro/screens/admin_dashboard/AdminSubjectgrade6.dart';

import '../onboarding/onboarding_screen.dart';

class Adminstudent extends StatelessWidget {
  const Adminstudent({super.key});

  void _onClassTap(BuildContext context, String className) {
    Widget targetScreen;

    switch (className.trim()) {
      case 'Grade 6':
        targetScreen = const AdminSubjectgrade6();
        break;
      case 'Grade 7':
        targetScreen = const AdminSubjectgrade6();
        break;
      case 'Grade 8':
        targetScreen = const AdminSubjectgrade6();
        break;
      case 'Grade 9':
        targetScreen = const AdminSubjectgrade6();
        break;
      default:
        targetScreen = const OnboardingScreen(); // fallback if class not found
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> classes = [
      {'label': 'Grade 6', 'image': 'assets/images/student_class.png'},
      {'label': 'Grade 7', 'image': 'assets/images/student_class.png'},
      {'label': 'Grade 8', 'image': 'assets/images/student_class.png'},
      {'label': 'Grade 9', 'image': 'assets/images/student_class.png'},
    ];

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/adminstudent.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.logout_outlined, color: Colors.white, size: 30),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/admin_backgroun.png'),
                  fit: BoxFit.cover,
                ),
                color: Color(0xFF0066CC),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Classes",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: classes.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (context, index) {
                        final item = classes[index];
                        return InkWell(
                          onTap: () => _onClassTap(context, item['label']!),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[800],
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
                                  width: 150,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    item['label']!,
                                    textAlign: TextAlign.start,
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
