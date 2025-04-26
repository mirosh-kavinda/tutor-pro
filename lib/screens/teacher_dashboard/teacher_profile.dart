import 'package:flutter/material.dart';

import '../onboarding/onboarding_screen.dart';
import 'class_student_list_screen.dart';

class TeacherProfileCard extends StatelessWidget {
  const TeacherProfileCard({super.key});

  void _onClassTap(BuildContext context, String className, int index) {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClassStudentListScreen(classId:index)),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$className clicked')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> classes = [
      {'label': 'Grade 6 Mathematics', 'image': 'assets/images/student_class.png'},
      {'label': 'Grade 7 Mathematics', 'image': 'assets/images/student_class.png'},
      {'label': 'Grade 8 Mathematics', 'image': 'assets/images/student_class.png'},
      {'label': 'Grade 9 Mathematics', 'image': 'assets/images/student_class.png'},
    ];

    return Scaffold(
      body: Stack(
        children: [
         Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/home_student_header.png',
              fit: BoxFit.cover,
            ),
          ),
           Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.logout_outlined, color:Colors.white ,size: 30,),
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/home_teacher_gradient.png'),
                  fit: BoxFit.cover, // Adjust the fit as needed (cover, contain, etc.)
                ),
                color: Color(0xFF0066CC), // Optional background color
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Hi Ms. Asheni!",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Here's your classes",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
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
                          onTap: () => _onClassTap(context, item['label']!,index),
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