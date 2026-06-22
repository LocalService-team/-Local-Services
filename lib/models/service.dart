import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  final String id;
  final String categoryKey;
  final String titleEn;
  final String titleFa;
  final String titlePs;
  final String addressEn;
  final String addressFa;
  final String addressPs;
  final double rating;
  final String imageUrl;
  final String phone;
  final double? latitude;
  final double? longitude;

  Service({
    required this.id,
    required this.categoryKey,
    required this.titleEn,
    required this.titleFa,
    required this.titlePs,
    required this.addressEn,
    required this.addressFa,
    required this.addressPs,
    required this.rating,
    required this.imageUrl,
    this.phone = '',
    this.latitude,
    this.longitude,
  });

  // Single, clean factory for Firestore
  factory Service.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Service(
      id: doc.id,
      categoryKey: data['categoryKey'] ?? '',
      titleEn: data['titleEn'] ?? '',
      titleFa: data['titleFa'] ?? '',
      titlePs: data['titlePs'] ?? '',
      addressEn: data['addressEn'] ?? '',
      addressFa: data['addressFa'] ?? '',
      addressPs: data['addressPs'] ?? '',
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      imageUrl: data['imageUrl'] ?? '',
      phone: data['phone'] ?? '',
      latitude: (data['latitude'] as num?)?.toDouble(),
      longitude: (data['longitude'] as num?)?.toDouble(),
    );
  }

  bool matchesSearch(String query) {
    final lowerQuery = query.toLowerCase();
    return titleEn.toLowerCase().contains(lowerQuery) ||
        titleFa.contains(lowerQuery) ||
        titlePs.contains(lowerQuery) ||
        addressEn.toLowerCase().contains(lowerQuery) ||
        addressFa.contains(lowerQuery) ||
        addressPs.contains(lowerQuery);
  }

  String getTitle(String languageCode) {
    switch (languageCode) {
      case 'fa': return titleFa;
      case 'ps': return titlePs;
      default: return titleEn;
    }
  }

  String getAddress(String languageCode) {
    switch (languageCode) {
      case 'fa': return addressFa;
      case 'ps': return addressPs;
      default: return addressEn;
    }
  }
}