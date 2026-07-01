import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../theme/app_colors.dart';
import '../screens/service_detail_screen.dart';
import '../models/service.dart';
import '../services/favourites_service.dart';

class MapScreen extends StatefulWidget {
  final List<Service> services;
  const MapScreen({super.key, required this.services});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  late TabController _tabController;
  Set<String> _favourites = {};

  Set<String> _savingFavourites = {};

  Future<void> _toggleFavourite(String id) async {
    if (!FavouritesService.isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please sign in to save favourites. Or create an account.',
          ),
        ),
      );
      return;
    }

    setState(() {
      _savingFavourites.add(id);
    });

    try {
      await FavouritesService.toggleFavourite(id);
      await _loadFavourites();
    } finally {
      if (mounted) {
        setState(() {
          _savingFavourites.remove(id);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadFavourites();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadFavourites() async {
    final ids = await FavouritesService.getFavourites();
    setState(() => _favourites = ids.toSet());
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.services
        .where(
          (s) =>
              s.latitude != null &&
              s.longitude != null &&
              s.matchesSearch(_searchQuery),
        )
        .toList();

    final favouriteServices = filtered
        .where((s) => _favourites.contains(s.id))
        .toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Text(
                    'خدمات',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.tune), onPressed: () {}),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: _ServiceSearchDelegate(
                          onQuery: (q) => setState(() => _searchQuery = q),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 260,
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(34.5253, 69.1783),
                  initialZoom: 14,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://cartodb-basemaps-a.global.ssl.fastly.net/rastertiles/voyager/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.local_services',
                  ),
                  MarkerLayer(
                    markers: filtered
                        .map(
                          (service) => Marker(
                            point: LatLng(
                              service.latitude!,
                              service.longitude!,
                            ),
                            width: 120,
                            height: 80,
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ServiceDetailScreen(service: service),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.homeHeader,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      service.titleFa,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.location_pin,
                                    color: Colors.red,
                                    size: 32,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              labelColor: AppColors.homeHeader,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.homeHeader,
              tabs: const [
                Tab(text: 'Nearby'),
                Tab(text: 'Favourites'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _ServiceList(
                    services: filtered,
                    favourites: _favourites,
                    savingFavourites: _savingFavourites,
                    onToggleFavourite: _toggleFavourite,
                  ),
                  _ServiceList(
                    services: favouriteServices,
                    favourites: _favourites,
                    savingFavourites: _savingFavourites,
                    onToggleFavourite: _toggleFavourite,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceList extends StatelessWidget {
  final List<Service> services;
  final Set<String> favourites;
  final Set<String> savingFavourites;
  final Future<void> Function(String id) onToggleFavourite;

  const _ServiceList({
    required this.services,
    required this.favourites,
    required this.savingFavourites,
    required this.onToggleFavourite,
  });

  String _getCategoryLabel(String key) {
    const labels = {
      'servicePlumber': 'خدمات در محل',
      'serviceElectrician': 'برق کار',
      'serviceCleaner': 'نظافت',
      'serviceBakery': 'نانوایی',
      'servicePharmacy': 'دواخانه',
      'serviceTransport': 'ترانسپورت',
    };
    return labels[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return const Center(child: Text('No services found'));
    }
    return ListView.separated(
      itemCount: services.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final service = services[index];
        final isFav = favourites.contains(service.id);
        return ListTile(
          leading: ClipOval(
            child: service.imageUrl.isNotEmpty
                ? Image.network(
                    service.imageUrl,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 44,
                      height: 44,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.build, size: 20),
                    ),
                  )
                : Container(
                    width: 44,
                    height: 44,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.build, size: 20),
                  ),
          ),
          title: Text(
            service.titleFa,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(_getCategoryLabel(service.categoryKey)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: savingFavourites.contains(service.id)
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                onPressed: savingFavourites.contains(service.id)
                    ? null
                    : () => onToggleFavourite(service.id),
              ),
              IconButton(
                icon: const Icon(Icons.info_outline, color: Colors.grey),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ServiceDetailScreen(service: service),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ServiceSearchDelegate extends SearchDelegate {
  final void Function(String) onQuery;
  _ServiceSearchDelegate({required this.onQuery});

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) {
    onQuery(query);
    close(context, null);
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) => const SizedBox();
}
