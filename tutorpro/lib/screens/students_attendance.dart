import 'package:flutter/material.dart';
import '../widgets/attendance_list_item.dart';
import '../widgets/custom_app_bar.dart';

class AttendanceSheetScreen extends StatelessWidget {
  const AttendanceSheetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width <= 640;

    return Scaffold(
      body: Container(
        width: isSmallScreen ? screenSize.width : 390,
        color: Colors.white,
        child: Stack(
          children: [
            // Background Image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: isSmallScreen ? 200 : 276,
              child: Image.network(
                'https://cdn.builder.io/api/v1/image/assets/TEMP/ca1ad0c1932f132688a81e83f85e5f1f2c0c5898?placeholderIfAbsent=true',
                fit: BoxFit.cover,
              ),
            ),
            // Main Content Container
            Positioned(
              top: isSmallScreen ? 200 : 276,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://cdn.builder.io/api/v1/image/assets/TEMP/7536ccb4f06be5fe3f8eb08dfe81934a36b7f6c8?placeholderIfAbsent=true'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppBar(),
                    // Date Section
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 15 : 20,
                        vertical: isSmallScreen ? 15 : 20,
                      ),
                      child: Row(
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 15 : 20,
                      ),
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 60,
                            child: Text(
                              'S.No',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              'Name',
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
                    // Attendance List
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 15 : 20,
                        ),
                        child: ListView(
                          children: const [
                            AttendanceListItem(
                              date: '01/01/25',
                              name: 'Lorem spein',
                              isPresent: false,
                            ),
                            AttendanceListItem(
                              date: '01/01/25',
                              name: 'Lorem spein',
                              isPresent: true,
                            ),
                            AttendanceListItem(
                              date: '01/01/25',
                              name: 'Lorem spein',
                              isPresent: true,
                            ),
                            AttendanceListItem(
                              date: '01/01/25',
                              name: 'Lorem spein',
                              isPresent: true,
                            ),
                            AttendanceListItem(
                              date: '01/01/25',
                              name: 'Lorem spein',
                              isPresent: true,
                            ),
                            AttendanceListItem(
                              date: '01/01/25',
                              name: 'Lorem spein',
                              isPresent: true,
                            ),
                            AttendanceListItem(
                              date: '01/01/25',
                              name: 'Lorem spein',
                              isPresent: false,
                            ),
                            AttendanceListItem(
                              date: '01/01/25',
                              name: 'Lorem spein',
                              isPresent: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // View Payments Button
                    Padding(
                      padding: EdgeInsets.all(isSmallScreen ? 15 : 20),
                      child: Align(
                        alignment: isSmallScreen
                            ? Alignment.center
                            : Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'VIEW PAYMENTS',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
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
      ),
    );
  }
}