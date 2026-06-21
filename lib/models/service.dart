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

  factory Service.fromFirestore(Map<String, dynamic> data, String id) {
    return Service(
      id: id,
      categoryKey: data['categoryKey'] ?? '',
      titleEn: data['title_en'] ?? '',
      titleFa: data['title_fa'] ?? '',
      titlePs: data['title_ps'] ?? '',
      addressEn: data['address_en'] ?? '',
      addressFa: data['address_fa'] ?? '',
      addressPs: data['address_ps'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      phone: data['phone'] ?? '',
      latitude: data['latitude']?.toDouble(),
      longitude: data['longitude']?.toDouble(),
    );
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
