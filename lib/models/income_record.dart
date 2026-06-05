class IncomeRecord {
  final String id;
  final double amount;
  final String serviceType;
  final String dogName;
  final String notes;
  final DateTime date;

  IncomeRecord({
    required this.id,
    required this.amount,
    required this.serviceType,
    required this.dogName,
    required this.notes,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'serviceType': serviceType,
      'dogName': dogName,
      'notes': notes,
      'date': date.toIso8601String(),
    };
  }

  factory IncomeRecord.fromMap(Map<String, dynamic> map) {
    return IncomeRecord(
      id: map['id'],
      amount: (map['amount'] as num).toDouble(),
      serviceType: map['serviceType'] ?? '',
      dogName: map['dogName'] ?? '',
      notes: map['notes'] ?? '',
      date: DateTime.parse(map['date']),
    );
  }
}