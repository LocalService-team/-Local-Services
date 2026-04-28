import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class AppColors {
  static const primary = Color(0xFF4A148C);
  static const secondary = Color(0xFF7B1FA2);
  static const accent = Color(0xFF00C853);

  static const background = Color(0xFFF1F3F6);
  static const card = Colors.white;

  static const textDark = Color(0xFF1A1A1A);
  static const textLight = Color(0xFF6B7280);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'خدمات محلی',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
      ),
      home: const ServiceListScreen(),
    );
  }
}

class ServiceListScreen extends StatefulWidget {
  const ServiceListScreen({super.key});

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ---------------- HEADER ----------------

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20,55,20,20),

          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.secondary,
              ],
            ),
          ),

          child: Column(
            children: [

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [

                  const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 28,
                  ),

                  const Text(
                    "خدمات محلی",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height:16),

              // -------- SEARCH ----------

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(16),

                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(0,4),
                      color: Colors.black12,
                    )
                  ],
                ),

                child: const TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "جستجو...",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(
                        vertical:15
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

      // ---------------- BODY ----------------

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const SizedBox(height:10),

          const Text(
            "خدمات پیشنهادی",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize:20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height:16),

          ServiceCard(
            title: "نانوایی احمد",
            category: "نانوایی",
            rating: "4.8",
            address: "کابل، کارته ۳",
            image:
            "https://images.unsplash.com/photo-1509440159596-0249088772ff",
          ),

          const SizedBox(height:18),

          ServiceCard(
            title: "دواخانه سلام",
            category: "دواخانه",
            rating: "4.7",
            address: "کابل، مرکز شهر",
            image:
            "https://images.unsplash.com/photo-1587854692152-cbe660dbde88",
          ),

        ],
      ),

      // ------------ MODERN NAV ----------

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,

        onDestinationSelected: (index){
          setState(() {
            currentIndex=index;
          });
        },

        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "خانه",
          ),

          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: "نقشه",
          ),

          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: "علاقه‌مندی",
          ),

          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "پروفایل",
          ),
        ],
      ),
    );
  }
}


class ServiceCard extends StatelessWidget {

  final String title;
  final String category;
  final String rating;
  final String address;
  final String image;

  const ServiceCard({
    super.key,
    required this.title,
    required this.category,
    required this.rating,
    required this.address,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: AppColors.card,

        borderRadius:
        BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            blurRadius:15,
            offset: Offset(0,5),
            color: Colors.black12,
          )
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.end,

        children: [

          ClipRRect(
            borderRadius:
            BorderRadius.circular(16),

            child: Image.network(
              image,
              height:160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height:12),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: [

              IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.redAccent,
                ),
              ),

              Column(
                crossAxisAlignment:
                CrossAxisAlignment.end,

                children: [

                  Text(
                    title,
                    style: TextStyle(
                      fontSize:18,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height:6),

                  Container(
                    padding:
                    EdgeInsets.symmetric(
                      horizontal:10,
                      vertical:4,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius:
                      BorderRadius.circular(20),
                    ),

                    child: Text(category),
                  )
                ],
              )
            ],
          ),

          const SizedBox(height:10),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.end,
            children: [
              Text(rating),
              SizedBox(width:4),
              Icon(
                Icons.star,
                size:18,
                color: Colors.amber,
              )
            ],
          ),

          const SizedBox(height:8),

          Text(
            address,
            style: TextStyle(
              color: AppColors.textLight,
            ),
          ),

          const SizedBox(height:18),

          Row(
            children: [

              Expanded(
                child: FilledButton.icon(
                  style:
                  FilledButton.styleFrom(
                    backgroundColor:
                    AppColors.accent,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(14),
                    ),
                  ),

                  onPressed: (){},
                  icon: Icon(Icons.call),
                  label: Text("تماس"),
                ),
              ),

              const SizedBox(width:10),

              Expanded(
                child: OutlinedButton(
                  style:
                  OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppColors.primary,
                    ),
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: (){},
                  child: Text("مشاهده"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}