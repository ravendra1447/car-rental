import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/car.dart';
import '../data/mock_cars.dart';

final carsProvider = Provider<List<Car>>((ref) => mockCars);
