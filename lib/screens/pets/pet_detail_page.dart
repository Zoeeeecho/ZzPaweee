import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/pet.dart';
import '../../repositories/owner_repository.dart';
import 'edit_pet_page.dart';
class PetDetailPage extends StatelessWidget {
  final Pet pet;

  const PetDetailPage({
    super.key,
    required this.pet,
  });

  Widget row(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(value.isEmpty ? 'Not added' : value),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final owner = OwnerRepository().getOwnerById(pet.ownerId);
    final hasPhoto = pet.photoPath.isNotEmpty && File(pet.photoPath).existsSync();

    return Scaffold(
      appBar: AppBar(
        title: Text(pet.name),
        centerTitle: true,
        actions: [
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditPetPage(pet: pet),
                        ),
                    );
                },
            ),
        ],
    ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: CircleAvatar(
              radius: 70,
              backgroundImage: hasPhoto ? FileImage(File(pet.photoPath)) : null,
              child: hasPhoto ? null : const Icon(Icons.pets, size: 60),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  row(Icons.person, 'Owner', owner?.name ?? 'No owner selected'),
                  row(Icons.pets, 'Breed', pet.breed),
                  row(Icons.cake, 'Age', pet.age),
                  row(Icons.transgender, 'Gender', pet.gender),
                  row(
                    Icons.favorite,
                    'Character Traits',
                    pet.traits.isEmpty ? 'No traits selected' : pet.traits.join(', '),
                  ),
                  row(Icons.restaurant, 'Feeding Instructions', pet.feedingInstructions),
                  row(Icons.directions_walk, 'Walking Instructions', pet.walkingInstructions),
                  row(Icons.medical_services, 'Allergies / Medical Notes', pet.medicalNotes),
                  row(Icons.emergency, 'Emergency Notes', pet.emergencyNotes),
                  row(Icons.local_hospital, 'Vet Info', pet.vetInfo),
                  row(Icons.notes, 'Personal Notes', pet.notes),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}