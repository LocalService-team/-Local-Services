import 'package:flutter/material.dart';
import '../data/service_data.dart';
import '../data/service_data.dart' as HomeScreen;
import '../models/service.dart';
import '../theme/app_colors.dart';
import '../screens/service_detail_screen.dart';

class ServiceListScreen extends StatefulWidget {
  final String? categoryKey;
  final String? categoryLabel;
  final List<Service>? services;

  const ServiceListScreen({
    super.key,
    this.categoryKey,
    this.categoryLabel,
    this.services,
  });

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
    final allServices = widget.services ?? HomeScreen.ServiceData.allServices;

    final filtered = allServices.where((s) {
      final matchesCategory = widget.categoryKey == null ||
          s.categoryKey == widget.categoryKey;
      final matchesSearch = searchQuery.isEmpty ||
          s.getTitle(langCode).toLowerCase().contains(searchQuery.toLowerCase()) ||
          s.getAddress(langCode).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryTeal,
        title: Text(
          widget.categoryLabel ?? 'خدمات',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                textAlign: TextAlign.right,
                onChanged: (value) => setState(() => searchQuery = value),
                decoration: const InputDecoration(
                  hintText: 'جستجو...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
          ),
        ),
      ),
      body: filtered.isEmpty
          ? const Center(child: Text('No services found'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final service = filtered[index];
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
                              width: 60, height: 60, fit: BoxFit.cover)
                          : Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.build),
                            ),
                    ),
                    title: Text(
                      service.getTitle(langCode),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                    subtitle: Text(
                      service.getAddress(langCode),
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ServiceDetailScreen(service: service),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryTeal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('مشاهده', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
