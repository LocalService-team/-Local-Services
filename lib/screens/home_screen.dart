import 'package:flutter/material.dart';
import '../models/service.dart';
import '../theme/app_colors.dart';
import '../widgets/service_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      imageUrl: 'https://images.unsplash.com/photo-1599307772528-187c53b3189c?w=500',
      phone: '0700000000',
      latitude: null, longitude: null,
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
      imageUrl: 'https://images.unsplash.com/photo-1621370845358-18e80eb0b329?w=500',
      phone: '0701234567',
      latitude: null, longitude: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
    final filteredServices = services.where((s) =>
      s.getTitle(langCode).toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
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
                  const Icon(Icons.notifications_none, color: Colors.white, size: 28),
                  const Text('Local Services',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
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
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
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
              const Text('Suggested Services',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
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
                            child: ServiceCard(service: filteredServices[index]),
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
