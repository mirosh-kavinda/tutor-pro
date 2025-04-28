import 'package:flutter/material.dart';
import '../../repository/student_repository.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/download_pdf.dart';
import '../../widgets/payment_list_item.dart';
import 'student_profile.dart';

class StudentPaymentSheet extends StatefulWidget {
  final String studentId;
  const StudentPaymentSheet({super.key, required this.studentId});

  @override
  _StudentPaymentSheetState createState() => _StudentPaymentSheetState();
}

class _StudentPaymentSheetState extends State<StudentPaymentSheet> {
  DateTime? fromDate;
  DateTime? toDate;
  List<Map<String, dynamic>>? paymentData;
  List<Map<String, dynamic>>? originalPaymentData;
  bool isNoRecordFound = true;

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
    if (originalPaymentData == null) return;

    final filteredData = originalPaymentData!.where((record) {
      final recordDate = DateTime.parse(record['date']);
      return (recordDate.isAtSameMomentAs(from) || recordDate.isAfter(from)) &&
          (recordDate.isAtSameMomentAs(to) || recordDate.isBefore(to));
    }).toList();

    setState(() {
      paymentData = filteredData;
    });
  }

  void _clearDateFilter() {
    setState(() {
      fromDate = null;
      toDate = null;
      paymentData = originalPaymentData;
    });
  }

  void _downloadPDF(context, List<dynamic> mappedData) {
    if (mappedData.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) =>
            DownloadAttendanceDialog(data: mappedData, documentType: "payment"),
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
                            'assets/images/home_student_gradient.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(
                            title: "Payment History",
                            onDownloadPressed: () =>
                                _downloadPDF(context, paymentData ?? [])),

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

                        const SizedBox(height: 30),

                        // Header Row

                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth <= 640 ? 15 : 20),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Id',
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
                                  'subject',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
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
                                  'Amount',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 20,
                        ),

                        // Payment List with FutureBuilder
                        Expanded(
                          child: FutureBuilder<List<Map<String, dynamic>>>(
                            future:
                                fetchPaymentData(studentId: widget.studentId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (snapshot.hasError) {
                                return const Center(
                                  child: Text('Error loading payment data.'),
                                );
                              }

                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Center(
                                  child: Text('No payment records found.'),
                                );
                              }

                              // Store original payment list once
                              if (originalPaymentData == null) {
                                isNoRecordFound = false;
                                originalPaymentData = snapshot.data!;
                                paymentData ??= snapshot.data!;
                              }

                              return paymentData == null || paymentData!.isEmpty
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
                                      padding: const EdgeInsets.only(top: 10),
                                      itemCount: paymentData!.length,
                                      itemBuilder: (context, index) {
                                        final item = paymentData![index];
                                        return PaymentListItem(
                                          date: item['date'] ?? 'Unknown data',
                                          pid: item['payment_id'] ??
                                              'Unknown data',
                                          subject:
                                              item['subject'] ?? 'Unknown data',
                                          amount: double.tryParse(
                                                      item['payment']
                                                              ?.toString() ??
                                                          '0')
                                                  ?.toInt() ??
                                              0,
                                        );
                                      },
                                    );
                            },
                          ),
                        ),

                        // Exit Button
                        Padding(
                          padding: EdgeInsets.all(screenWidth <= 640 ? 15 : 20),
                          child: Align(
                            alignment: screenWidth <= 640
                                ? Alignment.center
                                : Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const StudentProfileCard(),
                                  ),
                                  (route) => false,
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
                                'Exit',
                                style: TextStyle(
                                  color: Colors.black,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
