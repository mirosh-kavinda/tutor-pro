import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class DownloadAttendanceDialog extends StatelessWidget {
  final List<dynamic> data;

  const DownloadAttendanceDialog({super.key, required this.data});

  Future<void> generateAndDownloadAttendancePDF() async {
    final pdf = pw.Document();

    final headers = ['Date', 'Class ID', 'Status'];

    final dataRows = data.map((record) {
      return [
        record['date'] ?? '',
        record['class_id'] ?? '',
        record['status'] ?? '',
      ];
    }).toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Center(
              child: pw.Text(
                'Attendance Report',
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
      title: const Text('Download Attendance PDF'),
      content: const Text('Do you want to generate and download the attendance report?'),
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
