import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/owner.dart';
import '../../models/pet.dart';
import '../../repositories/owner_repository.dart';
import '../../repositories/pet_repository.dart';

class EditPetPage extends StatefulWidget {
  final Pet pet;

  const EditPetPage({
    super.key,
    required this.pet,
  });

  @override
  State<EditPetPage> createState() => _EditPetPageState();
}

class _EditPetPageState extends State<EditPetPage> {
  late final TextEditingController nameController;
  late final TextEditingController breedController;
  late final TextEditingController ageController;
  late final TextEditingController feedingController;
  late final TextEditingController walkingController;
  late final TextEditingController medicalController;
  late final TextEditingController emergencyController;
  late final TextEditingController vetController;
  late final TextEditingController notesController;

  final petRepository = PetRepository();
  final ownerRepository = OwnerRepository();

  late String gender;
  late String ownerId;
  late String photoPath;
  late List<String> selectedTraits;

  final List<String> availableTraits = [
    'Friendly',
    'Shy',
    'Energetic',
    'Calm',
    'Reactive to dogs',
    'Reactive to people',
    'Pulls on leash',
    'Food motivated',
    'Separation anxiety',
    'Good with dogs',
    'Good with children',
    'Loves cuddles',
    'Loves toys',
  ];

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.pet.name);
    breedController = TextEditingController(text: widget.pet.breed);
    ageController = TextEditingController(text: widget.pet.age);
    feedingController =
        TextEditingController(text: widget.pet.feedingInstructions);
    walkingController =
        TextEditingController(text: widget.pet.walkingInstructions);
    medicalController = TextEditingController(text: widget.pet.medicalNotes);
    emergencyController =
        TextEditingController(text: widget.pet.emergencyNotes);
    vetController = TextEditingController(text: widget.pet.vetInfo);
    notesController = TextEditingController(text: widget.pet.notes);

    gender = widget.pet.gender;
    ownerId = widget.pet.ownerId;
    photoPath = widget.pet.photoPath;
    selectedTraits = List<String>.from(widget.pet.traits);
  }

  @override
  void dispose() {
    nameController.dispose();
    breedController.dispose();
    ageController.dispose();
    feedingController.dispose();
    walkingController.dispose();
    medicalController.dispose();
    emergencyController.dispose();
    vetController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'pet_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedImage = await File(picked.path).copy('${appDir.path}/$fileName');

    setState(() {
      photoPath = savedImage.path;
    });
  }

  void saveChanges() {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pet name cannot be empty.')),
      );
      return;
    }

    final updatedPet = Pet(
      id: widget.pet.id,
      ownerId: ownerId,
      name: nameController.text.trim(),
      breed: breedController.text.trim(),
      age: ageController.text.trim(),
      gender: gender,
      photoPath: photoPath,
      traits: selectedTraits,
      feedingInstructions: feedingController.text.trim(),
      walkingInstructions: walkingController.text.trim(),
      medicalNotes: medicalController.text.trim(),
      emergencyNotes: emergencyController.text.trim(),
      vetInfo: vetController.text.trim(),
      notes: notesController.text.trim(),
    );

    petRepository.updatePet(updatedPet);

    Navigator.pop(context);
    Navigator.pop(context);
  }

  Widget input({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final owners = ownerRepository.getAllOwners();
    final hasPhoto = photoPath.isNotEmpty && File(photoPath).existsSync();

    final validOwnerId =
        owners.any((owner) => owner.id == ownerId) ? ownerId : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Pet'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 56,
                backgroundImage: hasPhoto ? FileImage(File(photoPath)) : null,
                child: hasPhoto
                    ? null
                    : const Icon(Icons.add_a_photo, size: 34),
              ),
            ),
          ),
          const SizedBox(height: 20),
          input(controller: nameController, label: 'Pet Name'),
          input(controller: breedController, label: 'Breed'),
          input(controller: ageController, label: 'Age'),
          DropdownButtonFormField<String>(
            value: gender,
            decoration: const InputDecoration(
              labelText: 'Gender',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'Unknown', child: Text('Unknown')),
              DropdownMenuItem(value: 'Female', child: Text('Female')),
              DropdownMenuItem(value: 'Male', child: Text('Male')),
            ],
            onChanged: (value) {
              setState(() {
                gender = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: validOwnerId,
            decoration: const InputDecoration(
              labelText: 'Owner',
              border: OutlineInputBorder(),
            ),
            items: owners
                .map(
                  (Owner owner) => DropdownMenuItem(
                    value: owner.id,
                    child: Text(owner.name),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                ownerId = value ?? '';
              });
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Character Traits',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: availableTraits.map((trait) {
              final selected = selectedTraits.contains(trait);

              return FilterChip(
                label: Text(trait),
                selected: selected,
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      selectedTraits.add(trait);
                    } else {
                      selectedTraits.remove(trait);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          input(
            controller: feedingController,
            label: 'Feeding Instructions',
            maxLines: 3,
          ),
          input(
            controller: walkingController,
            label: 'Walking Instructions',
            maxLines: 3,
          ),
          input(
            controller: medicalController,
            label: 'Allergies / Medical Notes',
            maxLines: 3,
          ),
          input(
            controller: emergencyController,
            label: 'Emergency Notes',
            maxLines: 3,
          ),
          input(
            controller: vetController,
            label: 'Vet Info',
            maxLines: 3,
          ),
          input(
            controller: notesController,
            label: 'Personal Notes',
            maxLines: 4,
          ),
          FilledButton.icon(
            onPressed: saveChanges,
            icon: const Icon(Icons.save),
            label: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}