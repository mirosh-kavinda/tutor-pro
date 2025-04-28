import 'package:flutter/material.dart';
import 'package:tutorpro/repository/admin_repository.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  // TextEditingControllers for each input field
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _teacherController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Method to create a schedule data map
  Map<String, dynamic> _getScheduleData() {
    return {
      'date': _dateController.text,
      'time': _timeController.text,
      'class': _classController.text,
      'teacher': _teacherController.text,
      'message': _messageController.text,
    };
  }

  @override
  void dispose() {
    // Dispose controllers to free resources
    _dateController.dispose();
    _timeController.dispose();
    _classController.dispose();
    _teacherController.dispose();
    _messageController.dispose();
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

  Future<void> _selectTime(BuildContext context) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (pickedTime != null) {
    setState(() {
      _timeController.text = pickedTime.format(context); // Format time as needed
    });
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
              'assets/images/shedulescreen.png', // Replace with your image path
              fit: BoxFit.cover,
              height: 190,
            ),
          ),
          // Back arrow button
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 7, 7, 7),
                size: 30,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Main content
          Column(
            children: [
              const SizedBox(height: 150), // Space for top image and back button
              Expanded(
                child: _buildFormSection(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for the form section
  Widget _buildFormSection(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0066CC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            _buildCustomDateField(
                                        "Date", _dateController),
          
          const SizedBox(height: 20),
         _buildCustomTimeField("Time", _timeController),
          const SizedBox(height: 20),
          _buildTextField(label: "Class :", controller: _classController),
          const SizedBox(height: 20),
          _buildTextField(label: "Teacher :", controller: _teacherController),
          const SizedBox(height: 20),
          _buildTextField(label: "Message :", controller: _messageController, isMessage: true),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Send message button logic
                  final scheduleData = _getScheduleData();
                  addschedule(scheduleData, context);
                  // Add logic to send the schedule data as a message
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  "SAVE",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
                
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.white,
              //     foregroundColor: Colors.blueAccent,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              //   ),
              //   child: const Text(
              //     "SEND MESSAGE",
              //     style: TextStyle(
              //       fontFamily: 'Poppins',
              //       fontSize: 14,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for each text field
  Widget _buildTextField({required String label, required TextEditingController controller, bool isMessage = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: isMessage ? 3 : 1, // Allow more lines for the Message field
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
  
  Widget _buildCustomDateField(String label, TextEditingController controller) {
    return  Container(
    color: Colors.white,
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
Widget _buildCustomTimeField(String label, TextEditingController controller) {
  return Container(
    color: Colors.white,
   
    child: TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        
        labelText: label,
        hintText: 'Select Time',
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 12), // Adjust padding here
        suffixIcon: IconButton(
          icon: const Icon(Icons.access_time, color: Colors.black),
          onPressed: () => _selectTime(context),
        ),
      ),
      onTap: () => _selectTime(context),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label is required';
        }
        return null;
      },
    ),
  );
}
}
