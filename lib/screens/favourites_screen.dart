import 'package:flutter/material.dart';
import '../data/service_data.dart';
import '../models/service.dart';
import '../theme/app_colors.dart';
import '../screens/service_detail_screen.dart';
import '../services/favourites_service.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<Service> _favourites = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    final ids = await FavouritesService.getFavourites();
    setState(() {
      _favourites = ServiceData.allServices
          .where((s) => ids.contains(s.id))
          .toList();
      _isLoading = false;
    });
  }

  Future<void> _removeFavourite(String id) async {
    await FavouritesService.toggleFavourite(id);
    await _loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      appBar: AppBar(
        backgroundColor: AppColors.servicesHeader,
        title: const Text('علاقه‌مندی‌ها', style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favourites.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border, size: 80, color: Colors.grey.shade300),
                      const SizedBox(height: 16),
                      const Text('هیچ خدمتی ذخیره نشده',
                        style: TextStyle(fontSize: 18, color: Colors.grey)),
                      const SizedBox(height: 8),
                      const Text('برای ذخیره خدمات، روی قلب کلیک کنید',
                        style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _favourites.length,
                  itemBuilder: (context, index) {
                    final service = _favourites[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(blurRadius: 8, color: Colors.black12, offset: Offset(0, 2)),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: service.imageUrl.isNotEmpty
                              ? Image.network(service.imageUrl,
                                  width: 60, height: 60, fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 60, height: 60,
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.build),
                                  ))
                              : Container(width: 60, height: 60,
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.build)),
                        ),
                        title: Text(service.getTitle(langCode),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right),
                        subtitle: Text(service.getAddress(langCode),
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 12)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.favorite, color: Colors.red),
                              onPressed: () => _removeFavourite(service.id),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (_) => ServiceDetailScreen(service: service),
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.servicesHeader,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text('مشاهده', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
