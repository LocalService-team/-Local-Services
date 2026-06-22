import 'package:flutter/material.dart';
import '../data/service_data.dart';
import '../models/service.dart';
import '../theme/app_colors.dart';
import '../screens/service_list_screen.dart';
import '../screens/service_detail_screen.dart';
import '../widgets/category_card.dart';
import 'map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. VARIABLE MUST BE HERE, NOT INSIDE BUILD
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final langCode = Localizations.localeOf(context).languageCode;

    final filteredServices = ServiceData.allServices.where((service) =>
        service.matchesSearch(_searchQuery)
    ).toList();

    final List<Map<String, dynamic>> categories = [
      {'key': 'serviceBakery', 'label': 'نانوایی', 'icon': Icons.bakery_dining, 'color': const Color(0xFF8B7355)},
      {'key': 'servicePharmacy', 'label': 'دواخانه', 'icon': Icons.local_pharmacy, 'color': const Color(0xFF6B8E6B)},
      {'key': 'serviceTransport', 'label': 'ترانسپورت', 'icon': Icons.directions_car, 'color': const Color(0xFFD4A853)},
      {'key': 'servicePlumber', 'label': 'خدمات در محل', 'icon': Icons.build, 'color': const Color(0xFF8B7355)},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      body: Column(
        children: [
          _buildHeader(statusBarHeight, filteredServices),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text('دسته‌بندی‌ها', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                const SizedBox(height: 16),

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  children: categories.map((cat) => CategoryCard(
                    label: cat['label'],
                    icon: cat['icon'],
                    color: cat['color'],
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (_) => ServiceListScreen(categoryKey: cat['key'], categoryLabel: cat['label'], services: ServiceData.allServices),
                    )),
                  )).toList(),
                ),
                const SizedBox(height: 24),
                const Text('خدمات پیشنهادی', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                const SizedBox(height: 16),
                ...filteredServices.map((service) => _buildServiceCard(service, langCode)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(double statusBarHeight, List<Service> filtered) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, statusBarHeight + 20, 20, 20),
      decoration: const BoxDecoration(color: AppColors.primaryTeal, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.person, color: Colors.white)),
              const Text('خدمات محلی', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.map, color: Colors.white, size: 28), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen(services: filtered)))),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
              textAlign: TextAlign.right,
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: const InputDecoration(hintText: 'جستجو...', prefixIcon: Icon(Icons.search, color: Colors.grey), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Service service, String langCode) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black12, offset: Offset(0, 2))]),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: SizedBox(width: 60, height: 60, child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(service.imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.broken_image)))),
        title: Text(service.getTitle(langCode), style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right),
        subtitle: Text(service.getAddress(langCode), textAlign: TextAlign.right, style: const TextStyle(fontSize: 12)),
        trailing: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ServiceDetailScreen(service: service))), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryTeal, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: const Text('مشاهده', style: TextStyle(color: Colors.white))),
      ),
    );
  }
}