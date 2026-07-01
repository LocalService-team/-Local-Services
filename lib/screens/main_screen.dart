import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favourites_screen.dart';
import 'map_screen.dart';
import 'profile_screen.dart';
import '../main.dart';
import '../theme/app_colors.dart';
import '../models/service.dart';
import '../services/service_repository.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  int _favouritesRefreshKey = 0;
  final ServiceRepository _repository = ServiceRepository();

  @override
  Widget build(BuildContext context) {
    // Get padding to ensure the floating bar sits above system UI (like home indicators)
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return StreamBuilder<List<Service>>(
      stream: _repository.getServices(),
      builder: (context, snapshot) {
        final services = snapshot.data ?? [];

        // Define pages inside the builder so they have access to 'services'
        final List<Widget> pages = [
          HomeScreen(services: services),
          MapScreen(services: services),
          FavouritesScreen(key: ValueKey(_favouritesRefreshKey)),
          ProfileScreen(
            onLocaleChange: (locale) => MyApp.of(context)?.setLocale(locale),
          ),
        ];

        return Scaffold(
          // Use extendBody to let content draw behind the navigation area
          extendBody: true,
          body: Stack(
            children: [
              Positioned.fill( // This forces the child to fill the entire Stack area
                child: IndexedStack(
                  index: _currentIndex,
                  children: pages,
                ),
              ),

              // Floating Navigation Bar
              Positioned(
                bottom: bottomPadding > 0 ? bottomPadding + 10 : 20,
                left: 24,
                right: 24,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.96),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryTeal.withValues(alpha: 0.12),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.primaryTeal.withValues(alpha: 0.08),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.home_rounded, 'خانه', 0),
                      _buildNavItem(Icons.map_rounded, 'نقشه', 1),
                      _buildNavItem(Icons.favorite_rounded, 'علاقه‌مندی', 2),
                      _buildNavItem(Icons.person_rounded, 'پروفایل', 3),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem(IconData icon, String label, int itemIndex) {
    final bool isSelected = _currentIndex == itemIndex;
    return GestureDetector(
      onTap: () => setState(() {
        _currentIndex = itemIndex;
        if (itemIndex == 2) _favouritesRefreshKey++;
      }),
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryTeal.withValues(alpha: 0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primaryTeal : Colors.grey.shade400,
                size: 24,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.primaryTeal : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}