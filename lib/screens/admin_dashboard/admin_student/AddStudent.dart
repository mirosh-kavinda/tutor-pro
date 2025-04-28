import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../../repository/admin_repository.dart';
import '../../../widgets/custom_button.dart';

class AddStudent extends StatefulWidget {
  final String classId;
  const AddStudent({super.key,  required this.classId});

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _nameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _schoolController = TextEditingController();
  final _classController = TextEditingController();
  final _guardianNameController = TextEditingController();
  final _guardianPhoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _nameController.dispose();
    _studentIdController.dispose();
    _schoolController.dispose();
  _guardianNameController.dispose();
    _guardianPhoneController.dispose();
    _dateController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  
  @override
  void initState() {
    super.initState();
   
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 640;

    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background Image
            Image.asset(
              'assets/images/adminliststudent.png',
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 20),

            // Form Container
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormField('Name:', _nameController, (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name';
                      }
                      return null;
                    }),
                    _buildFormField('Email:', _emailController, (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the email Address';
                      }
                      return null;
                    }),
                    _buildFormField('Student ID:', _studentIdController, (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the student ID';
                      }
                      return null;
                    }),
                      _buildCustomDateField(
                                        "Date of Birth:", _dateController),
                    
                    _buildFormField('School:', _schoolController, (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the school name';
                      }
                      return null;
                    }),
                   
                    _buildFormField('Guardian\'s Name:', _guardianNameController, (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the guardian\'s name';
                      }
                      return null;
                    }),
                    _buildFormField('Guardian\'s Phone No:', _guardianPhoneController, (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the guardian\'s phone number';
                      }
                      if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    }),
                    const SizedBox(height: 20),

                    // Submit Button
                    Center(
                      child: CustomButton(
                        width: isSmallScreen ? 200 : 250,
                        height: 45,
                        fontSize: isSmallScreen ? 12 : 14,
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
          
                            // Collect form data
                            final studentData = {
                              'student_name': _nameController.text,
                              'student_id': _studentIdController.text,
                              'date_of_birth': _dateController.text,
                              'school': _schoolController.text,
                              'class': _classController.text,
                            
                              'guardian_name': _guardianNameController.text,
                              'guardian_phone': _guardianPhoneController.text,
                              'email':_emailController.text,
                              'profile_image_url':"https://media.istockphoto.com/id/1335941248/photo/shot-of-a-handsome-young-man-standing-against-a-grey-background.jpg?s=612x612&w=0&k=20&c=JSBpwVFm8vz23PZ44Rjn728NwmMtBa_DYL7qxrEWr38="
                            };

                            // Handle submit action
                           await  addStudent(studentData,context,widget.classId);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Form Field builder with validation
  Widget _buildFormField(String label, TextEditingController controller, String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }

  
  Widget _buildCustomDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Select Date',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 12), // Adjust padding here
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.black),
            onPressed: () => _selectDate(context),
          ),
        ),
        onTap: () => _selectDate(context),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildClassMultiSelectField(
    String label, List<Map<String, dynamic>> classes) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4), // Reduced padding
    child: MultiSelectDialogField(
      dialogHeight: 400,
      items: classes.map((classItem) {
        return MultiSelectItem<String>(
          classItem['class_id'].toString(),
          classItem['class_name'],
        );
      }).toList(),
      title: Text(
        label,
        style: const TextStyle(fontSize: 14), // Reduced font size
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      buttonText: Text(
        label,
        style: const TextStyle(fontSize: 14), // Reduced font size
      ),
      onConfirm: (selectedValues) {
        // Handle selected values
        debugPrint('Selected class IDs: $selectedValues');
      },
      validator: (selectedValues) {
        if (selectedValues == null || selectedValues.isEmpty) {
          return '$label is required';
        }
        return null;
      },
    ),
  );
}
}




