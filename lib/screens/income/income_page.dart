import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../repositories/income_repository.dart';
import '../../services/hive_service.dart';
import '../../widgets/income_record_tile.dart';
import '../../widgets/income_summary_card.dart';
import 'add_income_page.dart';
import 'income_detail_page.dart';
class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = IncomeRepository();

    return Scaffold(
      appBar: AppBar(title: const Text('Income'), centerTitle: true),
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
          final records = repository.getAllIncome().reversed.toList();
          final monthTotal = repository.getMonthlyTotal(DateTime.now());

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: IncomeSummaryCard(
                  total: monthTotal,
                  month: DateTime.now(),
                ),
              ),
              Expanded(
                child: records.isEmpty
                    ? const Center(child: Text('No income records yet.'))
                    : ListView.builder(
                        itemCount: records.length,
                        itemBuilder: (context, index) {
                          final record = records[index];

                          return IncomeRecordTile(
                            record: record,
                            onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => IncomeDetailPage(record: record),
                                    ),
                                );
                            },
                            onDelete: () {
                              repository.deleteIncome(record.id);
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}