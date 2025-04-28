import 'package:flutter/material.dart';
import '../../repository/student_repository.dart';
import '../../widgets/attendance_list_item.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/download_pdf.dart';
import 'student_payments.dart';

class AttendanceSheetScreen extends StatefulWidget {
  final String? studentID;
  final String? classID;
  const AttendanceSheetScreen({super.key,  this.studentID, this.classID});

  @override
  _AttendanceSheetScreenState createState() => _AttendanceSheetScreenState();
}

class _AttendanceSheetScreenState extends State<AttendanceSheetScreen> {
  DateTime? fromDate;
  DateTime? toDate;
  List<dynamic>? attendanceData;
  List<dynamic>? originalAttendanceData;

  void _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: fromDate != null && toDate != null
          ? DateTimeRange(start: fromDate!, end: toDate!)
          : null,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        fromDate = picked.start;
        toDate = picked.end;
        _filterAttendanceByDateRange(fromDate!, toDate!);
      });
    }
  }

  void _filterAttendanceByDateRange(DateTime from, DateTime to) {
    if (originalAttendanceData == null) return;

    final filteredData = originalAttendanceData!.where((record) {
      final recordDate = DateTime.parse(record['date']);
      return (recordDate.isAtSameMomentAs(from) || recordDate.isAfter(from)) &&
          (recordDate.isAtSameMomentAs(to) || recordDate.isBefore(to));
    }).toList();

    setState(() {
      attendanceData = filteredData;
    });
  }

  void _clearDateFilter() {
    setState(() {
      fromDate = null;
      toDate = null;
      attendanceData = originalAttendanceData;
    });
  }

  void _downloadPDF(context, List<dynamic> mappedData) {
    if (mappedData.isNotEmpty){
  showDialog(
      context: context,
      builder: (context) => DownloadAttendanceDialog(data: mappedData,documentType: "attendance",),
    );
    }
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;

          return Container(
            width: screenWidth,
            color: Colors.white,
            child: Stack(
              children: [
                // Background Image
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: screenWidth <= 640 ? 200 : 276,
                  child: Image.asset(
                    'assets/images/student_attendent_sheetheader.png',
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                // Main Content Container
                Positioned(
                  top: screenWidth <= 640 ? 200 : 276,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/home_student_gradient.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(
                            title: "Attendance Sheet",
                            onDownloadPressed: () =>
                                _downloadPDF(context, attendanceData ?? [])),
                        const SizedBox(height: 10),

                        // Date Range Selector
                        GestureDetector(
                          onTap: () => _selectDateRange(context),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    fromDate != null && toDate != null
                                        ? 'From: ${fromDate!.toLocal().toString().split(' ')[0]} To: ${toDate!.toLocal().toString().split(' ')[0]}'
                                        : 'Select Date Range',
                                    style: TextStyle(
                                      fontFamily: 'Popins',
                                      color: Colors.grey[800],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.calendar_month,
                                  size: 25,
                                  color: Colors.black,
                                ),
                                if (fromDate != null && toDate != null)
                                  IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.black,
                                    ),
                                    onPressed: _clearDateFilter,
                                  ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Header Row
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'Date',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                             Expanded(
                              flex: 2,
                              child: Text(
                                widget.studentID!=null?'Class ID':'Student ID',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'Subject',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            
                             const Expanded(
                              flex: 1,
                              child: Text(
                                'Attend',
                                style: TextStyle(
                                
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),

                        // Attendance List
                        Expanded(
                          child: FutureBuilder<List<Map<String, dynamic>>>(
                            future: fetchAttendanceData(classId: widget.classID,
                                studentId: widget.studentID??null),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Center(
                                    child:
                                        Text('No attendance records found.'));
                              } else {
                                // Store original attendance list once
                                if (originalAttendanceData == null) {
                                  originalAttendanceData = snapshot.data!;
                                  attendanceData ??= snapshot.data!;
                                }

                                return attendanceData == null ||
                                        attendanceData!.isEmpty
                                    ? const Center(
                                        child: Text(
                                          'No records found.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        padding:EdgeInsets.only(top: 10),
                                        itemCount: attendanceData!.length,
                                        itemBuilder: (context, index) {
                                          final record = attendanceData![index];
                                          return AttendanceListItem(
                                            date: record['date'] ?? '',
                                            classId:  widget.studentID!=null? record['class_id'] ?? '':record['student_id'],
                                            name: record['subject'] ?? '',
                                            isPresent: record['status'],
                                          );
                                        },
                                      );
                              }
                            },
                          ),
                        ),
                        widget.studentID!=null?
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentPaymentSheet(
                                      studentId: widget.studentID!),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'View Payments',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ): Padding(
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
        },
      ),
    );
  }
}
