import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../repositories/pet_repository.dart';
import '../../services/hive_service.dart';
import '../../widgets/pet_tile.dart';
import 'add_pet_page.dart';
import 'pet_detail_page.dart';

class PetsPage extends StatelessWidget {
  const PetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = PetRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pets'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPetPage()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Pet'),
      ),
      body: ValueListenableBuilder(
        valueListenable: HiveService.petBox.listenable(),
        builder: (context, box, _) {
          final pets = repository.getAllPets();

          if (pets.isEmpty) {
            return const Center(child: Text('No pets yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 90),
            itemCount: pets.length,
            itemBuilder: (context, index) {
              final pet = pets[index];

              return PetTile(
                pet: pet,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PetDetailPage(pet: pet),
                    ),
                  );
                },
                onDelete: () {
                  repository.deletePet(pet.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}