import '../models/pet.dart';
import '../services/hive_service.dart';

class PetRepository {
  Future<void> addPet(Pet pet) async {
    await HiveService.petBox.put(pet.id, pet.toMap());
  }

  List<Pet> getAllPets() {
    return HiveService.petBox.values
        .map((item) => Pet.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<void> deletePet(String id) async {
    await HiveService.petBox.delete(id);
  }
  Future<void> updatePet(Pet pet) async {
    await HiveService.petBox.put(pet.id, pet.toMap());
  }

  List<Pet> getPetsByOwner(String ownerId) {
    return getAllPets()
        .where((pet) => pet.ownerId == ownerId)
        .toList();
  }
}