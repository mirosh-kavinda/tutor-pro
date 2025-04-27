import 'package:flutter/material.dart';
import 'package:tutorpro/screens/admin_dashboard/payement/payementlist.dart';

import 'package:tutorpro/screens/onboarding/onboarding_screen.dart';

class Payement2 extends StatelessWidget {
  const Payement2({super.key, required String className});

  // Navigation logic for class selection
  void _onClassTap(BuildContext context, String className) {
    final Map<String, Widget> classScreens = {
      'Mathemtics': const PaymentList(),
      'Sinhala': const PaymentList(),
      'Science': const PaymentList(),
      'English': const PaymentList(),
    };

    final targetScreen = classScreens[className] ?? const OnboardingScreen();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> classes = [
      {'label': 'Mathemtics', 'image': 'assets/images/student_class.png'},
      {'label': 'Sinhala', 'image': 'assets/images/student_class.png'},
      {'label': 'Science', 'image': 'assets/images/student_class.png'},
      {'label': 'English', 'image': 'assets/images/student_class.png'},
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Top background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/payemnet.png',
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
              const SizedBox(height: 100), // Space for top image and back button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildPaymentCard(),
              ),
              Expanded(
                child: _buildClassesSection(context, classes),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for the payment card
  Widget _buildPaymentCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        children: [
          Text(
            "TOTAL PAYMENT: Rs. 140,000",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Remaining: Rs. 20,000",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // Widget for the classes section
  Widget _buildClassesSection(BuildContext context, List<Map<String, String>> classes) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/admin_backgroun.png'),
          fit: BoxFit.cover,
        ),
        color: Color(0xFF0066CC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 43),
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
          const SizedBox(height: 20),
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
                return _buildClassCard(context, item);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget for each class card in the grid
  Widget _buildClassCard(BuildContext context, Map<String, String> item) {
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
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}