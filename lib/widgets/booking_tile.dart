import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/booking.dart';
import '../models/pet.dart';
import '../repositories/pet_repository.dart';

class BookingTile extends StatelessWidget {
  final Booking booking;
  final VoidCallback onTap;

  const BookingTile({
    super.key,
    required this.booking,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final pet = PetRepository()
        .getAllPets()
        .where((Pet pet) => pet.id == booking.petId)
        .firstOrNull;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: const Icon(Icons.event),
        title: Text(
          pet?.name ?? 'Unknown pet',
        ),
        subtitle: Text(
          '${booking.serviceType} · ${DateFormat('yyyy-MM-dd').format(booking.date)}\n'
          '${booking.startTime} - ${booking.endTime}',
        ),
        isThreeLine: true,
        trailing: Text(
          '${booking.price.toStringAsFixed(0)} SEK',
        ),
      ),
    );
  }
}