import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/income_record.dart';

class IncomeRecordTile extends StatelessWidget {
  final IncomeRecord record;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const IncomeRecordTile({
    super.key,
    required this.record,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: const Icon(Icons.pets),
        title: Text('${record.amount.toStringAsFixed(0)} SEK'),
        subtitle: Text(
          '${record.serviceType} · ${record.dogName}\n'
          '${DateFormat('yyyy-MM-dd').format(record.date)}',
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}