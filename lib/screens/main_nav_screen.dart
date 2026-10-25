import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'home/home_screen.dart';
import 'menu/menu_catalog_screen.dart';
import 'order/my_order_screen.dart';
import 'profile/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  String _catalogSearchQuery = '';

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        onSelectTab: (index) {
          setState(() {
            _currentIndex = index;
            if (index != 1) _catalogSearchQuery = '';
          });
        },
        onSearchCatalog: (query) {
          setState(() {
            _catalogSearchQuery = query;
            _currentIndex = 1;
          });
        },
      ),
      MenuCatalogScreen(
        key: ValueKey('catalog_$_catalogSearchQuery'),
        initialQuery: _catalogSearchQuery,
        onBack: () {
          setState(() {
            _currentIndex = 0;
            _catalogSearchQuery = '';
          });
        },
      ),
      MyOrderScreen(
        onBack: () {
          setState(() {
            _currentIndex = 0;
          });
        },
      ),
      ProfileScreen(
        onBack: () {
          setState(() {
            _currentIndex = 0;
          });
        },
      ),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x10000000),
              blurRadius: 16,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryGold,
          unselectedItemColor: AppColors.textMuted.withValues(alpha: 0.6),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_rounded),
              label: 'Pesanan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
