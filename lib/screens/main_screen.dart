import 'package:flutter/material.dart';
import 'home_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      MapScreen(services: ServiceData.allServices),
      const Center(child: Text('علاقه‌مندی‌ها - Coming Soon')),
      ProfileScreen(
        onLocaleChange: (locale) {
          MyApp.of(context)?.setLocale(locale);
        },
      ),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFF2D6A4F),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'خانه'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'نقشه'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'علاقه‌مندی'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'پروفایل'),
        ],
      ),
    );
  }
}
