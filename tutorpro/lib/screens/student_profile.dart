import 'package:flutter/material.dart';

class StudentProfileCard extends StatelessWidget {
  const StudentProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isSmallScreen = maxWidth <= 640;

        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 480),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              // Top Image
              Image.network(
                'https://cdn.builder.io/api/v1/image/assets/TEMP/916f98fc40ab732ce1212c4d05539fa755f8db37?placeholderIfAbsent=true',
                width: double.infinity,
                fit: BoxFit.contain,
                height: (480 / 1.34), // Maintaining aspect ratio of 1.34
              ),
              // Profile Section with Background
              Transform.translate(
                offset: const Offset(0, -88),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(55, 36, 55, 94),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Background Image
                      Positioned.fill(
                        child: Image.network(
                          'https://cdn.builder.io/api/v1/image/assets/TEMP/ce9a8b569f602e93445123c29a079d3bced2eb60?placeholderIfAbsent=true',
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Content
                      Column(
                        children: [
                          // Profile Picture
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage('https://cdn.builder.io/api/v1/image/assets/TEMP/7886357d2123a98c922b28ff8036ce34175bbd44?placeholderIfAbsent=true'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Name
                          const Text(
                            'Hi Mr. Avishka!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 22),
                          // Details Container
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              left: isSmallScreen ? -3 : 0,
                            ),
                            padding: const EdgeInsets.fromLTRB(19, 37, 9, 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetailText('Student ID: Lorem Ipsum'),
                                const SizedBox(height: 16),
                                _buildDetailText('Date of Birth: Lorem Ipsum'),
                                const SizedBox(height: 16),
                                _buildDetailText('School: Lorem Ipsum'),
                                const SizedBox(height: 16),
                                _buildDetailText('Class: Lorem Ipsum'),
                                const SizedBox(height: 16),
                                _buildDetailText('Subjects: Lorem Ipsum'),
                                const SizedBox(height: 16),
                                _buildDetailText('Guardian\'s Name: Lorem Ipsum'),
                                const SizedBox(height: 16),
                                _buildDetailText('Guardian\'s Phone No: Lorem Ipsum'),
                                const SizedBox(height: 20),
                                // View Attendance Button
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF265D72),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 19,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'VIEW ATTENDENCE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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