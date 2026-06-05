import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeSummaryCard extends StatelessWidget {
  final double total;
  final DateTime month;

  const IncomeSummaryCard({
    super.key,
    required this.total,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.calendar_month),
        title: const Text('This Month Total'),
        subtitle: Text(DateFormat('MMMM yyyy').format(month)),
        trailing: Text(
          '${total.toStringAsFixed(0)} SEK',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}