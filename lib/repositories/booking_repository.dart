import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/booking.dart';

class BookingRepository {
  static const _key = 'bookings';

  Future<List<Booking>> loadBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    return list.map(Booking.fromJson).toList();
  }

  Future<void> saveBookings(List<Booking> bookings) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(bookings.map((b) => b.toJson()).toList());
    await prefs.setString(_key, raw);
  }
}
