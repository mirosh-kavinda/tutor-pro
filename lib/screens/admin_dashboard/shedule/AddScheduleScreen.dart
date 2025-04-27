import 'package:flutter/material.dart';

class AddScheduleScreen extends StatelessWidget {
  const AddScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/shedulescreen.png', // Replace with your image path
              fit: BoxFit.cover,
              height: 190,
            ),
          ),
          // Back arrow button
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 7, 7, 7),
                size: 30,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Main content
          Column(
            children: [
              const SizedBox(height: 150), // Space for top image and back button
              Expanded(
                child: _buildFormSection(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for the form section
  Widget _buildFormSection(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0066CC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(label: "Date :"),
          const SizedBox(height: 20),
          _buildTextField(label: "Time :"),
          const SizedBox(height: 20),
          _buildTextField(label: "Class :"),
          const SizedBox(height: 20),
          _buildTextField(label: "Teacher :"),
          const SizedBox(height: 20),
          _buildTextField(label: "Message :", isMessage: true),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),

                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  "SAVE",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  "SEND MESSAGE",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for each text field
  Widget _buildTextField({required String label, bool isMessage = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: isMessage ? 3 : 1, // Allow more lines for the Message field
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AddScheduleScreen(),
  ));
}