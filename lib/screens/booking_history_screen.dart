import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/booking_provider.dart';
import '../l10n/localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookingHistoryScreen extends ConsumerWidget {
  const BookingHistoryScreen({super.key});
  static const routeName = '/booking-history';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final bookingsAsync = ref.watch(bookingListProvider);
    return Scaffold(
      appBar: AppBar(title: Text(t.historyTitle)),
      body: bookingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (bookings) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (_, i) {
            final b = bookings[i];
            return _HistoryItem(booking: b);
          },
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemCount: bookings.length,
        ),
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  const _HistoryItem({required this.booking});
  final dynamic booking;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final car = booking.car;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.surface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 90,
                height: 72,
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
                            : const Icon(Icons.directions_car, size: 36),
                      )
                    : (car.imageAsset != null
                          ? SvgPicture.asset(car.imageAsset!, fit: BoxFit.cover)
                          : const Icon(Icons.directions_car, size: 36)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${car.brand} ${car.name}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${_formatDate(booking.startDate)} → ${_formatDate(booking.endDate)} (${booking.totalDays} days)',
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: 4),
                      Text(booking.pickupLocation),
                      const Spacer(),
                      Text(
                        '${t.totalLabel}: ${t.formatCurrency(booking.totalCost)}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';
}
