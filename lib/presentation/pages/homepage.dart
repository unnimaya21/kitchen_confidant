import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kitchen_confidant/presentation/pages/virtual_pantry.dart';
import 'package:kitchen_confidant/presentation/widgets/feature_card.dart';
import 'package:kitchen_confidant/presentation/widgets/glass_card.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E0D9),
      body: SafeArea(
        child: Column(
          children: [
            /// Content
            Expanded(
              child: Stack(
                children: [
                  /// Background Image
                  Positioned.fill(
                    child: Image.asset(
                      'assets/chef_bg.jpg', // your illustration
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// Foreground UI
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 180),

                        /// Search / Thought Card
                        GlassCard(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            child: Text(
                              "What's on your mind?",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.brown.shade900,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// Grid Options
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1,
                          children: [
                            FeatureCard(
                              icon: Icons.auto_awesome,
                              title: "My Generated\nRecipes",
                            ),
                            FeatureCard(
                              icon: Icons.kitchen_outlined,
                              title: "Let's make\nSomething",
                              onTap: () {
                                // Navigate to Pantry Screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PantryScreen(),
                                  ),
                                );
                              },
                            ),
                            FeatureCard(
                              icon: Icons.favorite_border,
                              title: "Favourite\nRecipes",
                            ),
                            FeatureCard(
                              icon: Icons.menu_book_outlined,
                              title: "Recipe\nCollections",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /// Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black38,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: "Recipes",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
