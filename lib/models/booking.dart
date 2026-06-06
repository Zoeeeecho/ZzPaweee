class Booking {
  final String id;
  final String petId;
  final String serviceType;
  final DateTime date;
  final String startTime;
  final String endTime;
  final double price;
  final String status;
  final String notes;

  Booking({
    required this.id,
    required this.petId,
    required this.serviceType,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.status,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'petId': petId,
      'serviceType': serviceType,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'price': price,
      'status': status,
      'notes': notes,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] ?? '',
      petId: map['petId'] ?? '',
      serviceType: map['serviceType'] ?? '',
      date: DateTime.parse(map['date']),
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0,
      status: map['status'] ?? 'Upcoming',
      notes: map['notes'] ?? '',
    );
  }
}