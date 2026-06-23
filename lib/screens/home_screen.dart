import 'package:flutter/material.dart';
import 'package:local_services/screens/notifications_screen.dart';
import '../models/service.dart';
import '../theme/app_colors.dart';
import '../screens/service_list_screen.dart';
import '../screens/service_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onSettingsPressed;
  const HomeScreen({super.key,  required this.onSettingsPressed,});
  static final List<Service> allServices = [
    Service(
      id: '1',
      categoryKey: 'servicePlumber',
      titleEn: "Ahmed's Plumbing",
      titleFa: 'تاسیسات احمد',
      titlePs: 'د احمد پایپ کاري',
      addressEn: 'Karte Char, Kabul',
      addressFa: 'کارته چهار، کابل',
      addressPs: 'کارته څلور، کابل',
      rating: 4.8,
      imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=500',
      phone: '0700123456',
      latitude: 34.5089,
      longitude: 69.1811,
    ),
    Service(
      id: '2',
      categoryKey: 'serviceElectrician',
      titleEn: 'Karimi Electrical',
      titleFa: 'خدمات برقی کریمی',
      titlePs: 'د کریمي بریښنایي خدمتونه',
      addressEn: 'Share Naw, Kabul',
      addressFa: 'شهر نو، کابل',
      addressPs: 'ښار نو، کابل',
      rating: 4.5,
      imageUrl: 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=500',
      phone: '0701234567',
      latitude: 34.5253,
      longitude: 69.1783,
    ),
    Service(
      id: '3',
      categoryKey: 'serviceCleaner',
      titleEn: 'Kabul Clean Co.',
      titleFa: 'شرکت نظافت کابل',
      titlePs: 'د کابل د صفایی شرکت',
      addressEn: 'Wazir Akbar Khan, Kabul',
      addressFa: 'وزیر اکبر خان، کابل',
      addressPs: 'وزیر اکبر خان، کابل',
      rating: 4.2,
      imageUrl: 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=500',
      phone: '0702345678',
      latitude: 34.5333,
      longitude: 69.2167,
    ),
    Service(
      id: '4',
      categoryKey: 'serviceBakery',
      titleEn: "Ahmad's Bakery",
      titleFa: 'نانوایی احمد',
      titlePs: 'د احمد ډوډۍ پخونه',
      addressEn: 'Karte 3, Kabul',
      addressFa: 'کابل، کارته ۳',
      addressPs: 'کابل، کارته ۳',
      rating: 4.8,
      imageUrl: 'https://images.unsplash.com/photo-1599307772528-187c53b3189c?w=500',
      phone: '0703456789',
      latitude: 34.5150,
      longitude: 69.1900,
    ),
    Service(
      id: '5',
      categoryKey: 'servicePharmacy',
      titleEn: 'Salam Pharmacy',
      titleFa: 'دواخانه سلام',
      titlePs: 'د سلام درملتون',
      addressEn: 'City Centre, Kabul',
      addressFa: 'کابل، مرکز شهر',
      addressPs: 'کابل، د ښار مرکز',
      rating: 4.7,
      imageUrl: 'https://images.unsplash.com/photo-1621370845358-18e80eb0b329?w=500',
      phone: '0704567890',
      latitude: 34.5200,
      longitude: 69.1850,
    ),
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Map<String, String>> allItems = [
    {'name_dr': 'نانوایی', 'name_en': 'bakery'},
    {'name_dr': 'دواخانه', 'name_en': 'pharmacy'},
    {'name_dr': 'ترانسپورت', 'name_en': 'transport'},
    {'name_dr': 'خدمات در محل', 'name_en': 'local services'},
  ];

  List<Map<String, String>> displayedItems = [];

  @override
  void initState() {
    super.initState();
    displayedItems = allItems;
  }

  void _filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        displayedItems = allItems;
      });
      return;
    }

    setState(() {
      displayedItems = allItems.where((item) {
        final drName = item['name_dr']!.toLowerCase();
        final enName = item['name_en']!.toLowerCase();
        final searchLower = query.toLowerCase();


        return drName.contains(searchLower) || enName.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final langCode = Localizations.localeOf(context).languageCode;

    final List<Map<String, dynamic>> categories = [
      {'key': 'serviceBakery', 'labelFa': 'نانوایی', 'icon': Icons.bakery_dining, 'color': const Color(0xFF8B7355)},
      {'key': 'servicePharmacy', 'labelFa': 'دواخانه', 'icon': Icons.local_pharmacy, 'color': const Color(0xFF6B8E6B)},
      {'key': 'serviceTransport', 'labelFa': 'ترانسپورت', 'icon': Icons.directions_car, 'color': const Color(0xFFD4A853)},
      {'key': 'servicePlumber', 'labelFa': 'خدمات در محل', 'icon': Icons.build, 'color': const Color(0xFF8B7355)},
    ];

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

                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white),
                      onPressed: widget.onSettingsPressed,
                    ),


                    const Text('خدمات محلی',
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
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
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  child: TextField(
                    textAlign: TextAlign.right,
                    onChanged: (value) {
                      _filterSearchResults(value);
                    },
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
                              services: HomeScreen.allServices,
                            ),
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: (cat['color'] as Color).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: (cat['color'] as Color).withValues(alpha: 0.3)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(cat['icon'] as IconData, size: 48, color: cat['color'] as Color),
                              const SizedBox(height: 12),
                              Text(cat['labelFa'],
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: cat['color'] as Color)),
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
                  ...HomeScreen.allServices.map((service) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black12, offset: Offset(0, 2))],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(service.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                      ),
                      title: Text(service.getTitle(langCode),
                          style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                      subtitle: Text(service.getAddress(langCode),
                          textAlign: TextAlign.right, style: const TextStyle(fontSize: 12)),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) => ServiceDetailScreen(service: service),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryTeal,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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