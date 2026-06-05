import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/income_record.dart';

class IncomeDetailPage extends StatelessWidget {
  final IncomeRecord record;

  const IncomeDetailPage({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income Details'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${record.amount.toStringAsFixed(0)} SEK',
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _DetailRow(
                    icon: Icons.pets,
                    label: 'Dog / Client',
                    value: record.dogName.isEmpty ? 'No name' : record.dogName,
                  ),
                  _DetailRow(
                    icon: Icons.work,
                    label: 'Service Type',
                    value: record.serviceType,
                  ),
                  _DetailRow(
                    icon: Icons.calendar_today,
                    label: 'Date',
                    value: DateFormat('yyyy-MM-dd').format(record.date),
                  ),
                  _DetailRow(
                    icon: Icons.notes,
                    label: 'Notes',
                    value: record.notes.isEmpty ? 'No notes' : record.notes,
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

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}