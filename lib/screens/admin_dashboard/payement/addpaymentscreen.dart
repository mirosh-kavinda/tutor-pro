import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentCollectionScreen extends StatefulWidget {
  const PaymentCollectionScreen({super.key});

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
    paymentsCollection.add({
      'sNo': '000${DateTime.now().millisecondsSinceEpoch % 1000}', // sample serial number
      'name': nameController.text,
      'studentId': studentIdController.text,
      'payment': paymentController.text,
      'paymentMonth': paymentMonthController.text,
      'lastPayment': 'paid',
    });

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
                ),
                TextField(
                  controller: paymentMonthController,
                  decoration: const InputDecoration(labelText: 'Payment Month'),
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