import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 640;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background Image
            Image.network(
              'https://cdn.builder.io/api/v1/image/assets/TEMP/88e46901400bdfc8b22eb84c4e6ae5eaf025a7de?placeholderIfAbsent=true',
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                
                if (loadingProgress == null) return child;
                return Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.error_outline),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Form Container
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFormField('Name:'),
                  _buildFormField('Student ID:'),
                  _buildFormField('Date of Birth:'),
                  _buildFormField('School:'),
                  _buildFormField('Class:'),
                  _buildFormField('Subjects:'),
                  _buildFormField('Guardian\'s Name:'),
                  _buildFormField('Guardian\'s Phone No:'),
                  const SizedBox(height: 20),

                  // Submit Button
                  Center(
                    child: CustomButton(
                      width: isSmallScreen ? 200 : 250,
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
          ],
        ),
      ),
    );
  }

  // Form Field builder
  Widget _buildFormField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}
