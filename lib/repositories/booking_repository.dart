import '../models/booking.dart';
import '../services/hive_service.dart';

class BookingRepository {
  Future<void> addBooking(Booking booking) async {
    await HiveService.bookingBox.put(booking.id, booking.toMap());
  }

  Future<void> updateBooking(Booking booking) async {
    await HiveService.bookingBox.put(booking.id, booking.toMap());
  }

  Future<void> deleteBooking(String id) async {
    await HiveService.bookingBox.delete(id);
  }

  List<Booking> getAllBookings() {
    final bookings = HiveService.bookingBox.values
        .map((item) => Booking.fromMap(Map<String, dynamic>.from(item)))
        .toList();

    bookings.sort((a, b) => a.date.compareTo(b.date));
    return bookings;
  }

  List<Booking> getUpcomingBookings() {
    final now = DateTime.now();

    return getAllBookings().where((booking) {
      final bookingDate = DateTime(
        booking.date.year,
        booking.date.month,
        booking.date.day,
      );

      final today = DateTime(now.year, now.month, now.day);

      return !bookingDate.isBefore(today) && booking.status == 'Upcoming';
    }).toList();
  }

  Map<String, List<Booking>> groupBookingsByMonth() {
    final bookings = getAllBookings();

    final Map<String, List<Booking>> grouped = {};

    for (final booking in bookings) {
        final key =
            '${booking.date.year}-${booking.date.month.toString().padLeft(2, '0')}';

        grouped.putIfAbsent(key, () => []);
        grouped[key]!.add(booking);
    }

    return grouped;
    }
}