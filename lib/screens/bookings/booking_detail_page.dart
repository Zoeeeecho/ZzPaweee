import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/booking.dart';
import '../../models/pet.dart';
import '../../repositories/owner_repository.dart';
import '../../repositories/pet_repository.dart';
import 'edit_booking_page.dart';

class BookingDetailPage extends StatelessWidget {
  final Booking booking;

  const BookingDetailPage({
    super.key,
    required this.booking,
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
    final pet = PetRepository()
        .getAllPets()
        .where((Pet pet) => pet.id == booking.petId)
        .firstOrNull;

    final owner =
        pet == null ? null : OwnerRepository().getOwnerById(pet.ownerId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditBookingPage(booking: booking),
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
                  row(Icons.pets, 'Pet', pet?.name ?? 'Unknown pet'),
                  row(Icons.person, 'Owner', owner?.name ?? 'No owner selected'),
                  row(Icons.work, 'Service Type', booking.serviceType),
                  row(
                    Icons.calendar_today,
                    'Date',
                    DateFormat('yyyy-MM-dd').format(booking.date),
                  ),
                  row(
                    Icons.access_time,
                    'Service Time',
                    '${booking.startTime} - ${booking.endTime}',
                  ),
                  row(
                    Icons.payments,
                    'Price',
                    '${booking.price.toStringAsFixed(0)} SEK',
                  ),
                  row(Icons.info, 'Status', booking.status),
                  row(Icons.notes, 'Notes', booking.notes),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}