import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/welcome_login_screen.dart';
import 'screens/car_list_screen.dart';
import 'screens/car_detail_screen.dart';
import 'screens/booking_form_screen.dart';
import 'screens/booking_confirmation_screen.dart';
import 'screens/booking_history_screen.dart';
import 'models/car.dart';
import 'l10n/localizations.dart';
import 'providers/locale_provider.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2C7BE5)),
      useMaterial3: true,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(centerTitle: true),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: const Color(0xFF2C7BE5)),
      ),
    );

    final locale = ref.watch(localeProvider);
    return MaterialApp(
      title: 'Car Rental',
      debugShowCheckedModeBanner: false,
      theme: theme,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: WelcomeLoginScreen.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case WelcomeLoginScreen.routeName:
            return MaterialPageRoute(
              builder: (_) => const WelcomeLoginScreen(),
            );
          case CarListScreen.routeName:
            return MaterialPageRoute(builder: (_) => const CarListScreen());
          case CarDetailScreen.routeName:
            final car = settings.arguments as Car;
            return MaterialPageRoute(builder: (_) => CarDetailScreen(car: car));
          case BookingFormScreen.routeName:
            final car = settings.arguments as Car;
            return MaterialPageRoute(
              builder: (_) => BookingFormScreen(car: car),
            );
          case BookingConfirmationScreen.routeName:
            return MaterialPageRoute(
              builder: (_) => const BookingConfirmationScreen(),
            );
          case BookingHistoryScreen.routeName:
            return MaterialPageRoute(
              builder: (_) => const BookingHistoryScreen(),
            );
          default:
            return MaterialPageRoute(
              builder: (_) => const WelcomeLoginScreen(),
            );
        }
      },
    );
  }
}
