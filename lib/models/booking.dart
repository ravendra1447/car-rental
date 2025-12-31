import 'car.dart';

class Booking {
  final Car car;
  final String customerName;
  final DateTime startDate;
  final DateTime endDate;
  final String pickupLocation;

  const Booking({
    required this.car,
    required this.customerName,
    required this.startDate,
    required this.endDate,
    required this.pickupLocation,
  });

  int get totalDays {
    final days = endDate.difference(startDate).inDays;
    return days < 1 ? 1 : days;
  }

  double get totalCost => totalDays * car.pricePerDay;

  Map<String, dynamic> toJson() => {
    'car': {
      'id': car.id,
      'name': car.name,
      'brand': car.brand,
      'type': car.type,
      'seats': car.seats,
      'transmission': car.transmission,
      'pricePerDay': car.pricePerDay,
      'isAvailable': car.isAvailable,
      'imageAsset': car.imageAsset,
    },
    'customerName': customerName,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'pickupLocation': pickupLocation,
  };

  static Booking fromJson(Map<String, dynamic> json) {
    final c = json['car'] as Map<String, dynamic>;
    final car = Car(
      id: c['id'],
      name: c['name'],
      brand: c['brand'],
      type: c['type'],
      seats: c['seats'],
      transmission: c['transmission'],
      pricePerDay: (c['pricePerDay'] as num).toDouble(),
      isAvailable: c['isAvailable'],
      imageAsset: c['imageAsset'],
    );
    return Booking(
      car: car,
      customerName: json['customerName'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      pickupLocation: json['pickupLocation'],
    );
  }
}
