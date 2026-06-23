import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'map_screen.dart';
import '../theme/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(onSettingsPressed: () => setState(() => index = 4)),
      const MapScreen(),
      const Center(child: Text('علاقه‌مندی‌ها', style: TextStyle(fontFamily: 'sans-serif'))),
      const Center(child: Text('پروفایل', style: TextStyle(fontFamily: 'sans-serif'))),
      const Center(child: Text('تنظیمات', style: TextStyle(fontFamily: 'sans-serif'))),
    ];

    return Scaffold(
      extendBody: true,
      appBar: null,
      body: IndexedStack(
        index: index,
        children: screens,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 24, 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.96),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryTeal.withOpacity(0.12),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: AppColors.primaryTeal.withOpacity(0.08),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_rounded, 'خانه', 0),
              _buildNavItem(Icons.map_rounded, 'نقشه', 1),
              _buildNavItem(Icons.favorite_rounded, 'محبوب', 2),
              _buildNavItem(Icons.person_rounded, 'پروفایل', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int itemIndex) {
    final bool isSelected = index == itemIndex;
    return GestureDetector(
      onTap: () => setState(() => index = itemIndex),
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
                color: isSelected ? AppColors.primaryTeal.withOpacity(0.12) : Colors.transparent,
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
                fontFamily: 'sans-serif',
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