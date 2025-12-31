import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/booking_provider.dart';
import '../l10n/localizations.dart';

class BookingConfirmationScreen extends ConsumerWidget {
  const BookingConfirmationScreen({super.key});
  static const routeName = '/booking-confirmation';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final booking = ref.watch(currentBookingProvider);
    return Scaffold(
      appBar: AppBar(title: Text(t.bookingConfirmed)),
      body: booking == null
          ? const Center(child: Text('No booking found'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(
                            '${t.thankYou}, ${booking.customerName}!',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        t.cars,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${booking.car.brand} ${booking.car.name} (${booking.car.type})',
                      ),
                      const SizedBox(height: 12),
                      Text(
                        t.pickupLocation,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(booking.pickupLocation),
                      const SizedBox(height: 12),
                      Text(
                        'Dates',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${_formatDate(booking.startDate)} → ${_formatDate(booking.endDate)} (${booking.totalDays} days)',
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(t.formatCurrency(booking.totalCost)),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            );
                          },
                          icon: const Icon(Icons.home),
                          label: Text(t.backToHome),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  String _formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';
}
