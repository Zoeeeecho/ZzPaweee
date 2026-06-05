import 'package:flutter/material.dart';

import '../../models/owner.dart';
import 'edit_owner_page.dart';
class OwnerDetailPage extends StatelessWidget {
  final Owner owner;

  const OwnerDetailPage({
    super.key,
    required this.owner,
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
    return Scaffold(
        appBar: AppBar(
            title: Text(owner.name),
            centerTitle: true,
            actions: [
                IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EditOwnerPage(owner: owner),
                            ),
                        );
                    },
                ),
            ],
        ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 38,
                    child: Icon(Icons.person, size: 42),
                  ),
                  const SizedBox(height: 20),
                  row(Icons.phone, 'Phone', owner.phone),
                  row(Icons.email, 'Email', owner.email),
                  row(Icons.home, 'Address', owner.address),
                  row(Icons.emergency, 'Emergency Contact', owner.emergencyContact),
                  row(Icons.notes, 'Personal Notes', owner.notes),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}