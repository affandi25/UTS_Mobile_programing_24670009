import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import 'home/home_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeScreen(),
      bottomNavigationBar: AppBottomNavBar(currentIndex: 0),
    );
  }
}
