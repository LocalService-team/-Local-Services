import 'package:flutter/material.dart';
import '../../widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF2F4),

      body: SafeArea(
        child: Column(
          children: [
            // 🔷 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF0D5C63),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "خدمات محلی",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // 🔍 SEARCH BOX
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const TextField(
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "جستجو...",
                        hintStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔶 GRID
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.1,
                  children: [
                    CategoryCard(
                      title: "نانوایی",
                      count: "12 مورد",
                      icon: Icons.bakery_dining,
                      color: const Color(0xFFA3B18A),
                      onTap: () {
                        print("Bakery clicked");
                      },
                    ),
                    CategoryCard(
                      title: "دواخانه",
                      count: "8 مورد",
                      icon: Icons.local_pharmacy,
                      color: const Color(0xFF8ECae6),
                      onTap: () {
                        print("Pharmacy clicked");
                      },
                    ),
                    CategoryCard(
                      title: "ترانسپورت",
                      count: "6 مورد",
                      icon: Icons.directions_car,
                      color: const Color(0xFFD9D9D9),
                      onTap: () {
                        print("Transport clicked");
                      },
                    ),
                    CategoryCard(
                      title: "خدمات در محل",
                      count: "15 مورد",
                      icon: Icons.build,
                      color: const Color(0xFFF4A261),
                      onTap: () {
                        print("Services clicked");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 🔻 BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "خانه",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: "نقشه",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "علاقه‌مندی‌ها",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "پروفایل",
          ),
        ],
      ),
    );
  }
}