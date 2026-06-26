import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../theme/app_theme.dart';
import '../theme/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ پس‌زمینه سفید
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // لوگو با رنگ سبز
              Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primaryTeal, AppColors.secondaryTeal],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryTeal.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 8,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.location_city,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'خدمات محلی',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal, // ✅ رنگ سبز
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                'Local Services Kabul',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal, // ✅ رنگ سبز
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Find trusted local services\nin your neighbourhood',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryTeal, AppColors.secondaryTeal],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryTeal.withOpacity(0.3),
                        blurRadius: 25,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryTeal,
                ),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}