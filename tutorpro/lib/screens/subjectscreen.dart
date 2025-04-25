import 'package:flutter/material.dart';

class SubjectsScreen extends StatelessWidget {
  final List<String> subjects = [
    'Mathematics',
    'Sinhala',
    'Science',
    'English'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Grade Header
            const Text('Grade 6',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                )),
            const SizedBox(height: 20),
            
            // Subjects List
            Expanded(
              child: ListView.separated(
                itemCount: subjects.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      subjects[index],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}