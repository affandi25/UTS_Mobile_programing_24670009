import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/currency_formatter.dart';
import '../../data/dummy_data.dart';
import '../../models/order_model.dart';

class MyOrderScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const MyOrderScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    final orders = DummyData.sampleOrders;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Column(
        children: [
          // 1. Header Bagian Atas Sesuai Figma (#125:670 & #125:677)
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 199, 152, 51),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(36),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x20000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  // A. Tombol Panah Kembali (Kembali ke Beranda) Sesuai Figma (#125:2644)
                  GestureDetector(
                    onTap: () {
                      if (onBack != null) {
                        onBack!();
                      } else {
                        Navigator.maybePop(context);
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

                  // B. Judul Header Sesuai Preferensi Pengguna ("Pesanan Saya") (#125:727)
                  const Text(
                    'Pesanan Saya',
                    style: TextStyle(
                      fontFamily: 'PT Sans',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                      letterSpacing: 0.5,
                    ),
                  ),

                  // C. Ikon Aksi Kanan Sesuai Figma (#125:687 & #125:689)
                  Row(
                    children: [
                      Container(
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
                          Icons.shopping_cart_outlined,
                          color: AppColors.textDark,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
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
                          Icons.settings_outlined,
                          color: AppColors.textDark,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

          // 2. Daftar Kartu Pesanan Sesuai Figma (#125:728, #125:740, #125:749, #125:763)
          Expanded(
            child: orders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_rounded,
                          size: 72,
                          color: AppColors.primaryGold.withValues(alpha: 0.4),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Belum Ada Pesanan Aktif',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Pilih donat lezat di Menu dan pesan sekarang!',
                          style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return _buildOrderCard(order);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Widget Kartu Pesanan Persis Figma (#125:728: "BAWAH")
  Widget _buildOrderCard(OrderItemModel order) {
    final toppingText = order.toppings.isNotEmpty
        ? order.toppings.map((t) => t.name).join(', ')
        : 'Tanpa Topping';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A. Bagian Atas: Gambar Donat (Kiri) + Info Pesanan (Kanan)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Gambar Donat Kotak Sesuai Dimensi Figma (99 x 100 dp)
              Container(
                width: 95,
                height: 95,
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: order.product.imagePath.isNotEmpty
                      ? Image.asset(
                          order.product.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.cake_rounded,
                            size: 44,
                            color: AppColors.primaryGold,
                          ),
                        )
                      : const Icon(
                          Icons.cake_rounded,
                          size: 44,
                          color: AppColors.primaryGold,
                        ),
                ),
              ),
              const SizedBox(width: 14),

              // 2. Info Donat, Harga, Kuantitas, dan Topping
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama Varian Donat
                    Text(
                      order.product.name,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Harga Satuan & Metode Pembayaran Sesuai Figma ("RP.10.000 - Dana")
                    Text(
                      'RP.${CurrencyFormatter.format(order.product.price)} - Dana',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2A5EB0), // Biru khas metode dompet digital
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Jumlah Kuantitas Sesuai Figma ("Jumlah: 2")
                    Text(
                      'Jumlah: ${order.quantity}',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Info Topping Sesuai Figma ("Toping : oreo")
                    Text(
                      'Toping : $toppingText',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // B. Garis Pemisah Tipis
          Container(
            height: 1,
            color: const Color(0xFFF0F0F0),
            margin: const EdgeInsets.symmetric(vertical: 12),
          ),

          // C. Bagian Bawah: Order Status (Kiri) + Total Harga (Kanan) Sesuai Figma (#125:734 & #125:735)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Status Pengiriman
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Status :',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0FA92C), // Hijau cerah khas Figma
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        order.status,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0FA92C), // Hijau cerah khas Figma
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Total Harga Pesanan
              Text(
                'Total : ${CurrencyFormatter.formatRp(order.totalPrice)}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
