import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../repositories/owner_repository.dart';
import '../../services/hive_service.dart';
import '../../widgets/owner_tile.dart';
import 'add_owner_page.dart';
import 'owner_detail_page.dart';

class OwnersPage extends StatelessWidget {
  const OwnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = OwnerRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Owners'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddOwnerPage()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Owner'),
      ),
      body: ValueListenableBuilder(
        valueListenable: HiveService.ownerBox.listenable(),
        builder: (context, box, _) {
          final owners = repository.getAllOwners();

          if (owners.isEmpty) {
            return const Center(child: Text('No owners yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 90),
            itemCount: owners.length,
            itemBuilder: (context, index) {
              final owner = owners[index];

              return OwnerTile(
                owner: owner,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OwnerDetailPage(owner: owner),
                    ),
                  );
                },
                onDelete: () {
                  repository.deleteOwner(owner.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}