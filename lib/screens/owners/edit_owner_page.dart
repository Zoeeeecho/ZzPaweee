import 'package:flutter/material.dart';

import '../../models/owner.dart';
import '../../repositories/owner_repository.dart';

class EditOwnerPage extends StatefulWidget {
  final Owner owner;

  const EditOwnerPage({
    super.key,
    required this.owner,
  });

  @override
  State<EditOwnerPage> createState() => _EditOwnerPageState();
}

class _EditOwnerPageState extends State<EditOwnerPage> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController addressController;
  late final TextEditingController emergencyContactController;
  late final TextEditingController notesController;

  final repository = OwnerRepository();

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.owner.name);
    phoneController = TextEditingController(text: widget.owner.phone);
    emailController = TextEditingController(text: widget.owner.email);
    addressController = TextEditingController(text: widget.owner.address);
    emergencyContactController =
        TextEditingController(text: widget.owner.emergencyContact);
    notesController = TextEditingController(text: widget.owner.notes);
  }

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

  void saveChanges() {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Owner name cannot be empty.')),
      );
      return;
    }

    final updatedOwner = Owner(
      id: widget.owner.id,
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      address: addressController.text.trim(),
      emergencyContact: emergencyContactController.text.trim(),
      notes: notesController.text.trim(),
    );

    repository.updateOwner(updatedOwner);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Owner'),
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
          input(
            controller: notesController,
            label: 'Personal Notes',
            maxLines: 4,
          ),
          const SizedBox(height: 8),
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