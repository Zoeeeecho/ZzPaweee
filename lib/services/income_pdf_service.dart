import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/income_record.dart';

class IncomePdfService {
  Future<void> exportMonthlyIncomePdf({
    required String monthTitle,
    required double total,
    required List<IncomeRecord> records,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Text(
            'ZzPaweee Income Report',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Text(monthTitle, style: const pw.TextStyle(fontSize: 18)),
          pw.SizedBox(height: 16),
          pw.Text(
            'Total: ${total.toStringAsFixed(0)} SEK',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 24),
          pw.TableHelper.fromTextArray(
            headers: [
              'Date',
              'Time',
              'Service',
              'Dog / Client',
              'Amount',
              'Notes',
            ],
            data: records.map((record) {
              return [
                DateFormat('yyyy-MM-dd').format(record.date),
                '${record.startTime}-${record.endTime}',
                record.serviceType,
                record.dogName,
                '${record.amount.toStringAsFixed(0)} SEK',
                record.notes,
              ];
            }).toList(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.grey300,
            ),
            cellStyle: const pw.TextStyle(fontSize: 9),
          ),
        ],
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'zzpaweee_income_$monthTitle.pdf',
    );
  }
}