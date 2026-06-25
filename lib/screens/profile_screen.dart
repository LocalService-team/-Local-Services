import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  final Function(Locale) onLocaleChange;
  const ProfileScreen({super.key, required this.onLocaleChange});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primaryTeal,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                'کاربر مهمان',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'guest@localservices.af',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black12,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        'زبان / Language',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    _languageTile(context, 'English', 'en', '🇬🇧'),
                    const Divider(height: 1),
                    _languageTile(context, 'دری', 'fa', '🇦🇫'),
                    const Divider(height: 1),
                    _languageTile(context, 'پښتو', 'ps', '🇦🇫'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black12,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _infoTile(Icons.info_outline, 'درباره اپ', 'نسخه ۱.۰.۰'),
                    const Divider(height: 1),
                    _infoTile(Icons.location_city, 'شهر', 'کابل، افغانستان'),
                    const Divider(height: 1),
                    _infoTile(Icons.phone, 'پشتیبانی', '0700000000'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _languageTile(
    BuildContext context,
    String label,
    String code,
    String flag,
  ) {
    final current = Localizations.localeOf(context).languageCode;
    final isSelected = current == code;
    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 24)),
      title: Text(label),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppColors.primaryTeal)
          : const Icon(Icons.circle_outlined, color: Colors.grey),
      onTap: () => onLocaleChange(Locale(code)),
    );
  }

  Widget _infoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryTeal),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}