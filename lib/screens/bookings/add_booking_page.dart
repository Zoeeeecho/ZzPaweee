import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../models/booking.dart';
import '../../models/pet.dart';
import '../../repositories/booking_repository.dart';
import '../../repositories/pet_repository.dart';

class AddBookingPage extends StatefulWidget {
  const AddBookingPage({super.key});

  @override
  State<AddBookingPage> createState() => _AddBookingPageState();
}

class _AddBookingPageState extends State<AddBookingPage> {
  final priceController = TextEditingController();
  final notesController = TextEditingController();

  final bookingRepository = BookingRepository();
  final petRepository = PetRepository();

  String petId = '';
  String serviceType = 'Dog Walk';
  String status = 'Upcoming';

  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 21, minute: 0);

  @override
  void dispose() {
    priceController.dispose();
    notesController.dispose();
    super.dispose();
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );

    if (picked != null) {
      setState(() {
        startTime = picked;
      });
    }
  }

  Future<void> pickEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );

    if (picked != null) {
      setState(() {
        endTime = picked;
      });
    }
  }

  void saveBooking() {
    if (petId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose a pet.')),
      );
      return;
    }

    final price = double.tryParse(priceController.text.trim()) ?? 0;

    final booking = Booking(
      id: const Uuid().v4(),
      petId: petId,
      serviceType: serviceType,
      date: selectedDate,
      startTime: formatTime(startTime),
      endTime: formatTime(endTime),
      price: price,
      status: status,
      notes: notesController.text.trim(),
    );

    bookingRepository.addBooking(booking);
    Navigator.pop(context);
  }

  Widget sectionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(icon),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pets = petRepository.getAllPets();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Booking'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DropdownButtonFormField<String>(
            value: petId.isEmpty ? null : petId,
            decoration: const InputDecoration(
              labelText: 'Pet',
              border: OutlineInputBorder(),
            ),
            items: pets
                .map(
                  (Pet pet) => DropdownMenuItem(
                    value: pet.id,
                    child: Text(pet.name),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                petId = value ?? '';
              });
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: serviceType,
            decoration: const InputDecoration(
              labelText: 'Service Type',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'Dog Walk', child: Text('Dog Walk')),
              DropdownMenuItem(value: 'Day Care', child: Text('Day Care')),
              DropdownMenuItem(value: 'Boarding', child: Text('Boarding')),
              DropdownMenuItem(value: 'Drop-in', child: Text('Drop-in')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
            ],
            onChanged: (value) {
              setState(() {
                serviceType = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          sectionTile(
            title: 'Date',
            subtitle: DateFormat('yyyy-MM-dd').format(selectedDate),
            icon: Icons.calendar_today,
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2024),
                lastDate: DateTime(2035),
              );

              if (picked != null) {
                setState(() {
                  selectedDate = picked;
                });
              }
            },
          ),
          sectionTile(
            title: 'Start Time',
            subtitle: formatTime(startTime),
            icon: Icons.access_time,
            onTap: pickStartTime,
          ),
          sectionTile(
            title: 'End Time',
            subtitle: formatTime(endTime),
            icon: Icons.access_time,
            onTap: pickEndTime,
          ),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Price SEK',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: status,
            decoration: const InputDecoration(
              labelText: 'Status',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'Upcoming', child: Text('Upcoming')),
              DropdownMenuItem(value: 'Completed', child: Text('Completed')),
              DropdownMenuItem(value: 'Cancelled', child: Text('Cancelled')),
            ],
            onChanged: (value) {
              setState(() {
                status = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: notesController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Notes',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: saveBooking,
            icon: const Icon(Icons.save),
            label: const Text('Save Booking'),
          ),
        ],
      ),
    );
  }
}