import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  void _handleButtonTap(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label clicked')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> gridItems = [
      {'label': 'Teacher', 'image': 'assets/images/teacher.png'},
      {'label': 'Student', 'image': 'assets/images/student.png'},
      {'label': 'Payment', 'image': 'assets/images/payment.png'},
      {'label': 'Schedule', 'image': 'assets/images/schedule.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: gridItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final item = gridItems[index];
            return InkWell(
              onTap: () => _handleButtonTap(context, item['label']!),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      item['image']!,
                      height: 80,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item['label']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
