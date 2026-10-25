import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/currency_formatter.dart';
import '../models/product_model.dart';

class CatalogItemCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onPesan;
  final VoidCallback? onTap;

  const CatalogItemCard({
    super.key,
    required this.product,
    this.onPesan,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x10000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // 1. Gambar / Visual Donat di Sisi Kiri Sesuai Figma (#72:595)
            Container(
              width: 110,
              height: 110,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: product.imagePath.isNotEmpty
                    ? Image.asset(
                        product.imagePath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.cake_rounded,
                          size: 58,
                          color: _getFlavorColor(product.name),
                        ),
                      )
                    : Icon(
                        Icons.cake_rounded,
                        size: 58,
                        color: _getFlavorColor(product.name),
                      ),
              ),
            ),
            const SizedBox(width: 16),

            // 2. Info Menu di Sisi Kanan Sesuai Figma (#72:602 - #72:605)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Varian Rasa
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Rating Bintang 5 Sesuai Figma (#72:596 - 4 Emas, 1 Pudar)
                  Row(
                    children: [
                      for (int i = 0; i < 4; i++)
                        const Icon(Icons.star_rounded, size: 18, color: AppColors.yellowAccent),
                      Icon(
                        Icons.star_rounded,
                        size: 18,
                        color: AppColors.yellowAccent.withValues(alpha: 0.35),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '4.8',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                      ),
            
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Harga Produk
                  Text(
                    CurrencyFormatter.formatRp(product.price),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Tombol Ungu "PESAN" Sesuai Figma (#342:1018 - #431BC6)
                  SizedBox(
                    width: 125,
                    height: 32,
                    child: ElevatedButton(
                      onPressed: onPesan ?? onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF431BC6),
                        elevation: 2,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'PESAN',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getFlavorColor(String name) {
    if (name.contains('Coklat')) return const Color(0xFF6D4C41);
    if (name.contains('Matcha')) return const Color(0xFF558B2F);
    if (name.contains('Taro')) return const Color(0xFF7E57C2);
    if (name.contains('Strawberi')) return const Color(0xFFE91E63);
    if (name.contains('Tiramizu')) return const Color(0xFF8D6E63);
    return AppColors.primaryGold;
  }
}
