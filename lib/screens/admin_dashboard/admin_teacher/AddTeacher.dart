import 'package:flutter/material.dart';
import '../../../repository/admin_repository.dart';
import '../../../widgets/custom_button.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddTeacher extends StatefulWidget {
  const AddTeacher({super.key});

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  final _formKey = GlobalKey<FormState>();

  // TextEditingControllers for each input field
  final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
  final TextEditingController _teacherIdController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  List<Map<String, dynamic>> _classes = [];
  bool _isLoadingClasses = true;
 
 
  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
       final selectedClasses = _classes.map((classItem) {
      return {
        'class_id': classItem['class_id'],
        'class_name': classItem['class_name'],
        'class_logo_url': classItem['class_logo_url'],
      };
    }).toList();
      // Collect data from controllers
      final formData = {
        'email':_emailController.text,
        'teacher_name': _nameController.text,
        'teacher_id': _teacherIdController.text,
        'date_of_birth': _dateController.text,
        'classes':selectedClasses ,
        'phone_no': _phoneController.text,
      };

      await addTeacher(formData,context);
      // Handle form submission logic here
    }
  }

  @override
  void initState() {
    super.initState();
    fetchClassData().then((data) {
      setState(() {
        _classes = data;
        _isLoadingClasses = false;
      });
    }).catchError((error) {
      debugPrint('Error fetching class data: $error');
      setState(() {
        _isLoadingClasses = false;
      });
    });
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _nameController.dispose();
    _teacherIdController.dispose();
    _dateController.dispose();
   _emailController.dispose();
    _phoneController.dispose();
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
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _isLoadingClasses
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/adminteacherlist.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: screenHeight * 0.75,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/admin_backgroun.png'),
                        fit: BoxFit.cover,
                      ),
                      color: Color(0xFF0066CC),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40)),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 20,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: SingleChildScrollView(
                        // Added SingleChildScrollView

                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 31, left: 18, right: 18),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildCustomInputField(
                                        'Name', _nameController),
                                    _buildCustomInputField(
                                        'Teacher ID', _teacherIdController),
                                         _buildCustomInputField(
                                        'Email', _emailController),
                                    _buildCustomDateField(
                                        "DOB", _dateController),
                                    _buildClassMultiSelectField(
                                        "Classes", _classes),
                                   
                                    _buildCustomInputField(
                                        'Phone\'s No', _phoneController),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: _handleSubmit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF265D72),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildCustomInputField(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 12), // Adjust padding here
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          return null;
        },
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
