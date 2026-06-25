import 'package:shared_preferences/shared_preferences.dart';

class FavouritesService {
  static const String _key = 'favourites';

  static Future<List<String>> getFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  static Future<void> toggleFavourite(String serviceId) async {
    final prefs = await SharedPreferences.getInstance();
    final favourites = prefs.getStringList(_key) ?? [];
    if (favourites.contains(serviceId)) {
      favourites.remove(serviceId);
    } else {
      favourites.add(serviceId);
    }
    await prefs.setStringList(_key, favourites);
  }

  static Future<bool> isFavourite(String serviceId) async {
    final favourites = await getFavourites();
    return favourites.contains(serviceId);
  }
}
