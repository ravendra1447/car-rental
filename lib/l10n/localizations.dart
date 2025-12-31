import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Locale get locale => _locale;
  void setLocale(Locale l) {
    _locale = l;
    notifyListeners();
  }
}

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static const supportedLocales = [Locale('en'), Locale('hi')];

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  String get appTitle => _t({'en': 'Car Rental', 'hi': 'कार रेंटल'});
  String get tagline => _t({
    'en': 'Book your ride in minutes',
    'hi': 'कुछ मिनटों में गाड़ी बुक करें',
  });
  String get yourName => _t({'en': 'Your Name', 'hi': 'आपका नाम'});
  String get continueLabel => _t({'en': 'Continue', 'hi': 'आगे बढ़ें'});
  String get continueGuest =>
      _t({'en': 'Continue as Guest', 'hi': 'मेहमान के रूप में जारी रखें'});
  String get availableCars =>
      _t({'en': 'Available Cars', 'hi': 'उपलब्ध गाड़ियाँ'});
  String get available => _t({'en': 'Available', 'hi': 'उपलब्ध'});
  String get unavailable => _t({'en': 'Unavailable', 'hi': 'अनुपलब्ध'});
  String get bookNow => _t({'en': 'Book Now', 'hi': 'बुक करें'});
  String get bookingDetails =>
      _t({'en': 'Booking Details', 'hi': 'बुकिंग विवरण'});
  String get fullName => _t({'en': 'Full Name', 'hi': 'पूरा नाम'});
  String get pickupLocation =>
      _t({'en': 'Pickup Location', 'hi': 'पिकअप स्थान'});
  String get startDate => _t({'en': 'Start Date', 'hi': 'प्रारंभ तिथि'});
  String get endDate => _t({'en': 'End Date', 'hi': 'समाप्ति तिथि'});
  String get selectDate => _t({'en': 'Select date', 'hi': 'तिथि चुनें'});
  String get confirmBooking =>
      _t({'en': 'Confirm Booking', 'hi': 'बुकिंग की पुष्टि करें'});
  String get bookingConfirmed =>
      _t({'en': 'Booking Confirmed', 'hi': 'बुकिंग पुष्टि'});
  String get backToHome => _t({'en': 'Back to Home', 'hi': 'होम पर वापस'});
  String get thankYou => _t({'en': 'Thank you', 'hi': 'धन्यवाद'});
  String get specs => _t({'en': 'Specifications', 'hi': 'विशेष विवरण'});
  String get cars => _t({'en': 'Cars', 'hi': 'गाड़ियाँ'});
  String get filters => _t({'en': 'Filters', 'hi': 'फ़िल्टर्स'});
  String get sortBy => _t({'en': 'Sort by', 'hi': 'सॉर्ट करें'});
  String get priceLowHigh =>
      _t({'en': 'Price: Low to High', 'hi': 'कीमत: कम से अधिक'});
  String get priceHighLow =>
      _t({'en': 'Price: High to Low', 'hi': 'कीमत: अधिक से कम'});
  String get historyTitle =>
      _t({'en': 'Booking History', 'hi': 'बुकिंग इतिहास'});
  String get totalLabel => _t({'en': 'Total', 'hi': 'कुल'});
  String formatCurrency(num amount) {
    final tag = locale.languageCode == 'hi' ? 'hi_IN' : 'en_IN';
    final formatter = NumberFormat.currency(
      locale: tag,
      symbol: '₹',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  String _t(Map<String, String> map) => map[locale.languageCode] ?? map['en']!;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    Intl.defaultLocale = locale.languageCode;
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
