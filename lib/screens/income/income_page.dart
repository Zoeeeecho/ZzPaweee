import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../models/income_record.dart';
import '../../repositories/income_repository.dart';
import '../../services/hive_service.dart';
import '../../widgets/monthly_income_section.dart';
import 'add_income_page.dart';
import 'income_detail_page.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  String formatMonthTitle(String monthKey) {
    final parts = monthKey.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final date = DateTime(year, month);

    return DateFormat('MMMM yyyy').format(date);
  }

  void openIncomeDetail(BuildContext context, IncomeRecord record) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => IncomeDetailPage(record: record),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final repository = IncomeRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Income'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddIncomePage()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Income'),
      ),
      body: ValueListenableBuilder(
        valueListenable: HiveService.incomeBox.listenable(),
        builder: (context, box, _) {
          final groupedIncome = repository.groupIncomeByMonth();

          if (groupedIncome.isEmpty) {
            return const Center(
              child: Text('No income records yet.'),
            );
          }

          final monthKeys = groupedIncome.keys.toList();

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 90),
            itemCount: monthKeys.length,
            itemBuilder: (context, index) {
              final monthKey = monthKeys[index];
              final records = groupedIncome[monthKey]!;
              final total = repository.getTotalForRecords(records);

              return MonthlyIncomeSection(
                monthTitle: formatMonthTitle(monthKey),
                total: total,
                records: records,
                onRecordTap: (record) {
                  openIncomeDetail(context, record);
                },
                onDelete: (record) {
                  repository.deleteIncome(record.id);
                },
                onExportPdf: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('PDF export coming next 🐾'),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}