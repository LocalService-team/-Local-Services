import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Imports your Home Screen layout
import 'theme/app_colors.dart';   // Imports your team's color palette

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Local Services App',
      theme: ThemeData(
        // Hooking up your primary Teal color as the theme anchor
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryTeal),
        useMaterial3: true,
      ),
      // Set this to HomeScreen() to test your list,
      // or change it to Latifa's Home widget name once the merge is complete!
      home: const HomeScreen(),
    );
  }
}