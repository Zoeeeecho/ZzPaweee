import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../services/backup_service.dart';
import '../repositories/income_repository.dart';
import '../services/hive_service.dart';
import '../widgets/income_summary_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = IncomeRepository();
    final backupService = BackupService();
    return Scaffold(
      appBar: AppBar(
  title: const Text('Dashboard'),
  centerTitle: true,
  actions: [
    IconButton(
      icon: const Icon(Icons.backup),
      onPressed: () async {
        await backupService.exportBackup();
      },
    ),
  ],
),
      body: ValueListenableBuilder(
        valueListenable: HiveService.incomeBox.listenable(),
        builder: (context, box, _) {
          final total = repository.getMonthlyTotal(DateTime.now());

          return Padding(
            padding: const EdgeInsets.all(16),
            child: IncomeSummaryCard(
              total: total,
              month: DateTime.now(),
            ),
          );
        },
      ),
    );
  }
}