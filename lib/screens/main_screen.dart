import 'package:flutter/material.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const Center(child: Text("نقشه")),
    const Center(child: Text("علاقه‌مندی‌ها")),
    const Center(child: Text("پروفایل")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "خانه"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "نقشه"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "علاقه‌مندی"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "پروفایل"),
        ],
      ),
    );
  }
}