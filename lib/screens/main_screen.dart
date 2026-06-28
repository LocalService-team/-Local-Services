import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favourites_screen.dart';
import 'map_screen.dart';
import 'profile_screen.dart';
import '../main.dart';
import '../theme/app_theme.dart';
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
    return StreamBuilder<List<Service>>(
      stream: _repository.getServices(),
      builder: (context, snapshot) {
        final services = snapshot.data ?? [];

        final pages = [
          HomeScreen(services: services),
          MapScreen(services: services),
          FavouritesScreen(key: ValueKey(_favouritesRefreshKey)),
          ProfileScreen(
            onLocaleChange: (locale) => MyApp.of(context)?.setLocale(locale),
          ),
        ];

        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                if (index == 2) _favouritesRefreshKey++;
              });
            },
            selectedItemColor: AppTheme.homeTeal,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: [
              const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'خانه'),
              const BottomNavigationBarItem(icon: Icon(Icons.map), label: 'نقشه'),
              BottomNavigationBarItem(
                icon: Icon(_currentIndex == 2 ? Icons.favorite : Icons.favorite_border),
                label: 'علاقه‌مندی',
              ),
              BottomNavigationBarItem(
                icon: Icon(_currentIndex == 3 ? Icons.person : Icons.person_outline),
                label: 'پروفایل',
              ),
            ],
          ),
        );
      },
    );
  }
}