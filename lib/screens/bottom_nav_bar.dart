import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'menu/menu_catalog_screen.dart';
import 'order/my_order_screen.dart';
import 'profile/profile_screen.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == currentIndex) return;

          if (index == 0) {
            // Kembali ke Beranda
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (currentIndex == 0) {
            // Dari Beranda membuka halaman baru menggunakan push
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MenuCatalogScreen()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyOrderScreen()),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            }
          } else {
            // Antar tab sub-halaman menggunakan pushReplacement agar tumpukan halaman rapi
            if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MenuCatalogScreen()),
              );
            } else if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MyOrderScreen()),
              );
            } else if (index == 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            }
          }
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
    );
  }
}
