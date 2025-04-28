import 'package:flutter/material.dart';
import 'package:tutorpro/screens/admin_dashboard/admin_student/AG6MStudentList.dart';
import '../../../repository/admin_repository.dart';
import '../../onboarding/onboarding_screen.dart';
import '../payement/payementlist.dart';

class Adminstudent extends StatelessWidget {
  final bool isPayment;
  const Adminstudent({super.key, this.isPayment = false});

  void _onClassTap(
      BuildContext context, List<dynamic> students, String classId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => isPayment
              ? PaymentList(
                  className: classId,
                )
              : Ag6mstudentlist(
                  students: students,
                  classId: classId,
                )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchClassData(),
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
            final classData = snapshot.data;

            if (classData == null || classData.isEmpty) {
              return const Center(
                child: Text('No class data found.'),
              );
            }

            return Stack(
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/admin_backgroun.png'),
                        fit: BoxFit.cover,
                      ),
                      color: Color(0xFF0066CC),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 40),
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
                            itemCount: classData.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              childAspectRatio: 3 / 4,
                            ),
                            itemBuilder: (context, index) {
                              final item = classData[index];
                              return InkWell(
                                onTap: () => _onClassTap(context,
                                    item['students']!, item['class_id']!),
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
                                        'assets/images/student_class.png',
                                        height: 130,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
                                      const SizedBox(height: 15),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          item['class_name']!,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          item['subject']!,
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
            );
          }),
    );
  }

}
