import 'dart:io';

import 'package:flutter/material.dart';

import '../models/pet.dart';

class PetTile extends StatelessWidget {
  final Pet pet;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const PetTile({
    super.key,
    required this.pet,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final hasPhoto = pet.photoPath.isNotEmpty && File(pet.photoPath).existsSync();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: hasPhoto ? FileImage(File(pet.photoPath)) : null,
          child: hasPhoto ? null : const Icon(Icons.pets),
        ),
        title: Text(pet.name.isEmpty ? 'Unnamed pet' : pet.name),
        subtitle: Text(
          [
            if (pet.breed.isNotEmpty) pet.breed,
            if (pet.traits.isNotEmpty) pet.traits.take(2).join(', '),
          ].join(' · '),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}