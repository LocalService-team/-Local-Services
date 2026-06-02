class Service {
  final String id;
  final String categoryKey; // For your translation keys
  final String title;       // Fallback/Legacy title field for Home/Detail screens
  final String category;    // Legacy category field
  final String address;     // For detail screen
  final double rating;
  final String imageUrl;    // Matches your new string
  final String image;       // Fallback/Legacy string field for old cards

  Service({
    required this.id,
    required this.categoryKey,
    required this.title,
    required this.category,
    required this.address,
    required this.rating,
    required this.imageUrl,
    required this.image,
  });

  factory Service.fromFirestore(Map<String, dynamic> data, String id) {
    return Service(
      id: id,
      categoryKey: data['categoryKey'] ?? '',
      title: data['title'] ?? data['name'] ?? 'No Title',
      category: data['category'] ?? '',
      address: data['address'] ?? 'No Address',
      rating: (data['rating'] ?? 0.0).toDouble(),
      imageUrl: data['imageUrl'] ?? data['image'] ?? '',
      image: data['image'] ?? data['imageUrl'] ?? '',
    );
  }
}