import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';

class AddTeacher extends StatelessWidget {
  const AddTeacher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 640;
    final isMediumScreen = screenWidth <= 991;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: isMediumScreen ? screenWidth : 390,
          height: isMediumScreen ? null : 875,
          color: Colors.white,
          child: Stack(
            children: [
              // Background Image
              Positioned(
                top: 0,
                left: 0,
                child: Image.network(
                  'https://cdn.builder.io/api/v1/image/assets/TEMP/88e46901400bdfc8b22eb84c4e6ae5eaf025a7de?placeholderIfAbsent=true',
                  width: isMediumScreen ? screenWidth : 390,
                  height: isMediumScreen ? null : 270,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: isMediumScreen ? screenWidth : 390,
                      height: isMediumScreen ? screenWidth * 0.692 : 270,
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: isMediumScreen ? screenWidth : 390,
                      height: isMediumScreen ? screenWidth * 0.692 : 270,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.error_outline),
                      ),
                    );
                  },
                ),
              ),

              // Form Container
              Positioned(
                top: 270,
                left: isMediumScreen ? screenWidth * 0.1 : 55,
                child: Container(
                  width: isMediumScreen ? screenWidth * 0.8 : 279,
                  height: 459,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 31, left: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFormField('Name:'),
                        _buildFormField('Teacher ID:'),
                        _buildFormField('Date of Birth:'),
                        _buildFormField('Class:'),
                        _buildFormField('Subjects:'),
                        _buildFormField('Phone \'s No:'),

                      ],
                    ),
                  ),
                ),
              ),

              // Submit Button
              Positioned(
                top: 654,
                left: isMediumScreen ? screenWidth * 0.2 : 147,
                child: CustomButton(
                  width: isMediumScreen ? screenWidth * 0.6 : 170,
                  height: 45,
                  fontSize: isSmallScreen ? 12 : 14,
                  onPressed: () {
                    // Handle submit action
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}