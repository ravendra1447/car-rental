import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
// import '../providers/car_provider.dart';
import '../providers/filter_provider.dart';
import '../providers/locale_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../l10n/localizations.dart';
import '../models/car.dart';
import 'car_detail_screen.dart';

class CarListScreen extends ConsumerWidget {
  const CarListScreen({super.key});
  static const routeName = '/cars';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(authNameProvider) ?? 'Guest';
    final t = AppLocalizations.of(context);
    final cars = ref.watch(filteredCarsProvider);
    final typeFilter = ref.watch(typeFilterProvider);
    final transFilter = ref.watch(transmissionFilterProvider);
    final sortOrder = ref.watch(sortOrderProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.availableCars),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Text(
                'Hi, $name',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          IconButton(
            tooltip: 'History',
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, '/booking-history'),
          ),
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (locale) {
              ref.read(localeProvider.notifier).state = locale;
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: Locale('en'), child: Text('English')),
              PopupMenuItem(value: Locale('hi'), child: Text('हिंदी')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _FilterBar(
              type: typeFilter,
              transmission: transFilter,
              sortOrder: sortOrder,
              onTypeChanged: (val) =>
                  ref.read(typeFilterProvider.notifier).state = val,
              onTransChanged: (val) =>
                  ref.read(transmissionFilterProvider.notifier).state = val,
              onSortChanged: (val) =>
                  ref.read(sortOrderProvider.notifier).state = val,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 700;
                  if (isWide) {
                    final crossCount = constraints.maxWidth >= 1100 ? 3 : 2;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossCount,
                        childAspectRatio: 3.0,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: cars.length,
                      itemBuilder: (_, i) {
                        final car = cars[i];
                        return _CarItem(
                          car: car,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              CarDetailScreen.routeName,
                              arguments: car,
                            );
                          },
                        );
                      },
                    );
                  }
                  return ListView.separated(
                    itemBuilder: (_, i) {
                      final car = cars[i];
                      return _CarItem(
                        car: car,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            CarDetailScreen.routeName,
                            arguments: car,
                          );
                        },
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemCount: cars.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarItem extends StatelessWidget {
  const _CarItem({required this.car, required this.onTap});
  final Car car;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final availableColor = car.isAvailable ? Colors.green : Colors.red;
    final t = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: InkWell(
        onTap: car.isAvailable ? onTap : null,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 100,
                  height: 80,
                  child: car.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: car.imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          errorWidget: (_, __, ___) => car.imageAsset != null
                              ? SvgPicture.asset(
                                  car.imageAsset!,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.directions_car, size: 40),
                        )
                      : (car.imageAsset != null
                            ? SvgPicture.asset(
                                car.imageAsset!,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.directions_car, size: 40)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${car.brand} ${car.name}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${car.type} • ${car.seats} seats • ${car.transmission}',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '${t.formatCurrency(car.pricePerDay)}/day',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Icon(Icons.circle, size: 10, color: availableColor),
                            const SizedBox(width: 6),
                            Text(
                              car.isAvailable ? t.available : t.unavailable,
                              style: TextStyle(color: availableColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.type,
    required this.transmission,
    required this.sortOrder,
    required this.onTypeChanged,
    required this.onTransChanged,
    required this.onSortChanged,
  });
  final String? type;
  final String? transmission;
  final SortOrder sortOrder;
  final ValueChanged<String?> onTypeChanged;
  final ValueChanged<String?> onTransChanged;
  final ValueChanged<SortOrder> onSortChanged;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final types = const ['Sedan', 'SUV', 'Hatchback', 'Coupe'];
    final trans = const ['Automatic', 'Manual'];
    return SizedBox(
      height: 48,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _PillDropdown<String?>(
              icon: Icons.car_rental,
              value: type,
              label: type ?? 'Type: All',
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('Type: All'),
                ),
                ...types.map(
                  (e) => DropdownMenuItem<String?>(value: e, child: Text(e)),
                ),
              ],
              onChanged: onTypeChanged,
            ),
            const SizedBox(width: 8),
            _PillDropdown<String?>(
              icon: Icons.settings,
              value: transmission,
              label: transmission ?? 'Transmission: Any',
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('Transmission: Any'),
                ),
                ...trans.map(
                  (e) => DropdownMenuItem<String?>(value: e, child: Text(e)),
                ),
              ],
              onChanged: onTransChanged,
            ),
            const SizedBox(width: 8),
            _PillDropdown<SortOrder>(
              icon: Icons.sort,
              value: sortOrder,
              label: sortOrder == SortOrder.priceAsc
                  ? t.priceLowHigh
                  : t.priceHighLow,
              items: [
                DropdownMenuItem(
                  value: SortOrder.priceAsc,
                  child: Text(t.priceLowHigh),
                ),
                DropdownMenuItem(
                  value: SortOrder.priceDesc,
                  child: Text(t.priceHighLow),
                ),
              ],
              onChanged: (v) {
                if (v != null) onSortChanged(v);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PillDropdown<T> extends StatelessWidget {
  const _PillDropdown({
    required this.icon,
    required this.value,
    required this.label,
    required this.items,
    required this.onChanged,
  });
  final IconData icon;
  final T? value;
  final String label;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isDense: true,
          items: items,
          onChanged: onChanged,
          icon: const Icon(Icons.arrow_drop_down),
          selectedItemBuilder: (_) => items.map((e) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18),
                const SizedBox(width: 6),
                Text(label),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
