class Owner {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String emergencyContact;
  final String notes;

  Owner({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.emergencyContact,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'emergencyContact': emergencyContact,
      'notes': notes,
    };
  }

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      emergencyContact: map['emergencyContact'] ?? '',
      notes: map['notes'] ?? '',
    );
  }
}