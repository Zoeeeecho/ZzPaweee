import 'package:flutter/material.dart';

import '../models/income_record.dart';
import 'income_record_tile.dart';

class MonthlyIncomeSection extends StatelessWidget {
  final String monthTitle;
  final double total;
  final List<IncomeRecord> records;
  final void Function(IncomeRecord record) onRecordTap;
  final void Function(IncomeRecord record) onDelete;
  final VoidCallback onExportPdf;

  const MonthlyIncomeSection({
    super.key,
    required this.monthTitle,
    required this.total,
    required this.records,
    required this.onRecordTap,
    required this.onDelete,
    required this.onExportPdf,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        leading: const Icon(Icons.calendar_month),
        title: Text(monthTitle),
        subtitle: Text('${records.length} records'),
        trailing: Text(
          '${total.toStringAsFixed(0)} SEK',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onExportPdf,
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Export PDF'),
            ),
          ),
          ...records.map(
            (record) => IncomeRecordTile(
              record: record,
              onTap: () => onRecordTap(record),
              onDelete: () => onDelete(record),
            ),
          ),
        ],
      ),
    );
  }
}