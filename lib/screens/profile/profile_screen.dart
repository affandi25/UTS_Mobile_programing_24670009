import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const ProfileScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // 1. Top Bar Header (Panah Kembali, Judul "Profil Pengguna", Tombol "Simpan")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (onBack != null) {
                        onBack!();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x15000000),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.textDark,
                        size: 22,
                      ),
                    ),
                  ),
                  const Text(
                    'Profil Pengguna',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFBD8800).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBD8800),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // 2. Avatar Besar & Ubah Foto
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryGold.withValues(alpha: 0.4),
                            width: 3,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x18000000),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const CircleAvatar(
                          radius: 52,
                          backgroundColor: AppColors.yellowAccent,
                          backgroundImage: AssetImage('asset/yusuf.jpeg'),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF0FA92C),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x25000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Ubah Foto',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0FA92C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 3. Kartu 6 Baris Data Pribadi
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    _ProfileFieldRow(label: 'Nama', value: 'Yusuf Affandi'),
                    _ProfileDivider(),
                    _ProfileFieldRow(label: 'Bio', value: 'Pecinta Donat Manis & Dessert'),
                    _ProfileDivider(),
                    _ProfileFieldRow(label: 'Jenis Kelamin', value: 'Laki-laki'),
                    _ProfileDivider(),
                    _ProfileFieldRow(label: 'Tanggal Lahir', value: '25 Mei 2004'),
                    _ProfileDivider(),
                    _ProfileFieldRow(label: 'No.Handphone', value: '081234567890'),
                    _ProfileDivider(),
                    _ProfileFieldRow(label: 'Email', value: 'Akusayangkamu@gmail.com'),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 4. Kartu Pengaturan Akun (Ubah Kata Sandi & Keluar)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    _AccountActionRow(
                      icon: Icons.lock_reset_rounded,
                      iconBgColor: Color(0x1FD19025),
                      iconColor: AppColors.primaryGold,
                      title: 'Ubah Kata Sandi',
                      titleColor: AppColors.textDark,
                    ),
                    _ProfileDivider(),
                    _AccountActionRow(
                      icon: Icons.logout_rounded,
                      iconBgColor: Color(0x1FE53935),
                      iconColor: Colors.redAccent,
                      title: 'Keluar',
                      titleColor: Colors.redAccent,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
    );
  }
}

// Widget Baris Field Data Profil
class _ProfileFieldRow extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileFieldRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    value,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13,
                  color: Colors.black38,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget Baris Aksi Akun (Ubah Sandi / Keluar)
class _AccountActionRow extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final Color titleColor;

  const _AccountActionRow({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: titleColor,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: Colors.black38,
          ),
        ],
      ),
    );
  }
}

// Widget Garis Pemisah (Divider)
class _ProfileDivider extends StatelessWidget {
  const _ProfileDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFF3F3F3),
      indent: 18,
      endIndent: 18,
    );
  }
}
