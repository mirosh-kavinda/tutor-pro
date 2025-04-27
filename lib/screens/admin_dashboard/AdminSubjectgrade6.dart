import 'package:flutter/material.dart';
import 'package:tutorpro/screens/admin_dashboard/AG6MStudentList.dart';
import '../onboarding/onboarding_screen.dart';

class AdminSubjectgrade6 extends StatelessWidget {
  const AdminSubjectgrade6({super.key});

  void _onClassTap(BuildContext context, String className) {
    Widget targetScreen;

    switch (className.trim()) {
      case 'Mathematics':
        targetScreen = const Ag6mstudentlist(classId: 1);
        break;
      case 'Science':
        targetScreen = const Ag6mstudentlist(classId: 2);
        break;
      case 'English':
        targetScreen = const Ag6mstudentlist(classId: 3);
        break;
      case 'Sinhala':
        targetScreen = const Ag6mstudentlist(classId: 4);
        break;
      // Add more cases for other subjects if necessary
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
      {'label': 'Mathematics', 'image': 'assets/images/student_class.png'},
      {'label': 'Science', 'image': 'assets/images/student_class.png'},
      {'label': 'English', 'image': 'assets/images/student_class.png'},
      {'label': 'Sinhala', 'image': 'assets/images/student_class.png'},
    ];

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/adminsubject.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.4, // Limit image height
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
              height: MediaQuery.of(context).size.height * 0.7, // Adjust height
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Subject",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10), // Space between title and subtitle
                  const Text(
                    "Grade 6",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.white,
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
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  item['image']!,
                                  height: 120, // Adjust image size
                                  width: 120, // Adjust image size
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    item['label']!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
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
