# Local Services App

A Flutter mobile application that helps users in Kabul, Afghanistan find local services such as plumbers, electricians, and cleaners. The app supports three languages: English, Dari (دری), and Pashto (پښتو).

## Features
- Browse local services in Kabul
- Search for services by name or category
- View service details including rating, address, and contact
- Multilingual support: English, Dari, and Pashto
- Real-time data powered by Firebase Firestore
- Clean, modern UI with bottom navigation

## Tech Stack
- Flutter / Dart
- Firebase Firestore (real-time database)
- Firebase Core
- Flutter Localizations (intl)
- Google Fonts

## Screens
- **Home** — Browse and search services
- **Service Detail** — View full details of a service
- **Map** — Location view (placeholder)
- **Favourites** — Saved services (placeholder)
- **Profile** — User profile (placeholder)

## Languages Supported
| Language | Code |
|---|---|
| English | en |
| Dari | fa |
| Pashto | ps |

## How to Run
1. Clone the repository:git clone https://github.com/LocalService-team/-Local-Services.git
2. Install dependencies:
flutter pub get
3. Run the app:
flutter run

## Team Contributions
| Team Member | Feature | Branch |
|---|---|---|
| Latifa | Home UI | feature/home-ui |
| Sharifa | Service List Page | feature/service-list-ui |
| Marwa | Service Detail Screen | feature/service-detail-ui |
| Marwa Hashimi | Widgets | feature/ui-widgets |
| Eshwa | Theme | feature/theme |
| Wazhma | Navigation | feature/navigation |
| Elham | Responsive UI | feature/responsive-ui |
| Zakia | UI Fixes | feature/ui-fixes |

## Project Structure
lib/

├── l10n/          # Localisation files (en, fa, ps)

├── models/        # Data models

├── screens/       # App screens

├── theme/         # App colours and theme

└── widgets/       # Reusable widgets
