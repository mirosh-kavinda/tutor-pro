import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class DownloadAttendanceDialog extends StatelessWidget {
  final List<dynamic> data;
  final String documentType;

  const DownloadAttendanceDialog(
      {super.key, required this.data, required this.documentType});

  Future<void> generateAndDownloadAttendancePDF() async {
    final pdf = pw.Document();
    List headers = [];
    List<List<dynamic>> dataRows = [];
    if (documentType == "attendance") {
      headers = ['Date', 'Class ID', 'Subject', 'Attend'];

      dataRows = data.map((record) {
        return [
          record['date'] ?? '',
          record['class_id'] ?? '',
          record['subject'] ?? '',
          record['status'] ?? ""
        ];
      }).toList();
    } else if (documentType == "payment") {
      headers = ['Date', 'Payment ID', 'Subject', 'Amount'];

      dataRows = data.map((record) {
        return [
          record['date'] ?? 'Unknown data',
          record['payment_id'] ?? 'Unknown data',
          record['subject'] ?? 'Unknown data',
          double.tryParse(record['payment']?.toString() ?? '0')?.toInt() ?? 0,
        ];
      }).toList();
    }else if (documentType=="studentlist"){
       headers = ['S No ', 'Full Name'];

       dataRows = data.map((record) {
        return [
          record['student_id'] ?? 'Unknown data',
          record['student_name'] ?? 'Unknown data',
         ];
      }).toList();
    }
    else if (documentType=="payments"){
       headers = ['Pay ID', 'Student Name','Date'];

       dataRows = data.map((record) {
        return [
          record['payment_id'] ?? 'Unknown data',
          record['student_name'] ?? 'Unknown data',
          record['date'] ?? 'Unknown data',
         ];
      }).toList();
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Center(
              child: pw.Text(
                documentType == "attendance"
                    ? 'Attendance Report'
                    : documentType == "studentlist" ?"Class Student List":"Payment Report",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: headers,
              data: dataRows,
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
              ),
              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.blue,
              ),
              cellAlignment: pw.Alignment.centerLeft,
              cellStyle: const pw.TextStyle(
                fontSize: 12,
              ),
              border: pw.TableBorder.all(color: PdfColors.grey),
            ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        documentType == "attendance"
            ? 'Download Attendance Document'
            : documentType == "studentlist"?"Download StudentList Document":"Download Payments Document",
        textAlign: TextAlign.center,
      ),
      content: Text(
          'Do you want to generate and download the $documentType report?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.of(context).pop(); // Close first
            await generateAndDownloadAttendancePDF(); // Then generate
          },
          child: const Text('Download'),
        ),
      ],
    );
  }
}
