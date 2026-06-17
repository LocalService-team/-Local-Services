import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service.dart';
import '../theme/app_colors.dart';
import '../screens/service_detail_screen.dart';

class ServiceListScreen extends StatelessWidget {
  final String? categoryKey;
  final String? categoryLabel;

  const ServiceListScreen({super.key, this.categoryKey, this.categoryLabel, required List<Service> services});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryTeal,
        title: Text(categoryLabel ?? 'خدمات', style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: categoryKey != null
            ? FirebaseFirestore.instance
                .collection('service')
                .where('categoryKey', isEqualTo: categoryKey)
                .snapshots()
            : FirebaseFirestore.instance.collection('service').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text('Something went wrong'));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) return const Center(child: Text('No services available yet.'));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final service = Service.fromFirestore(
                  docs[index].data() as Map<String, dynamic>, docs[index].id);
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
                  title: Text(service.titleFa,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right),
                  subtitle: Text(service.addressFa,
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 12)),
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
          );
        },
      ),
    );
  }
}
