import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../l10n/app_localizations.dart';
import '../models/service.dart';

class ServiceListScreen extends StatelessWidget {
  const ServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final languageCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('service').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text('No services available yet.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final serviceData = docs[index].data() as Map<String, dynamic>;
              final service = Service.fromFirestore(serviceData, docs[index].id);

              // Get translated category label
              String translatedCategory = service.categoryKey;
              if (service.categoryKey == 'servicePlumber') translatedCategory = localizations.servicePlumber;
              if (service.categoryKey == 'serviceElectrician') translatedCategory = localizations.serviceElectrician;
              if (service.categoryKey == 'serviceCleaner') translatedCategory = localizations.serviceCleaner;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
                child: ListTile(
                  leading: service.imageUrl.isNotEmpty
                      ? CircleAvatar(backgroundImage: NetworkImage(service.imageUrl))
                      : const CircleAvatar(child: Icon(Icons.build)),
                  title: Text(
                    service.getTitle(languageCode), // ✅ shows right language
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translatedCategory,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text('${service.rating}'),
                          const SizedBox(width: 8),
                          const Icon(Icons.location_on, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              service.getAddress(languageCode), // ✅ shows right language
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
              );
            },
          );
        },
      ),
    );
  }
}