import 'package:flutter/material.dart';
import '../models/car.dart';
import 'booking_form_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../l10n/localizations.dart';

class CarDetailScreen extends StatelessWidget {
  const CarDetailScreen({super.key, required this.car});
  static const routeName = '/car-detail';
  final Car car;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('${car.brand} ${car.name}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (car.imageUrl != null)
                    CachedNetworkImage(
                      imageUrl: car.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (_, __, ___) => car.imageAsset != null
                          ? SvgPicture.asset(
                              car.imageAsset!,
                              width: 200,
                              height: 120,
                            )
                          : const Icon(Icons.directions_car_filled, size: 72),
                    )
                  else if (car.imageAsset != null)
                    SvgPicture.asset(car.imageAsset!, width: 200, height: 120)
                  else
                    const Icon(Icons.directions_car_filled, size: 72),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.05),
                            Colors.black.withValues(alpha: 0.15),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(t.specs, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _SpecChip(icon: Icons.category, label: car.type),
                _SpecChip(icon: Icons.event_seat, label: '${car.seats} seats'),
                _SpecChip(icon: Icons.settings, label: car.transmission),
                _SpecChip(
                  icon: Icons.attach_money,
                  label: '${t.formatCurrency(car.pricePerDay)}/day',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 12,
                  color: car.isAvailable ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(car.isAvailable ? t.available : t.unavailable),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: car.isAvailable
                    ? () {
                        Navigator.pushNamed(
                          context,
                          BookingFormScreen.routeName,
                          arguments: car,
                        );
                      }
                    : null,
                child: Text(t.bookNow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpecChip extends StatelessWidget {
  const _SpecChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon, size: 16), const SizedBox(width: 6), Text(label)],
      ),
    );
  }
}
