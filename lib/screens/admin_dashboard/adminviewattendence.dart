import 'package:flutter/material.dart';
import 'admin_student/AG6MStudentList.dart';

class Adminviewattendence extends StatefulWidget {
  final List<dynamic> students;
  const Adminviewattendence({super.key, required this.students});

  @override
  State<Adminviewattendence> createState() => _AdminviewattendenceState();
}

class _AdminviewattendenceState extends State<Adminviewattendence> {
  
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
 
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/student_attendent_sheetheader.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/home_teacher_gradient.png'),
                  fit: BoxFit.cover,
                ),
                color: Color(0xFF0066CC),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Ag6mstudentlist(students: widget.students,classId: "",)),
                  );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Student List',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _pickDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            // 'Date: ${DateFormat('dd-MMM-yyyy').format(selectedDate)}',"",
                            "",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Image.network(
                            'https://cdn.builder.io/api/v1/image/assets/TEMP/ab740c0f7069c364ea2d25e2c7e3e09a38bf7bdc?placeholderIfAbsent=true',
                            width: 25,
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Attendance Sheet",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Download functionality
                        },
                        icon: const Icon(Icons.download, color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey, thickness: 1),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    color: Colors.white.withOpacity(0.3),
                    child: const Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'S.No',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            'Name',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Present',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Absent',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: ListView.separated(
                      itemCount: widget.students.length,
                      separatorBuilder: (context, index) => const Divider(color: Colors.white30),
                      itemBuilder: (context, index) {
                        final student = widget.students[index];
                        bool isMarked = student['isPresent'] != null;
                        return Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                '00${index + 1}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                student['name'],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Checkbox(
                                fillColor: WidgetStateProperty.all(
                                  student['isPresent'] == true ? Colors.green : Colors.grey,
                                ),
                                value: student['isPresent'] == true,
                                onChanged: isMarked
                                    ? null
                                    : (value) {
                                        setState(() {
                                          widget.students[index]['isPresent'] = value == true ? true : null;
                                        });
                                      },
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Checkbox(
                                fillColor: WidgetStateProperty.all(
                                  student['isPresent'] == false ? Colors.red : Colors.grey,
                                ),
                                value: student['isPresent'] == false,
                                onChanged: isMarked
                                    ? null
                                    : (value) {
                                        setState(() {
                                          widget.students[index]['isPresent'] = value == true ? false : null;
                                        });
                                      },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Exit',
                          style: TextStyle(
                            color: Colors.black,
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
        ],
      ),
    );
  }
}
