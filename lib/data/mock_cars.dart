import '../models/car.dart';

const mockCars = <Car>[
  Car(
    id: 'c1',
    name: 'Model S',
    brand: 'Tesla',
    type: 'Sedan',
    seats: 5,
    transmission: 'Automatic',
    pricePerDay: 120.0,
    isAvailable: true,
    imageAsset: 'assets/images/car_tesla.svg',
    imageUrl:
        'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?q=80&w=1200&auto=format&fit=crop',
  ),
  Car(
    id: 'c2',
    name: 'Civic',
    brand: 'Honda',
    type: 'Sedan',
    seats: 5,
    transmission: 'Manual',
    pricePerDay: 55.0,
    isAvailable: true,
    imageAsset: 'assets/images/car_honda.svg',
    imageUrl:
        'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?q=80&w=1200&auto=format&fit=crop',
  ),
  Car(
    id: 'c3',
    name: 'Fortuner',
    brand: 'Toyota',
    type: 'SUV',
    seats: 7,
    transmission: 'Automatic',
    pricePerDay: 95.0,
    isAvailable: false,
    imageAsset: 'assets/images/car_toyota.svg',
    imageUrl:
        'https://images.unsplash.com/photo-1503376780353-7e6692767b70?q=80&w=1200&auto=format&fit=crop',
  ),
  Car(
    id: 'c4',
    name: 'Swift',
    brand: 'Suzuki',
    type: 'Hatchback',
    seats: 5,
    transmission: 'Manual',
    pricePerDay: 40.0,
    isAvailable: true,
    imageAsset: 'assets/images/car_suzuki.svg',
    imageUrl:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?q=80&w=1200&auto=format&fit=crop',
  ),
  Car(
    id: 'c5',
    name: 'Mustang',
    brand: 'Ford',
    type: 'Coupe',
    seats: 4,
    transmission: 'Automatic',
    pricePerDay: 150.0,
    isAvailable: true,
    imageAsset: 'assets/images/car_ford.svg',
    imageUrl:
        'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?q=80&w=1200&auto=format&fit=crop',
  ),
];
