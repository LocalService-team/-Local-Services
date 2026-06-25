import 'package:flutter/material.dart';

  class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
  }
class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0B2E26),
              Color(0xFF1B4332),
              Color(0xFF2D6A4F),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopBar(),
                const SizedBox(height: 25),
                const Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Welcome back 👋",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    children: const [
                      GlassCard(icon: Icons.analytics, title: "Analytics", value: "Overview"),
                      GlassCard(icon: Icons.location_city, title: "Projects", value: "12 Active"),
                      GlassCard(icon: Icons.people, title: "Users", value: "1.2K"),
                      GlassCard(icon: Icons.settings, title: "Settings", value: "Manage"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 30),
          onPressed: () {},
        ),
        const CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white24,
          child: Icon(Icons.person, color: Colors.white),
        ),
      ],
    );
  }
}

class GlassCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const GlassCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const Spacer(),
            Text(title, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}