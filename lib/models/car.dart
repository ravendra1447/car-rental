class Car {
  final String id;
  final String name;
  final String brand;
  final String type; // e.g., SUV, Sedan, Hatchback
  final int seats;
  final String transmission; // e.g., Automatic, Manual
  final double pricePerDay;
  final bool isAvailable;
  final String? imageAsset;
  final String? imageUrl;

  const Car({
    required this.id,
    required this.name,
    required this.brand,
    required this.type,
    required this.seats,
    required this.transmission,
    required this.pricePerDay,
    required this.isAvailable,
    this.imageAsset,
    this.imageUrl,
  });
}
