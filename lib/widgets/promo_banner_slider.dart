import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../services/coupon_service.dart';

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

  void _claimPromo(String code, String promoName) {
    final success = CouponService.instance.claimCoupon(code);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: success ? const Color(0xFF43B33F) : AppColors.primaryGold,
        content: Text(
          success
              ? 'Kupon "$code" ($promoName) berhasil diklaim & masuk dompet voucher!'
              : 'Kupon "$code" sudah ada di dompet voucher kamu.',
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
                            AnimatedBuilder(
                              animation: CouponService.instance,
                              builder: (context, _) {
                                final code = promo['code'] as String;
                                final isClaimed = CouponService.instance.isClaimed(code);

                                return SizedBox(
                                  width: 116,
                                  height: 33,
                                  child: ElevatedButton(
                                    onPressed: () => _claimPromo(code, promo['subtitle'] as String),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isClaimed
                                          ? const Color(0xFF2E7D32) // Hijau tua saat sudah diklaim
                                          : const Color(0xFF43B33F), // Hijau terang Figma
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
