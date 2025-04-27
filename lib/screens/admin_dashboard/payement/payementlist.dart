import 'package:flutter/material.dart';
import 'package:tutorpro/screens/admin_dashboard/payement/addpaymentscreen.dart';

class PaymentList extends StatelessWidget {
  const PaymentList({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> payments = [
      {'sNo': '0001', 'name': 'Lorem Spein', 'status': 'Paid'},
      {'sNo': '0002', 'name': 'John Doe', 'status': 'Unpaid'},
      {'sNo': '0003', 'name': 'Jane Smith', 'status': 'Paid'},
      {'sNo': '0004', 'name': 'Mary Johnson', 'status': 'Paid'},
      {'sNo': '0005', 'name': 'Peter Brown', 'status': 'Unpaid'},
      {'sNo': '0006', 'name': 'Lucy Green', 'status': 'Paid'},
      {'sNo': '0007', 'name': 'Samuel Clark', 'status': 'Paid'},
      {'sNo': '0008', 'name': 'Ella White', 'status': 'Paid'},
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
              'assets/images/payemnet.png', // Replace with your image path
              fit: BoxFit.cover,
              height: 180,
            ),
          ),
          // Back arrow button
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
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
                child: _buildPaymentListSection(context, payments),
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
              fontSize: 18,
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

  // Widget for the payment list section
  Widget _buildPaymentListSection(BuildContext context, List<Map<String, String>> payments) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/admin_backgroun.png'), // Replace with your image path
          fit: BoxFit.cover,
          opacity: 0.1, // Reduce the opacity for subtle background effect
        ),
        color: Color(0xFF0066CC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Grade 6 > Mathematics",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), // Add spacing between rows
          const Text(
            "Payment Details",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 20),
          // Payment Table Header
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "S.No",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Name",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Last Payment",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Payment Table Rows
          Expanded(
            child: ListView.builder(
              itemCount: payments.length,
              itemBuilder: (context, index) {
                final payment = payments[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          payment['sNo']!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          payment['name']!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          payment['status']!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: payment['status'] == 'Paid'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // "Add Another Payment" Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddPaymentScreen()),
                  );
                      },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "ADD ANOTHER PAYMENT",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
