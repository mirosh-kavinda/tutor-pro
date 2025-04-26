import 'package:flutter/material.dart';
import '../../widgets/attendance_list_item.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/payment_list_item.dart';
import 'student_profile.dart';

class StudentPaymentSheet extends StatelessWidget {
  const StudentPaymentSheet({super.key});

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
                            'assets/images/home_student_gradient.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomAppBar(
                          title: "Payment History",
                        ),
                        // Date Section
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
                                  'Month',
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
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth <= 640 ? 15 : 20,
                            ),
                            child: ListView(
                              children: const [
                                PaymentListItem(
                                    date: '01/01/25', name: 'Lorem spein'),
                                PaymentListItem(
                                  date: '01/01/25',
                                  name: 'Lorem spein',
                                ),
                                PaymentListItem(
                                    date: '01/01/25', name: 'Lorem spein'),
                                PaymentListItem(
                                    date: '01/01/25', name: 'Lorem spein'),
                                PaymentListItem(
                                    date: '01/01/25', name: 'Lorem spein'),
                              ],
                            ),
                          ),
                        ),
                        // View Payments Button
                        Padding(
                          padding: EdgeInsets.all(screenWidth <= 640 ? 15 : 20),
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
                                        const StudentProfileCard(),
                                  ),
                                  (route) =>
                                      false, // This ensures all previous routes are removed
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
                                'Exit',
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
