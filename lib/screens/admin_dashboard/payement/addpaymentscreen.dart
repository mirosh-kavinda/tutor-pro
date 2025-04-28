import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class PaymentCollectionScreen extends StatefulWidget {
  final String classId;
  const PaymentCollectionScreen({super.key, required this.classId});

  @override
  State<PaymentCollectionScreen> createState() => _PaymentCollectionScreenState();
}

class _PaymentCollectionScreenState extends State<PaymentCollectionScreen> {
  final CollectionReference paymentsCollection =
      FirebaseFirestore.instance.collection('payments');

  // Text controllers for the form
  final TextEditingController nameController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();
  final TextEditingController paymentMonthController = TextEditingController();

  void _addPayment() {
     final today = DateTime.now();
    final formattedDate = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
   
    paymentsCollection.add({
      'payment_id': '000${DateTime.now().millisecondsSinceEpoch % 1000}',
      'student_name': nameController.text,
      'studentId': studentIdController.text,
      'payment':num.parse(paymentController.text),
      'date': formattedDate,
      'class_id': widget.classId,
    });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'Payment added successfully!',
          style: TextStyle(
              fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[400],
      ));
      
      
    // Clear the text fields after saving
    nameController.clear();
    studentIdController.clear();
    paymentController.clear();
    paymentMonthController.clear();
  }

  void _showAddPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Payment'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: studentIdController,
                  decoration: const InputDecoration(labelText: 'Student ID'),
                ),
               TextField(
  controller: paymentController,
  decoration: const InputDecoration(labelText: 'Payment'),
  keyboardType: TextInputType.number,
  inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Restrict input to numbers only
),
              
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addPayment();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment added successfully!')),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Payment'),
        backgroundColor: const Color(0xFF265D72),
      ),
      body: const Center(
        child: Text(
          'No records to display here.\nUse the + button to add new payments.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPaymentDialog,
        backgroundColor: const Color(0xFF265D72),
        child: const Icon(Icons.add),
      ),
    );
  }
}