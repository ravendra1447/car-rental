# Car Rental — Flutter App

A modern, responsive Flutter app for browsing cars, filtering and sorting, booking with localized INR currency, and viewing booking history. Built with Riverpod for state management and Shared Preferences for local persistence.

## Overview

- Clean Material 3 UI with attractive cards and real images
- Filters in a single compact row (Type, Transmission, Sort)
- English and Hindi localization with Indian currency formatting (₹, en_IN/hi_IN)
- Booking flow: details, validation, confirmation, and persisted history
- Responsive list/grid layout for phones and larger screens

## Features

- Browse cars with specs, price per day, and availability
- Real network images with caching and graceful fallback to SVG assets
- Filter by type and transmission; sort by price
- Booking creation with name, dates, and pickup location
- Booking history with mock data plus saved bookings
- Language switcher in UI (English/Hindi)

## Tech Stack

- Flutter SDK
- Riverpod (flutter_riverpod) for state
- Shared Preferences for local storage
- intl for currency and locale formatting
- cached_network_image for images with caching and placeholders
- flutter_svg for asset fallbacks
- flutter_localizations for localization hooks

## Directory Structure

- App entry: [main.dart](file:///r:/car_rental/lib/main.dart)
- App scaffold and routes: [app.dart](file:///r:/car_rental/lib/app.dart)
- Localization: [localizations.dart](file:///r:/car_rental/lib/l10n/localizations.dart)
- Providers:
  - Auth: [auth_provider.dart](file:///r:/car_rental/lib/providers/auth_provider.dart)
  - Cars: [car_provider.dart](file:///r:/car_rental/lib/providers/car_provider.dart)
  - Filters: [filter_provider.dart](file:///r:/car_rental/lib/providers/filter_provider.dart)
  - Locale: [locale_provider.dart](file:///r:/car_rental/lib/providers/locale_provider.dart)
  - Booking: [booking_provider.dart](file:///r:/car_rental/lib/providers/booking_provider.dart)
- Models: [car.dart](file:///r:/car_rental/lib/models/car.dart), [booking.dart](file:///r:/car_rental/lib/models/booking.dart)
- Data: [mock_cars.dart](file:///r:/car_rental/lib/data/mock_cars.dart), [mock_bookings.dart](file:///r:/car_rental/lib/data/mock_bookings.dart)
- Storage: [booking_repository.dart](file:///r:/car_rental/lib/repositories/booking_repository.dart)
- Screens:
  - Welcome/Login: [welcome_login_screen.dart](file:///r:/car_rental/lib/screens/welcome_login_screen.dart)
  - Car List: [car_list_screen.dart](file:///r:/car_rental/lib/screens/car_list_screen.dart)
  - Car Detail: [car_detail_screen.dart](file:///r:/car_rental/lib/screens/car_detail_screen.dart)
  - Booking Form: [booking_form_screen.dart](file:///r:/car_rental/lib/screens/booking_form_screen.dart)
  - Booking Confirmation: [booking_confirmation_screen.dart](file:///r:/car_rental/lib/screens/booking_confirmation_screen.dart)
  - Booking History: [booking_history_screen.dart](file:///r:/car_rental/lib/screens/booking_history_screen.dart)
- Assets: [assets/images](file:///r:/car_rental/assets/images)
- Dependencies: [pubspec.yaml](file:///r:/car_rental/pubspec.yaml)

## How It Works

1. Launch app to the Welcome/Login screen
   - Enter name or continue as Guest
   - Optional language switch (English/Hindi)
2. Car List
   - Responsive: list on phones, grid on larger screens
   - One-line filters: Type, Transmission, Sort
   - Tap a car to view details
3. Car Detail
   - Real image banner with graceful fallback
   - Specs and localized price per day in ₹
   - Book Now (disabled when unavailable)
4. Booking Form
   - Name (prefilled), pickup location, start/end dates
   - Validation ensures completeness; shows price/day indicator
   - Confirm booking stores to local history
5. Booking Confirmation
   - Displays summary: car, dates, days, location, total in ₹
   - Back to Home
6. Booking History
   - Access via history icon in car list app bar
   - Shows mock entries (first run) plus your saved bookings
   - Attractive cards with image, dates, location, and total

## State Management

- Riverpod State/Provider/AsyncNotifier patterns
  - User name: [auth_provider.dart](file:///r:/car_rental/lib/providers/auth_provider.dart)
  - Car data: [car_provider.dart](file:///r:/car_rental/lib/providers/car_provider.dart)
  - Filters/sort derived list: [filter_provider.dart](file:///r:/car_rental/lib/providers/filter_provider.dart)
  - Locale state: [locale_provider.dart](file:///r:/car_rental/lib/providers/locale_provider.dart)
  - Bookings: [booking_provider.dart](file:///r:/car_rental/lib/providers/booking_provider.dart)

## Data and Persistence

- Mock cars: [mock_cars.dart](file:///r:/car_rental/lib/data/mock_cars.dart)
- Mock bookings: [mock_bookings.dart](file:///r:/car_rental/lib/data/mock_bookings.dart)
- Persistence: [booking_repository.dart](file:///r:/car_rental/lib/repositories/booking_repository.dart) uses SharedPreferences
  - On load: returns saved list; falls back to mock if empty
  - On confirm: appends booking to saved list

## Localization and Currency

- Localizations: English and Hindi
- Currency: Always Indian rupee (₹) with Indian grouping formats
  - Formatter: [localizations.dart](file:///r:/car_rental/lib/l10n/localizations.dart#L24-L31)
  - UI strings fetched via AppLocalizations.of(context)

## Images

- Cached network images with placeholder and error widgets
- Fallback to SVG assets if network fails
  - List: [car_list_screen.dart](file:///r:/car_rental/lib/screens/car_list_screen.dart#L156-L181)
  - Detail: [car_detail_screen.dart](file:///r:/car_rental/lib/screens/car_detail_screen.dart#L28-L55)
  - History: [booking_history_screen.dart](file:///r:/car_rental/lib/screens/booking_history_screen.dart#L63-L79)

## Setup

1. Install Flutter SDK and set up an emulator/device
2. Navigate to project root
3. Install dependencies:
   - `flutter pub get`

## Run

- Static checks:
  - `flutter analyze`
- Tests:
  - `flutter test`
- Launch app:
  - `flutter run`

## Live Demo (GitHub Pages)

- This repo is configured to build Flutter Web and deploy to GitHub Pages on each push to `main`.
- After pushing to `main`, your app will be available at:
  - `https://<your-github-username>.github.io/<repository-name>/`
- Workflow file: [.github/workflows/deploy_web.yml](file:///r:/car_rental/.github/workflows/deploy_web.yml)
- Notes:
  - Uses `--base-href "/<repo>/"` for correct asset paths on Pages
  - No extra secrets needed; uses default `GITHUB_TOKEN`

## Demo Video

- Place your demo video at `assets/demo/demo.mp4`
- Embedded preview in README:

<video src="assets/demo/demo.mp4" controls poster="assets/images/car_tesla.svg" width="720">
  Your browser does not support the video tag.
</video>

## Troubleshooting

- Network images not loading:
  - Check internet connection and URL accessibility
  - Fallback SVG assets should still display
- Localization not switching:
  - Use language switcher in Welcome/Car List
  - Restart not required; state updates instantly
- Shared Preferences not persisting:
  - Ensure app has write permissions and not running in a restricted environment

## Extending

- Add real backend API for cars and bookings
- Authentication and roles
- Rich filters (price range, brand)
- Promo codes and discounts
- Map-based pickup selection and multi-city support
