import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../services/auth_service.dart';
import '../../auth/login_screen.dart';

/// Modal Menu Pengaturan Sesuai Prototype Figma (iPhone 16 Pro - 10)
/// Menyediakan navigasi ke Edit Profil, Ubah Sandi, Pesanan Saya, dan Aksi Keluar Akun (Logout).
class SettingsSheet extends StatelessWidget {
  final Function(int tabIndex)? onSelectTab;

  const SettingsSheet({
    super.key,
    this.onSelectTab,
  });

  /// Helper untuk menampilkan lembar pengaturan dari layar mana pun
  static void show(BuildContext context, {Function(int tabIndex)? onSelectTab}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SettingsSheet(onSelectTab: onSelectTab),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
  }
}
