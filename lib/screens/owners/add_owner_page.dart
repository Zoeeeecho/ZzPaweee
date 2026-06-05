import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../models/owner.dart';
import '../../repositories/owner_repository.dart';

class AddOwnerPage extends StatefulWidget {
  const AddOwnerPage({super.key});

  @override
  State<AddOwnerPage> createState() => _AddOwnerPageState();
}

class _AddOwnerPageState extends State<AddOwnerPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final emergencyContactController = TextEditingController();
  final notesController = TextEditingController();

  final repository = OwnerRepository();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    emergencyContactController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void saveOwner() {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter owner name.')),
      );
      return;
    }

    final owner = Owner(
      id: const Uuid().v4(),
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      address: addressController.text.trim(),
      emergencyContact: emergencyContactController.text.trim(),
      notes: notesController.text.trim(),
    );

    repository.addOwner(owner);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Owner'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          input(controller: nameController, label: 'Owner Name'),
          input(controller: phoneController, label: 'Phone'),
          input(controller: emailController, label: 'Email'),
          input(controller: addressController, label: 'Address'),
          input(
            controller: emergencyContactController,
            label: 'Emergency Contact',
          ),
          input(controller: notesController, label: 'Personal Notes', maxLines: 4),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: saveOwner,
            icon: const Icon(Icons.save),
            label: const Text('Save Owner'),
          ),
        ],
      ),
    );
  }
}