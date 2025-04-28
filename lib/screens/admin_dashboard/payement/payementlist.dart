import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutorpro/screens/admin_dashboard/payement/addpaymentscreen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PaymentList extends StatelessWidget {
  const PaymentList({super.key, required String className});

  Future<void> _generateAndDownloadPDF(BuildContext context) async {
    final pdf = pw.Document();
    final paymentsSnapshot = await FirebaseFirestore.instance.collection('payments').get();
    final payments = paymentsSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Payment List', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ['S.No', 'Name', 'Last Payment'],
                data: payments.map((payment) => [
                  payment['sNo'] ?? '',
                  payment['name'] ?? '',
                  payment['lastPayment'] ?? '',
                ]).toList(),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference paymentsCollection =
        FirebaseFirestore.instance.collection('payments');

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
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.download, color: Colors.blue, size: 30),
              onPressed: () => _generateAndDownloadPDF(context),
            ),
          ),
          // Main content
          Column(
            children: [
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildPaymentCard(),
              ),
              Expanded(
                child: _buildPaymentListSection(context, paymentsCollection),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      child: const Column(
        children: [
          Text(
            "TOTAL PAYMENT: Rs. 140,000",
            style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          Text(
            "Remaining: Rs. 20,000",
            style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentListSection(BuildContext context, CollectionReference paymentsCollection) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Grade 6 > Mathematics",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Payment Details",
            style: TextStyle(fontFamily: 'Poppins', fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("S.No", style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
              Text("Name", style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
              Text("Last Payment", style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: paymentsCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading payments', style: TextStyle(color: Colors.white)));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final payments = snapshot.data!.docs;

                if (payments.isEmpty) {
                  return const Center(
                    child: Text(
                      "No payment records found.",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: payments.length,
                  itemBuilder: (context, index) {
                    final payment = payments[index];
                    final data = payment.data() as Map<String, dynamic>;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data['sNo'] ?? '',
                              style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.white),
                            ),
                            Text(
                              data['name'] ?? '',
                              style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.white),
                            ),
                            Text(
                              data['lastPayment'] ?? '',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: (data['lastPayment'] == 'Paid') ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
                  MaterialPageRoute(builder: (context) => const PaymentCollectionScreen()),
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
                style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}