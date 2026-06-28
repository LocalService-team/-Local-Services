# Local Services App

A Flutter mobile application that helps users in Kabul, Afghanistan find local services such as plumbers, electricians, cleaners, bakeries, pharmacies, and transport. The app supports three languages: English, Dari (دری), and Pashto (پښتو).

## Features

- Browse local services in Kabul by category
- Search for services by name or address
- View service details including rating, phone, and address
- Call a service directly from the app
- Save favourite services
- Interactive map showing service locations
- Multilingual support: English, Dari, and Pashto
- Firebase Authentication (login, register, guest access)
- Real-time data powered by Firebase Firestore
- Push notifications support
- Clean, modern UI with animated bottom navigation

## Tech Stack

- Flutter / Dart
- Firebase Firestore (real-time database)
- Firebase Authentication
- Firebase Core
- Flutter Map (OpenStreetMap)
- Shared Preferences (favourites)
- Flutter Localizations (intl)
- URL Launcher

## Screens

- **Welcome** — App introduction and get started
- **Login / Register** — Firebase Auth with guest access
- **Home** — Browse categories and search services
- **Map** — Interactive map with nearby and favourite tabs
- **Service List** — Filtered services by category
- **Service Detail** — Full details with call button
- **Favourites** — Saved services
- **Profile** — Language switcher and logout
- **Notifications** — App notifications

## Languages Supported

| Language | Code |
|----------|------|
| English  | en   |
| Dari     | fa   |
| Pashto   | ps   |

## How to Run

1. Clone the repository:
```bash
   git clone https://github.com/LocalService-team/-Local-Services.git
```
2. Install dependencies:
```bash
   flutter pub get
```
3. Run the app:
```bash
   flutter run
```

## Project Structure

```
lib/
├── data/          # Local service data
├── l10n/          # Localisation files (en, fa, ps)
├── models/        # Data models
├── screens/       # App screens
├── services/      # Firebase and local services
├── theme/         # App colours and theme
└── widgets/       # Reusable widgets
```