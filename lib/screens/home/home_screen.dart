import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../menu/menu_catalog_screen.dart';
import '../profile/profile_screen.dart';
import 'dart:ui';


class HomeScreen extends StatefulWidget {
  final Function(int tabIndex)? onSelectTab;
  final Function(String query)? onSearchCatalog;

  const HomeScreen({
    super.key,
    this.onSelectTab,
    this.onSearchCatalog,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  Function(int tabIndex)? get onSelectTab => widget.onSelectTab;
  Function(String query)? get onSearchCatalog => widget.onSearchCatalog;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String rawQuery) {
    final query = rawQuery.trim();
    if (query.isEmpty) return;

    if (onSearchCatalog != null) {
      onSearchCatalog!(query);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MenuCatalogScreen(
            showBackButton: true,
            initialQuery: query,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Profil Sesuai Figma (#11:44 & #72:283)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (onSelectTab != null) {
                        onSelectTab!(3); // Pindah ke tab Profil
                      }
                    },
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 26,
                          backgroundColor: AppColors.yellowAccent,
                          backgroundImage: AssetImage('asset/yusuf.jpeg'),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hallo,', style: AppTextStyles.caption.copyWith(fontSize: 13)),
                            const Text(
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
                  ),
                  Row(
                    children: [
                      // 1. Lonceng Notifikasi Sesuai Figma (#72:325)
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Notifikasi: Promo Donat 10K sedang aktif!'),
                              duration: Duration(seconds: 1),
                            ),
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
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            color: AppColors.textDark,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // 2. Ikon Chat / Bantuan Sesuai Figma (#72:314 & #130:1069)
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Bantuan: CS SweetBite WhatsApp (+62 812-3456-7890)'),
                              duration: Duration(seconds: 1),
                            ),
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
                          child: const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.textDark, size: 20),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // 3. Ikon Gear / Pengaturan Sesuai Figma (#72:307)
                      GestureDetector(
                        onTap: () {
                          if (onSelectTab != null) {
                            onSelectTab!(3); // Pindah ke tab Profil di MainNavigationScreen
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ProfileScreen()),
                            );
                          }
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

              // 2. Search Bar Sesuai Figma (#11:54 & #104:431)
              Container(
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
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: _handleSearch,
                  decoration: InputDecoration(
                    hintText: 'Cari varian rasa donat...',
                    hintStyle: const TextStyle(fontSize: 14, color: Colors.black54),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search_rounded, color: Colors.black54, size: 24),
                      onPressed: () => _handleSearch(_searchController.text),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 26),

              // 3. ROW ICON DI BAWAH SEARCH SESUAI FIGMA (#11:86)
              // (Map Pin / Lokasi, Diskon %, Notes, Delivery / Plane)
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
                    _buildQuickActionIcon(
                      icon: Icons.location_on_outlined,
                      label: 'Lokasi',
                      color: const Color(0xFFD19025),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Lokasi Outlet: Jl. Cakrawala No. 25, Kota Malang'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                    _buildQuickActionPercent(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Promo: Voucher Donat Diskon 10K sedang aktif!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                    _buildQuickActionIcon(
                      icon: Icons.receipt_long_outlined,
                      label: 'Menu',
                      color: const Color(0xFF558B2F),
                      onTap: () {
                        if (onSelectTab != null) {
                          onSelectTab!(1);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MenuCatalogScreen(showBackButton: true),
                            ),
                          );
                        }
                      },
                    ),
                    _buildQuickActionIcon(
                      icon: Icons.near_me_rounded,
                      label: 'Kirim',
                      color: const Color(0xFF1EC5EA),
                      onTap: () {
                        if (onSelectTab != null) {
                          onSelectTab!(2);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: AppColors.primaryGold,
                              content: Text('Membuka status pesanan / pengiriman donat...'),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 34),

              // 4. Banner Promo Carousel Sesuai Figma (#253:1127 - component 'luar')
              const PromoBannerSlider(),
              const SizedBox(height: 55),

              // 5. Section "BEST SELLER" Sesuai Figma (#11:97 & #125:875)
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
                      if (onSelectTab != null) {
                        onSelectTab!(1);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MenuCatalogScreen(showBackButton: true),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1EC5EA), // Cyan persis sesuai Figma #125:875
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 3 Menu Best Seller Sesuai Persis Figma (#11:44: #104:576, #104:578, #104:579 & Tombol PESAN #340:1002, 1005, 1008)
              // Urutan persis Figma: 1. Rasa Tiramizu, 2. Rasa Coklat, 3. Rasa Matcha
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    const SizedBox(width: 30  ),
                    _buildBestSellerFigmaItem(
                      context,
                      imagePath: 'asset/bestseller_tiramizu.png',
                    ),
                    const SizedBox(width: 40),
                    _buildBestSellerFigmaItem(
                      context,
                      imagePath: 'asset/bestseller_coklat.png',
                    ),
                    const SizedBox(width: 40),
                    _buildBestSellerFigmaItem(
                      context,
                      imagePath: 'asset/bestseller_matcha.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60), // Jarak bawah agar halaman nyaman discroll
            ],
          ),
        ),
      ),
    );
  }

  // Widget Icon Cepat (Lokasi, Menu, Kirim) Sesuai Figma #11:86
  Widget _buildQuickActionIcon({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Icon Khusus % Sesuai Figma #104:601
  Widget _buildQuickActionPercent({VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryGold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Promo',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  // Item Menu Best Seller Sesuai Persis Figma (#104:576, #104:578, #104:579 & #340:1002, #340:1005, #340:1008)
  Widget _buildBestSellerFigmaItem(
    BuildContext context, {
    required String imagePath,
  }) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Kotak Donat Sesuai Foto Asli Figma (96.5 x 118.2 dp, Shadow 0px 4px 4px)
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
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.primaryGold.withValues(alpha: 0.2),
                  child: const Icon(Icons.cake_rounded, color: AppColors.primaryGold, size: 40),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // 2. Tombol "PESAN" Ungu Figma (103 x 28 dp, #431BC6, Icon Cart + Text PESAN)
          Container(
            width: 103,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF431BC6), // Ungu khas Figma #340:998
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
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 14,
                  color: Colors.white,
                ),
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
      );
  }
}

