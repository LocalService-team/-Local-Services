import 'package:flutter/material.dart';
import '../models/service.dart';
import '../theme/app_colors.dart';
import '../widgets/service_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
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
      imageUrl:
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=500',
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
      imageUrl:
          'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=500',
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
      imageUrl:
          'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=500',
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
      imageUrl:
          'https://images.unsplash.com/photo-1599307772528-187c53b3189c?w=500',
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
      imageUrl:
          'https://images.unsplash.com/photo-1621370845358-18e80eb0b329?w=500',
      phone: '0704567890',
      latitude: 34.5200,
      longitude: 69.1850,
    ),
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';

  final List<Service> services = [
    Service(
      id: 'bakery_01',
      categoryKey: 'serviceBakery',
      titleEn: 'Ahmads Bakery',
      titleFa: 'Ahmads Bakery FA',
      titlePs: 'Ahmads Bakery PS',
      addressEn: 'Karte 3, Kabul',
      addressFa: 'Karte 3, Kabul FA',
      addressPs: 'Karte 3, Kabul PS',
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1599307772528-187c53b3189c?w=500',
      phone: '0700000000',
      latitude: null,
      longitude: null,
    ),
    Service(
      id: 'pharmacy_01',
      categoryKey: 'servicePharmacy',
      titleEn: 'Salam Pharmacy',
      titleFa: 'Salam Pharmacy FA',
      titlePs: 'Salam Pharmacy PS',
      addressEn: 'City Centre, Kabul',
      addressFa: 'City Centre, Kabul FA',
      addressPs: 'City Centre, Kabul PS',
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-1621370845358-18e80eb0b329?w=500',
      phone: '0701234567',
      latitude: null,
      longitude: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
    final filteredServices = services
        .where(
          (s) => s
              .getTitle(langCode)
              .toLowerCase()
              .contains(searchQuery.toLowerCase()),
        )
        .toList();
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130 + statusBarHeight),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, statusBarHeight + 20, 20, 20),
          decoration: const BoxDecoration(
            color: AppColors.primaryTeal,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 28,
                  ),
                  const Text(
                    'Local Services',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  onChanged: (value) => setState(() => searchQuery = value),
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Suggested Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: filteredServices.isEmpty
                    ? const Center(child: Text('No results'))
                    : ListView.builder(
                        itemCount: filteredServices.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: ServiceCard(
                              service: filteredServices[index],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
