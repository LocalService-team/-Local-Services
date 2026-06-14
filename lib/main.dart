<<<<<<< HEAD
﻿import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'screens/main_screen.dart';
import 'theme/app_theme.dart';
=======
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
>>>>>>> origin/feature/home-ui

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'Local Services',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: const MainScreen(),
=======
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.vazirmatnTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const MapScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],


      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),

      bottomNavigationBar: buildBottomNav(),
    );
  }

  Widget buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          iconItem(Icons.home_outlined, 0, "خانه"),
          iconItem(Icons.location_on_outlined, 1, "نقشه"),
          iconItem(Icons.favorite_border, 2, "علاقه"),
          iconItem(Icons.person_outline, 3, "پروفایل"),
        ],
      ),
    );
  }

  Widget iconItem(IconData icon, int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: selectedIndex == index ? Colors.green : Colors.grey,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: GoogleFonts.vazirmatn(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: selectedIndex == index ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  final List<String> bakeries = const [
    "نانوایی دهکده نان",
    "نانوایی شهر نو",
    "نانوایی کابل",
    "نانوایی امید",
  ];

  final List<String> pharmacies = const [
    "دواخانه شفا",
    "دواخانه مرکزی",
    "دواخانه صحت",
  ];

  final List<String> transports = const [
    "تاکسی کابل",
    "ترانسپورت سریع",
    "بس شهری",
  ];

  final List<String> services = const [
    "تعمیرکار برق",
    "میکانیک",
    "لوله‌کش",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 25),
          decoration: const BoxDecoration(
            color: Color(0xFF0A4855),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Text(
                "خدمات محلی",
                style: GoogleFonts.vazirmatn(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "جستجو...",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
            children: [

              serviceBox(context, "نانوایی", bakeries, Icons.bakery_dining,
                  const Color(0xFF8B9376)),
              serviceBox(context, "دواخانه", pharmacies, Icons.medical_services,
                  const Color(0xFF88ACAC)),
              serviceBox(
                  context, "ترانسپورت", transports, Icons.directions_car_filled,
                  const Color(0xFFD5C7CA)),
              serviceBox(context, "خدمات", services, Icons.handyman,
                  const Color(0xFFCFA463)),
            ],
          ),
        ),
      ],
    );
  }
  Widget serviceBox(BuildContext context, String title, List<String> list, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ListPage(title: title, items: list),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.8),
              color.withOpacity(0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.vazirmatn(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              "${list.length} مورد",
              style: GoogleFonts.vazirmatn(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ListPage extends StatelessWidget {
  final String title;
  final List<String> items;

  const ListPage({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.store),
            title: Text(items[index]),
          );
        },
      ),
>>>>>>> origin/feature/home-ui
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("نقشه 📍"));
  }
}

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("علاقه‌مندی ❤️"));
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("پروفایل 👤"));
  }
}