class PromoBannerSlider extends StatefulWidget {
  const PromoBannerSlider({super.key});

  @override
  State<PromoBannerSlider> createState() => _PromoBannerSliderState();
}

class _PromoBannerSliderState extends State<PromoBannerSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // 3 Promo Asli dari Figma (#253:1127 - component 'luar')
  // Visual, kemiringan, dan posisinya diekstrak langsung dari render Figma
  final List<Map<String, dynamic>> _promos = [
    {
      'code': 'SWEET10K',
      'title': 'PROMO',
      'subtitle': '1 paket cuma 10k',
      'gradient': const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF948E82), Color(0xFFA69E92)],
      ),
      'type': 'combo', // Box coklat + gelas es teh meluap
    },
    {
      'code': 'JUMATBERKAH',
      'title': 'PROMO',
      'subtitle': 'Jumat berkah cuma 5K',
      'gradient': const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFAFA02E), Color(0xFFC7B33F)],
      ),
      'type': 'matcha', // Box matcha miring diagonal asli Figma
    },
    {
      'code': 'GRATISTEH',
      'title': 'PROMO',
      'subtitle': 'Beli 2 Gratis  Es Teh',
      'gradient': const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFCD9A30), Color(0xFFE2AE40)],
      ),
      'type': 'esteh', // Gelas es teh miring dengan cipratan es meluap di atas kartu
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final Set<String> _claimedCodes = {};

  void _claimPromo(String code, String promoName) {
    final alreadyClaimed = _claimedCodes.contains(code);
    setState(() {
      _claimedCodes.add(code);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: alreadyClaimed ? AppColors.primaryGold : const Color(0xFF43B33F),
        content: Text(
          alreadyClaimed
              ? 'Kupon "$code" sudah tersimpan!'
              : 'Kupon "$code" ($promoName) berhasil diklaim!',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Slider Halaman Banner Sesuai Dimensi Figma (#253:1127 luar 342x238 dengan kartu 168 dp)
        // Diberi ruang atas agar gambar yang menjorok keluar/overflow tidak terpotong
        SizedBox(
          height: 198,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.trackpad,
                PointerDeviceKind.stylus,
              },
            ),
            child: PageView.builder(
              clipBehavior: Clip.none,
              controller: _pageController,
              itemCount: _promos.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final promo = _promos[index];
                final type = promo['type'] as String;

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // A. Container Kartu Latar Belakang (Mulai dari top: 28 dp agar gambar di atasnya bisa overflow)
                    Positioned(
                      left: 4,
                      right: 4,
                      top: 28,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, top: 18, bottom: 16),
                        decoration: BoxDecoration(
                          gradient: promo['gradient'] as LinearGradient,
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
                            // Label "PROMO" (#803021bc: teks hitam tebal)
                            Text(
                              promo['title'] as String,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Subtitle Promo Asli Figma (teks hitam tebal)
                            SizedBox(
                              width: 170,
                              child: Text(
                                promo['subtitle'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  height: 1.25,
                                ),
                              ),
                            ),
                            const Spacer(),

                            // Tombol Hijau "Ambil" Sesuai Figma (#EL-0ce5c2ca, #EL-1065d696: width 120, height 33, #43B33F)
                            Builder(
                              builder: (context) {
                                final code = promo['code'] as String;
                                final isClaimed = _claimedCodes.contains(code);

                                return SizedBox(
                                  width: 116,
                                  height: 33,
                                  child: ElevatedButton(
                                    onPressed: () => _claimPromo(code, promo['subtitle'] as String),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isClaimed
                                          ? const Color(0xFF2E7D32)
                                          : const Color(0xFF43B33F),
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if (isClaimed) ...[
                                          const Icon(Icons.check_rounded, size: 16, color: Colors.white),
                                          const SizedBox(width: 4),
                                        ],
                                        Text(
                                          isClaimed ? 'Tersimpan' : 'Ambil',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    // B. Ilustrasi Produk dengan Kemiringan & Posisi Persis Figma
                    if (type == 'combo') ...[
                      // 1. Box Donat Coklat Terbuka (di belakang es teh)
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
                      // 2. Gelas Es Teh dengan Cipratan Es (di depan box, miring sedikit)
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
                    ] else if (type == 'matcha') ...[
                      // Box Roll Donat Matcha dengan Kemiringan Diagonal Asli Figma (-35 derajat)
                      Positioned(
                        right: 8,
                        top: 2,
                        child: Image.asset(
                          'asset/promo_matcha_rendered.png',
                          width: 156,
                          height: 156,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ] else if (type == 'esteh') ...[
                      // Gelas Es Teh Dingin dengan Cipratan Es Tinggi Meluap di Atas Kartu
                      Positioned(
                        right: 20,
                        top: 0,
                        child: Image.asset(
                          'asset/promo_esteh_rendered.png',
                          width: 120,
                          height: 170,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),

        // 2. Indikator Titik (Dots Indicator) - Bisa Diklik Langsung
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_promos.length, (index) {
            final isActive = _currentPage == index;
            return GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primaryGold : AppColors.grayInput,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

