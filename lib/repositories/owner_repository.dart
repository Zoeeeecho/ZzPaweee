import '../models/owner.dart';
import '../services/hive_service.dart';

class OwnerRepository {
  Future<void> addOwner(Owner owner) async {
    await HiveService.ownerBox.put(owner.id, owner.toMap());
  }

  List<Owner> getAllOwners() {
    return HiveService.ownerBox.values
        .map((item) => Owner.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<void> deleteOwner(String id) async {
    await HiveService.ownerBox.delete(id);
  }

  Future<void> updateOwner(Owner owner) async {
    await HiveService.ownerBox.put(owner.id, owner.toMap());
  }

  Owner? getOwnerById(String id) {
    try {
      return getAllOwners().firstWhere((owner) => owner.id == id);
    } catch (_) {
      return null;
    }
  }
}