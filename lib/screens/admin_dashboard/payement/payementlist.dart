import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutorpro/screens/admin_dashboard/payement/addpaymentscreen.dart';

import '../../../repository/admin_repository.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/download_pdf.dart';

class PaymentList extends StatelessWidget {
  final String className;
  const PaymentList({super.key, required this.className});


 void _downloadPDF(context, List<dynamic> mappedData) {
    if (mappedData.isNotEmpty){
  showDialog(
      context: context,
      builder: (context) => DownloadAttendanceDialog(data: mappedData,documentType: "payments",),
    );
    }
  
  }

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
              'assets/images/payemnet.png',
              fit: BoxFit.cover,
              height: 180,
            ),
          ),
          // Back arrow button
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Download button (Blue color)
      
          // Main content
          Column(
            children: [
              const SizedBox(height: 100),
          
              Expanded(
                child: _buildPaymentListSection(context, className),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(double totalPay, double remaining) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Text(
            "TOTAL PAYMENT: Rs.${totalPay.toString()}",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          Text(
            "Remaining: Rs.${remaining.toString()}",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentListSection(BuildContext context, String classId) {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchPayments(classId: className),
        builder: (context, snapshot) {

             if (snapshot.hasError) {
                        return const Center(
                            child: Text('Error loading payments',
                                style: TextStyle(color: Colors.white)));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final payments = snapshot.data!;

                      double totalPayments = payments.fold(0.0, (sum, payment) => sum + (payment['payment'] ?? 0.0));

                      if (payments.isEmpty) {
                        return const Center(
                          child: Text(
                            "No payment records found.",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/admin_backgroun.png'),
                fit: BoxFit.cover,
                opacity: 0.1,
              ),
              color: Color(0xFF0066CC),
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(
                            title: "Payment List",
                            onDownloadPressed: () =>
                                _downloadPDF(context, payments ?? [])),
                        const SizedBox(height: 10),
              
                _buildPaymentCard(20000,20000-totalPayments),
                const SizedBox(height: 10),
                
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pay Id",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text("Student Name",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text("Date",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child:  ListView.builder(
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
                                    color: Colors.white.withOpacity(0.2)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    payment['payment_id'] ?? '',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    payment['student_name'] ?? '',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    payment['date'] ?? '',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                 PaymentCollectionScreen(classId: className,)),
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
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
