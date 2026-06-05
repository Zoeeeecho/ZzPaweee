import '../models/income_record.dart';
import '../services/hive_service.dart';

class IncomeRepository {
  final box = HiveService.incomeBox;

  Future<void> addIncome(IncomeRecord record) async {
    await box.put(record.id, record.toMap());
  }

  Future<void> deleteIncome(String id) async {
    await box.delete(id);
  }

  List<IncomeRecord> getAllIncome() {
    return box.values
        .map((item) => IncomeRecord.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  double getMonthlyTotal(DateTime month) {
    return getAllIncome()
        .where((record) =>
            record.date.year == month.year && record.date.month == month.month)
        .fold(0, (sum, record) => sum + record.amount);
  }
}