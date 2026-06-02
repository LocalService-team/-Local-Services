// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Local Services';

  @override
  String get searchHint => 'Search for services...';

  @override
  String get servicePlumber => 'Plumber';

  @override
  String get serviceElectrician => 'Electrician';

  @override
  String get serviceCleaner => 'Cleaner';
}
