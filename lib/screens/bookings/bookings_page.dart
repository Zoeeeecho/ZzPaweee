import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../repositories/booking_repository.dart';
import '../../services/hive_service.dart';
import '../../widgets/booking_tile.dart';
import 'add_booking_page.dart';
import 'booking_detail_page.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  String formatMonthTitle(String monthKey) {
    final parts = monthKey.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);

    return DateFormat('MMMM yyyy').format(DateTime(year, month));
  }

  @override
  Widget build(BuildContext context) {
    final repository = BookingRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: HiveService.bookingBox.listenable(),
        builder: (context, box, _) {
          final groupedBookings = repository.groupBookingsByMonth();

          if (groupedBookings.isEmpty) {
            return const Center(child: Text('No bookings yet'));
          }

          final monthKeys = groupedBookings.keys.toList();

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 90),
            itemCount: monthKeys.length,
            itemBuilder: (context, index) {
              final monthKey = monthKeys[index];
              final bookings = groupedBookings[monthKey]!;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ExpansionTile(
                  leading: const Icon(Icons.calendar_month),
                  title: Text(formatMonthTitle(monthKey)),
                  subtitle: Text('${bookings.length} bookings'),
                  children: bookings.map((booking) {
                    return BookingTile(
                      booking: booking,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                BookingDetailPage(booking: booking),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddBookingPage(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Booking'),
      ),
    );
  }
}