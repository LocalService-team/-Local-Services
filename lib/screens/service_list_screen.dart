import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../l10n/app_localizations.dart';
import '../models/service.dart';

class ServiceListScreen extends StatelessWidget {
  const ServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This activates the localization dictionary using your new import path!
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('services').snapshots(),
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

              // Match and translate your keys dynamically
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
                    translatedCategory,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text('${service.rating}', style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Links up with your teammate's detail view later
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}