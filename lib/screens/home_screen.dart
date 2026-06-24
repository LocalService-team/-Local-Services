import 'package:flutter/material.dart';
import '../data/service_data.dart';
import '../models/service.dart';
import '../theme/app_colors.dart';
import '../screens/service_list_screen.dart';
import '../screens/service_detail_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  final List<Map<String, dynamic>> categories = [
    {'key': 'serviceBakery', 'labelFa': 'نانوایی', 'icon': Icons.bakery_dining, 'color': const Color(0xFF8B7355)},
    {'key': 'servicePharmacy', 'labelFa': 'دواخانه', 'icon': Icons.local_pharmacy, 'color': const Color(0xFF6B8E6B)},
    {'key': 'serviceTransport', 'labelFa': 'ترانسپورت', 'icon': Icons.directions_car, 'color': const Color(0xFFD4A853)},
    {'key': 'servicePlumber', 'labelFa': 'خدمات در محل', 'icon': Icons.build, 'color': const Color(0xFF8B7355)},
  ];

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    final filteredServices = ServiceData.allServices.where((service) =>
      service.matchesSearch(_searchQuery)
    ).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, statusBarHeight + 20, 20, 20),
            decoration: const BoxDecoration(
              color: AppColors.primaryTeal,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const Text('خدمات محلی',
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                            size: 28,
                          ),

                          Positioned(
                            right: -6,
                            top: -6,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Text(
                                '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NotificationsScreen(),
                            )
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    textAlign: TextAlign.right,
                    onChanged: (value) => setState(() => _searchQuery = value),
                    decoration: const InputDecoration(
                      hintText: 'جستجو...',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('دسته‌بندی‌ها',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: categories.map((cat) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) => ServiceListScreen(
                              categoryKey: cat['key'],
                              categoryLabel: cat['labelFa'],
                              services: ServiceData.allServices,
                            ),
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: (cat['color'] as Color).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: (cat['color'] as Color).withValues(alpha: 0.3),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(cat['icon'] as IconData, size: 48, color: cat['color'] as Color),
                              const SizedBox(height: 12),
                              Text(cat['labelFa'],
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                                  color: cat['color'] as Color)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  const Text('خدمات پیشنهادی',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ...filteredServices.map((service) => Container(
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
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) => ServiceDetailScreen(service: service),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryTeal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('مشاهده', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
