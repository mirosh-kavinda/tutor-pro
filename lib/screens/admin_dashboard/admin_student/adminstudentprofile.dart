import 'package:flutter/material.dart';
import 'package:tutorpro/screens/admin_dashboard/admin_student/AG6MStudentList.dart';
import 'package:tutorpro/screens/onboarding/onboarding_screen.dart';

import '../../../repository/admin_repository.dart';
import '../../../repository/student_repository.dart';

class Adminstudentprofile extends StatefulWidget {
  final String studetnId;
  const Adminstudentprofile({super.key, required this.studetnId});

  @override
  _AdminstudentprofileState createState() => _AdminstudentprofileState();
}

class _AdminstudentprofileState extends State<Adminstudentprofile> {
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> updatedData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getStudentData(studentId: widget.studetnId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred while fetching data.'),
            );
          }

          final studentData = snapshot.data;

          if (studentData == null) {
            return const Center(
              child: Text('No student data found.'),
            );
          }

          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/studentatte.png',
                  height: 250,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.logout_outlined, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 650,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/admin_backgroun.png'),
                      fit: BoxFit.cover,
                    ),
                    color: Color(0xFF0066CC),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: isEditing
                      ? _buildEditForm(studentData)
                      : _buildDetailsView(studentData),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDetailsView(Map<String, dynamic> studentData) {
    return Column(
      children: [
        const SizedBox(height: 20),
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
            studentData['profile_image_url'],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Hi ${studentData['student_name'] ?? 'Student'}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailText('Name :  ${studentData['student_name'] ?? 'Student'}'),
              const SizedBox(height: 10),
              _buildDetailText('Student Id:  ${studentData['student_id'] ?? 'N/A'}'),
              const SizedBox(height: 10),
              _buildDetailText('Date Of Birth: ${studentData['date_of_birth'] ?? 'N/A'}'),
              const SizedBox(height: 10),
              _buildDetailText('School: ${studentData['school'] ?? 'N/A'}'),
              const SizedBox(height: 10),
              _buildDetailText('Class: ${studentData['class'] ?? 'N/A'}'),
              const SizedBox(height: 10),
              _buildDetailText('Guardian’s Name: ${studentData['guardian_name'] ?? 'N/A'}'),
              const SizedBox(height: 10),
              _buildDetailText('Guardian’s Phone No: ${studentData['guardian_phone'] ?? 'N/A'}'),
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isEditing = true;
                          updatedData = Map.from(studentData);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () => deleteStudent(widget.studetnId, context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF265D72),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditForm(Map<String, dynamic> studentData) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              studentData['profile_image_url'],
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
              style: const TextStyle(color: Colors.white),
            initialValue: updatedData['student_name'],
            decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.white),labelText: 'Name'),
            onChanged: (value) => updatedData['student_name'] = value,
          ),
          const SizedBox(height: 10),
          TextFormField(
              style: const TextStyle(color: Colors.white),
            initialValue: updatedData['date_of_birth'],
            decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.white),labelText: 'Date of Birth'),
            onChanged: (value) => updatedData['date_of_birth'] = value,
          ),
          const SizedBox(height: 10),
          TextFormField(
              style: const TextStyle(color: Colors.white),
            initialValue: updatedData['school'],
            decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.white),labelText: 'School'),
            onChanged: (value) => updatedData['school'] = value,
          ),
          const SizedBox(height: 10),
          TextFormField(
              style: const TextStyle(color: Colors.white),
            initialValue: updatedData['class'],
            decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.white),labelText: 'Class'),
            onChanged: (value) => updatedData['class'] = value,
          ),
          const SizedBox(height: 10),
          TextFormField(
              style: const TextStyle(color: Colors.white),
            initialValue: updatedData['guardian_name'],
            decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.white),labelText: 'Guardian’s Name'),
            onChanged: (value) => updatedData['guardian_name'] = value,
          ),
          const SizedBox(height: 10),
          TextFormField(
              style: const TextStyle(color: Colors.white),
            initialValue: updatedData['guardian_phone'],
            decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.white),labelText: 'Guardian’s Phone No'),
            onChanged: (value) => updatedData['guardian_phone'] = value,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    // Submit the updated data
                   await updateStudentData(widget.studetnId, updatedData,context);
                    setState(() {
                      isEditing = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isEditing = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF265D72),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}