import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/booking.dart';
import '../repositories/booking_repository.dart';
import '../data/mock_bookings.dart';

class BookingListNotifier extends AsyncNotifier<List<Booking>> {
  late final BookingRepository _repo;
  BookingListNotifier() {
    _repo = BookingRepository();
  }

  @override
  Future<List<Booking>> build() async {
    final stored = await _repo.loadBookings();
    if (stored.isNotEmpty) return stored;
    return mockBookings;
  }

  Future<void> addBooking(Booking booking) async {
    final current = state.value ?? [];
    final updated = [...current, booking];
    state = AsyncData(updated);
    await _repo.saveBookings(updated);
  }
}

final bookingListProvider =
    AsyncNotifierProvider<BookingListNotifier, List<Booking>>(
      () => BookingListNotifier(),
    );
final currentBookingProvider = StateProvider<Booking?>((ref) => null);
