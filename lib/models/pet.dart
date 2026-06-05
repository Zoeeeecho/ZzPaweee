class Pet {
  final String id;
  final String ownerId;
  final String name;
  final String breed;
  final String age;
  final String gender;
  final String photoPath;
  final List<String> traits;
  final String feedingInstructions;
  final String walkingInstructions;
  final String medicalNotes;
  final String emergencyNotes;
  final String vetInfo;
  final String notes;

  Pet({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.breed,
    required this.age,
    required this.gender,
    required this.photoPath,
    required this.traits,
    required this.feedingInstructions,
    required this.walkingInstructions,
    required this.medicalNotes,
    required this.emergencyNotes,
    required this.vetInfo,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'name': name,
      'breed': breed,
      'age': age,
      'gender': gender,
      'photoPath': photoPath,
      'traits': traits,
      'feedingInstructions': feedingInstructions,
      'walkingInstructions': walkingInstructions,
      'medicalNotes': medicalNotes,
      'emergencyNotes': emergencyNotes,
      'vetInfo': vetInfo,
      'notes': notes,
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['id'] ?? '',
      ownerId: map['ownerId'] ?? '',
      name: map['name'] ?? '',
      breed: map['breed'] ?? '',
      age: map['age'] ?? '',
      gender: map['gender'] ?? '',
      photoPath: map['photoPath'] ?? '',
      traits: List<String>.from(map['traits'] ?? []),
      feedingInstructions: map['feedingInstructions'] ?? '',
      walkingInstructions: map['walkingInstructions'] ?? '',
      medicalNotes: map['medicalNotes'] ?? '',
      emergencyNotes: map['emergencyNotes'] ?? '',
      vetInfo: map['vetInfo'] ?? '',
      notes: map['notes'] ?? '',
    );
  }
}