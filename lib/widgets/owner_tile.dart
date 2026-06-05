import 'package:flutter/material.dart';

import '../models/owner.dart';

class OwnerTile extends StatelessWidget {
  final Owner owner;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const OwnerTile({
    super.key,
    required this.owner,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(owner.name.isEmpty ? 'Unnamed owner' : owner.name),
        subtitle: Text(
          owner.phone.isEmpty ? 'No phone number' : owner.phone,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}