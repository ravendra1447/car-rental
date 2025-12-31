import '../models/booking.dart';
import '../data/mock_cars.dart';

final mockBookings = <Booking>[
  Booking(
    car: mockCars[0],
    customerName: 'Rahul',
    startDate: DateTime.now().subtract(const Duration(days: 7)),
    endDate: DateTime.now().subtract(const Duration(days: 4)),
    pickupLocation: 'Delhi',
  ),
  Booking(
    car: mockCars[2],
    customerName: 'Neha',
    startDate: DateTime.now().subtract(const Duration(days: 20)),
    endDate: DateTime.now().subtract(const Duration(days: 18)),
    pickupLocation: 'Mumbai',
  ),
  Booking(
    car: mockCars[1],
    customerName: 'Arjun',
    startDate: DateTime.now().subtract(const Duration(days: 3)),
    endDate: DateTime.now().subtract(const Duration(days: 1)),
    pickupLocation: 'Bengaluru',
  ),
];
