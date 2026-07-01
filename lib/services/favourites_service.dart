import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavouritesService {
  static String get _uid => FirebaseAuth.instance.currentUser!.uid;

  static bool get isLoggedIn {
    return FirebaseAuth.instance.currentUser != null;
  }

  static CollectionReference<Map<String, dynamic>> get _favoritesRef {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .collection('favorites');
  }

  static Future<List<String>> getFavourites() async {
    final snapshot = await _favoritesRef.get();

    return snapshot.docs.map((doc) => doc.id).toList();
  }

  static Future<bool> toggleFavourite(String serviceId) async {
    final doc = await _favoritesRef.doc(serviceId).get();

    if (doc.exists) {
      await _favoritesRef.doc(serviceId).delete();
      return false;
    } else {
      await _favoritesRef.doc(serviceId).set({
        'createdAt': FieldValue.serverTimestamp(),
      });
      return true;
    }
  }

  static Future<bool> isFavourite(String serviceId) async {
    final favourites = await getFavourites();
    return favourites.contains(serviceId);
  }
}
