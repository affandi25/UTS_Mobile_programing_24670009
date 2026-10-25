import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/dummy_data.dart';
import '../../models/notification_model.dart';
import '../../models/product_model.dart';
import '../../services/auth_service.dart';
import '../../services/notification_service.dart';
import '../menu/menu_catalog_screen.dart';
import '../auth/login_screen.dart';
import '../../widgets/promo_banner_slider.dart';
import '../menu/product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(int tabIndex)? onSelectTab;

  const HomeScreen({super.key, this.onSelectTab});

  @override
  Widget build(BuildContext context) {
    final tiramizuProduct = DummyData.products.firstWhere(
      (p) => p.name.contains('Tiramizu'),
      orElse: () => DummyData.products[4],
    );
    final coklatProduct = DummyData.products.firstWhere(
      (p) => p.name.contains('Coklat'),
      orElse: () => DummyData.products[0],
    );
    final matchaProduct = DummyData.products.firstWhere(
      (p) => p.name.contains('Matcha'),
      orElse: () => DummyData.products[3],
    );

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
                  AnimatedBuilder(
                    animation: AuthService.instance,
                    builder: (context, _) {
                      final user = AuthService.instance.currentUser;
                      final displayName = user?.name ?? 'Yusuf Affandi';
                      final avatarPath = user?.avatarPath ?? 'asset/yusuf.jpeg';

                      return GestureDetector(
                        onTap: () {
                          if (onSelectTab != null) {
                            onSelectTab!(3); // Pindah ke tab Profil
                          }
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: AppColors.yellowAccent,
                              backgroundImage: AssetImage(avatarPath),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hallo,', style: AppTextStyles.caption.copyWith(fontSize: 13)),
                                Text(
                                  '$displayName!',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textDark,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Row(
                    children: [
                      // 1. Lonceng Notifikasi Interaktif dengan Badge Dinamis Sesuai Figma (#72:325)
                      AnimatedBuilder(
                        animation: NotificationService.instance,
                        builder: (context, _) {
                          final unreadCount = NotificationService.instance.unreadCount;
                          return GestureDetector(
                            onTap: () => _showNotificationSheet(context),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
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
                                  child: const Icon(
                                    Icons.notifications_none_rounded,
                                    color: AppColors.textDark,
                                    size: 20,
                                  ),
                                ),
                                if (unreadCount > 0)
                                  Positioned(
                                    top: -2,
                                    right: -2,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.white, width: 1.5),
                                      ),
                                      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                                      child: Center(
                                        child: Text(
                                          unreadCount > 9 ? '9+' : '$unreadCount',
                                          style: const TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 8),

                      // 2. Ikon Chat / Bantuan Sesuai Figma (#72:314 & #130:1069)
                      GestureDetector(
                        onTap: () => _showChatSheet(context),
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
                        onTap: () => _showSettingsSheet(context),
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
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    suffixIcon: Icon(Icons.search_rounded, color: Colors.black54, size: 24),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                      onTap: () => _showLocationDialog(context),
                    ),
                    _buildQuickActionPercent(
                      onTap: () => _showPromoDialog(context),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MenuCatalogScreen(showBackButton: true),
                        ),
                      );
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
                      product: tiramizuProduct,
                    ),
                    const SizedBox(width: 40),
                    _buildBestSellerFigmaItem(
                      context,
                      imagePath: 'asset/bestseller_coklat.png',
                      product: coklatProduct,
                    ),
                    const SizedBox(width: 40),
                    _buildBestSellerFigmaItem(
                      context,
                      imagePath: 'asset/bestseller_matcha.png',
                      product: matchaProduct,
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
    required ProductModel product,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Column(
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
      ),
    );
  }

  // Modal Lembar Notifikasi Interaktif Sesuai Figma (#72:325)
  void _showNotificationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AnimatedBuilder(
        animation: NotificationService.instance,
        builder: (ctx, _) {
          final notifications = NotificationService.instance.notifications;
          final unreadCount = NotificationService.instance.unreadCount;

          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.75,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                // Drag Handle Bar
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                // Header: Judul & Tombol Tandai Semua Dibaca
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Notifikasi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          if (unreadCount > 0) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.redAccent.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '$unreadCount Baru',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (unreadCount > 0)
                        TextButton(
                          onPressed: () {
                            NotificationService.instance.markAllAsRead();
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),
                          child: const Text(
                            'Tandai Dibaca',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryGold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const Divider(height: 20),
                // List Notifikasi
                Flexible(
                  child: notifications.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: Text(
                              'Belum ada notifikasi baru',
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                          itemCount: notifications.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 10),
                          itemBuilder: (ctx, index) {
                            final notif = notifications[index];
                            final isOrder = notif.type == NotificationType.order;

                            return Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: notif.isRead
                                    ? const Color(0xFFFAFAFA)
                                    : AppColors.primaryGold.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: notif.isRead
                                      ? Colors.black.withValues(alpha: 0.06)
                                      : AppColors.primaryGold.withValues(alpha: 0.25),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Ikon Jenis Notifikasi
                                  Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: isOrder
                                          ? const Color(0xFF558B2F).withValues(alpha: 0.12)
                                          : AppColors.primaryGold.withValues(alpha: 0.12),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isOrder
                                          ? Icons.delivery_dining_rounded
                                          : Icons.local_offer_rounded,
                                      color: isOrder ? const Color(0xFF558B2F) : AppColors.primaryGold,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Konten Notifikasi
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                notif.title,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: notif.isRead ? FontWeight.w600 : FontWeight.bold,
                                                  color: AppColors.textDark,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              NotificationService.instance.formatRelativeTime(notif.timestamp),
                                              style: const TextStyle(fontSize: 10, color: Colors.black45),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          notif.message,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: notif.isRead ? Colors.black54 : AppColors.textDark,
                                            height: 1.3,
                                          ),
                                        ),
                                        if (isOrder) ...[
                                          const SizedBox(height: 8),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: () {
                                                NotificationService.instance.markAsRead(notif.id);
                                                Navigator.pop(ctx);
                                                if (onSelectTab != null) {
                                                  onSelectTab!(2); // Pindah ke tab My Order
                                                }
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF558B2F),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: const Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Lihat Pesanan',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(width: 4),
                                                    Icon(Icons.arrow_forward_ios, size: 10, color: Colors.white),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Modal Menu Pengaturan Sesuai Prototype Figma (iPhone 16 Pro - 10)
  void _showSettingsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.grayInput,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pengaturan Akun',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(Icons.person_outline, color: AppColors.primaryGold),
                  title: const Text('Edit Profil Pengguna'),
                  subtitle: const Text('Bio, No. HP, Email'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {
                    Navigator.pop(ctx);
                    if (onSelectTab != null) {
                      onSelectTab!(3);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Menu Edit Profil (Tahap 6)')),
                      );
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.lock_outline, color: AppColors.navyButton),
                  title: const Text('Ubah Kata Sandi'),
                  subtitle: const Text('Ganti sandi lama dengan sandi baru'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form Ubah Sandi (Tahap 6)')),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.receipt_long_outlined, color: Color(0xFF558B2F)),
                  title: const Text('Pesanan Saya (My Order)'),
                  subtitle: const Text('Status pengiriman donat'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {
                    Navigator.pop(ctx);
                    if (onSelectTab != null) {
                      onSelectTab!(2);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Buka My Order')),
                      );
                    }
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Keluar (Logout)', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  onTap: () {
                    AuthService.instance.logout();
                    Navigator.pop(ctx);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Modal Chat Bantuan Sesuai Prototype Figma (iPhone 16 Pro - 12 / 14)
  void _showChatSheet(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            top: 16,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Bantuan & Chat',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 12),
              // Bubble chat sapaan
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Halo Yusuf! Ada yang bisa kami bantu terkait pesanan donatmu?',
                    style: TextStyle(fontSize: 13, color: AppColors.textDark),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Input bar "Kirim Pesan...." Sesuai Figma
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppColors.grayInput.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: 'Kirim Pesan....',
                          hintStyle: TextStyle(fontSize: 13, color: Colors.black45),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send_rounded, color: AppColors.primaryGold),
                    onPressed: () {
                      if (messageController.text.trim().isNotEmpty) {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pesan terkirim ke Customer Support!')),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  // Modal Info Lokasi Outlet SweetBite
  void _showLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.location_on, color: AppColors.primaryGold),
            SizedBox(width: 8),
            Text('Outlet SweetBite', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cabang Utama:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Text('Jl. Cakrawala No. 25, Kota Malang', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
            SizedBox(height: 10),
            Text('Jam Operasional:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Text('Setiap Hari: 08.00 - 21.00 WIB', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
            SizedBox(height: 10),
            Text('Status Layanan:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Text('Tersedia Instant Delivery & Takeaway', style: TextStyle(color: Color(0xFF558B2F), fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup', style: TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Modal Daftar Promo & Diskon Aktif
  void _showPromoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.local_offer, color: AppColors.primaryGold),
            SizedBox(width: 8),
            Text('Kupon Promo Aktif', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPromoItem('SWEET10K', '1 Paket Donat Cuma 10k!'),
            const SizedBox(height: 8),
            _buildPromoItem('JUMATBERKAH', 'Jumat berkah cuma 5K!'),
            const SizedBox(height: 8),
            _buildPromoItem('GRATISTEH', 'Beli 2 Gratis Es Teh Segar'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup', style: TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoItem(String code, String desc) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryGold.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(code, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.primaryGold)),
              Text(desc, style: const TextStyle(fontSize: 11, color: AppColors.textDark)),
            ],
          ),
          const Icon(Icons.check_circle_outline, color: Color(0xFF558B2F), size: 18),
        ],
      ),
    );
  }
}
