import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../theme/app_colors.dart';
import '../screens/service_detail_screen.dart';
import '../models/service.dart';

class MapScreen extends StatefulWidget {
  final List<Service> services;
  const MapScreen({super.key, required this.services});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.services.where((s) =>
      s.latitude != null &&
      s.longitude != null &&
      s.matchesSearch(_searchQuery)
    ).toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(34.5253, 69.1783),
              initialZoom: 14,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://cartodb-basemaps-a.global.ssl.fastly.net/rastertiles/voyager/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.local_services',
              ),
              MarkerLayer(
                markers: filtered.map((service) => Marker(
                  point: LatLng(service.latitude!, service.longitude!),
                  width: 120,
                  height: 80,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ServiceDetailScreen(service: service),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.homeHeader,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            service.titleFa,
                            style: const TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                        const Icon(Icons.location_pin, color: Colors.red, size: 32),
                      ],
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
          Positioned(
            top: 40, left: 15, right: 15,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)],
              ),
              child: TextField(
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: const InputDecoration(
                  hintText: 'جستجو در نقشه...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
