import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/car.dart';
import 'car_provider.dart';

enum SortOrder { priceAsc, priceDesc }

final typeFilterProvider = StateProvider<String?>((ref) => null);
final transmissionFilterProvider = StateProvider<String?>((ref) => null);
final sortOrderProvider = StateProvider<SortOrder>((ref) => SortOrder.priceAsc);

final filteredCarsProvider = Provider<List<Car>>((ref) {
  final cars = ref.watch(carsProvider);
  final type = ref.watch(typeFilterProvider);
  final trans = ref.watch(transmissionFilterProvider);
  final order = ref.watch(sortOrderProvider);

  var result = cars.where((c) {
    final okType = type == null || c.type == type;
    final okTrans = trans == null || c.transmission == trans;
    return okType && okTrans;
  }).toList();

  result.sort((a, b) {
    final cmp = a.pricePerDay.compareTo(b.pricePerDay);
    return order == SortOrder.priceAsc ? cmp : -cmp;
  });
  return result;
});
