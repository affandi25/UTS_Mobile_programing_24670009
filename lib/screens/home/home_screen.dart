import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../main_nav_screen.dart';
import '../menu/menu_catalog_screen.dart';
import '../order/my_order_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Profil Yusuf & 3 Ikon Bulat
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: AppColors.yellowAccent,
                        backgroundImage: AssetImage('asset/yusuf.jpeg'),
                      ),
                      SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hallo,',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                          Text(
                            'Yusuf Affandi!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Ikon Notifikasi
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x10000000),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.notifications_none_rounded, color: AppColors.textDark, size: 20),
                      ),
                      const SizedBox(width: 8),

                      // Ikon Chat
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x10000000),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.textDark, size: 20),
                      ),
                      const SizedBox(width: 8),

                      // Ikon Pengaturan / Profil
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ProfileScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x10000000),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.settings_outlined, color: AppColors.textDark, size: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // 2. Search Bar
              
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.grayInput.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x10000000),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cari varian rasa donat...',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Icon(Icons.search_rounded, color: Colors.black54, size: 24),
                    ],
                  ),
                ),
              
              const SizedBox(height: 26),

              // 3. Row 4 Menu Aksi Cepat (Lokasi, Promo %, Menu, Kirim)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x15000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // A. Menu Lokasi
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on_outlined, size: 28, color: Color(0xFFD19025)),
                        SizedBox(height: 4),
                        Text(
                          'Lokasi',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMuted),
                        ),
                      ],
                    ),

                    // B. Menu Promo %
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primaryGold.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '%',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.primaryGold),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Promo',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMuted),
                        ),
                      ],
                    ),

                    // C. Menu Menu
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MenuCatalogScreen(),
                          ),
                        );
                      },
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.grid_view_rounded, size: 28, color: Color(0xFF558B2F)),
                          SizedBox(height: 4),
                          Text(
                            'Menu',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),

                    // D. Menu Riwayat (Pesanan)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MyOrderScreen(),
                          ),
                        );
                      },
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.receipt_long_rounded, size: 28, color: Color(0xFF1EC5EA)),
                          SizedBox(height: 4),
                          Text(
                            'Riwayat',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 34),

              // 4. Banner Promo Statis
              SizedBox(
                height: 198,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Kartu Banner
                    Positioned(
                      left: 4,
                      right: 4,
                      top: 28,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, top: 18, bottom: 16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF948E82), Color(0xFFA69E92)],
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x25000000),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'PROMO',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const SizedBox(
                              width: 170,
                              child: Text(
                                '1 paket cuma 10k',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  height: 1.25,
                                ),
                              ),
                            ),
                            const Spacer(),
                            // Tombol "Ambil"
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const MenuCatalogScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 116,
                                height: 33,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF43B33F),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x20000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  'Ambil',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Gambar Box Donat & Es Teh
                    Positioned(
                      right: 32,
                      top: 10,
                      child: Image.asset(
                        'asset/promo_coklat_box_rendered.png',
                        width: 138,
                        height: 138,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      right: 2,
                      top: 2,
                      child: Image.asset(
                        'asset/promo_esteh_rendered.png',
                        width: 102,
                        height: 156,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Indikator Titik Slider Statis
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.grayInput,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.grayInput,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 55),

              // 5. Section "BEST SELLER"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'BEST SELLER',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                      color: AppColors.textDark,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MenuCatalogScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1EC5EA),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 3 Menu Donat Best Seller (Tiramisu, Coklat, Matcha)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    for (final imagePath in [
                      'asset/bestseller_tiramizu.png',
                      'asset/bestseller_coklat.png',
                      'asset/bestseller_matcha.png',
                    ]) ...[
                      const SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MenuCatalogScreen(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Foto Donat
                            Container(
                              width: 100,
                              height: 122,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x35000000),
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.asset(imagePath, fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Tombol Ungu "PESAN"
                            Container(
                              width: 103,
                              height: 28,
                              decoration: BoxDecoration(
                                color: const Color(0xFF431BC6),
                                borderRadius: BorderRadius.circular(13),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x25000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.shopping_cart_outlined, size: 14, color: Colors.white),
                                  SizedBox(width: 4),
                                  Text(
                                    'PESAN',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }
}
