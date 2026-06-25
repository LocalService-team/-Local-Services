import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favourites_screen.dart';
import 'map_screen.dart';
import 'profile_screen.dart';
import '../data/service_data.dart';
import '../main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // استفاده از لیست صفحات به عنوان متغیر برای ثبات بیشتر
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      MapScreen(services: ServiceData.allServices),
      const FavouritesScreen(),
      ProfileScreen(
        onLocaleChange: (locale) => MyApp.of(context)?.setLocale(locale),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // استفاده از IndexedStack برای اینکه وضعیت صفحات هنگام جابجایی پاک نشود
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFF2D6A4F),
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
  }
}