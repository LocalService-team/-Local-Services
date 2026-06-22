import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../theme/app_colors.dart';
import '../screens/service_detail_screen.dart';
import '../screens/home_screen.dart';
import '../utils/responsive.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = HomeScreen.allServices
        .where((s) => s.latitude != null && s.longitude != null)
        .toList();
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryTeal,
        title: const Text('نقشه خدمات', style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(34.5253, 69.1783),
          initialZoom: 14,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.local_services',
          ),
          MarkerLayer(
            markers: services.map((service) {
              return Marker(
                point: LatLng(service.latitude!, service.longitude!),
                width: isTablet ? 180 : 120,
                height: isTablet ? 90 : 70,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ServiceDetailScreen(service: service),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryTeal,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)],
                        ),
                        child: Text(
                          service.titleFa,
                          style: const TextStyle(color: Colors.white, fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.location_pin, color: Colors.red, size: 32),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
