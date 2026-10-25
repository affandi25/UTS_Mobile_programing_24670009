import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/currency_formatter.dart';
import '../../data/dummy_data.dart';
import '../../models/product_model.dart';


class MenuCatalogScreen extends StatefulWidget {
  final bool showBackButton;
  final VoidCallback? onBack;
  final String? initialQuery;

  const MenuCatalogScreen({
    super.key,
    this.showBackButton = false,
    this.onBack,
    this.initialQuery,
  });

  @override
  State<MenuCatalogScreen> createState() => _MenuCatalogScreenState();
}

class _MenuCatalogScreenState extends State<MenuCatalogScreen> {
  late final TextEditingController _searchController;
  List<ProductModel> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery ?? '');
    final initial = widget.initialQuery?.trim().toLowerCase() ?? '';
    _filteredProducts = initial.isEmpty
        ? List.from(DummyData.products)
        : DummyData.products.where((p) => p.name.toLowerCase().contains(initial)).toList();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = List.from(DummyData.products);
      } else {
        _filteredProducts = DummyData.products
            .where((p) => p.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Column(
        children: [
          // 1. Container Header Coklat Sesuai Figma (#72:555 & #72:562)
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 199, 152, 51), // Warna solid kuning keemasan/coklat
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(29),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x25000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
                child: Column(
                  children: [
                    // A. Header Row: Back Button, Judul "Varian Rasa", Cart Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.showBackButton || widget.onBack != null || Navigator.canPop(context))
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                            onPressed: () {
                              if (widget.onBack != null) {
                                widget.onBack!();
                              } else if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                          )
                        else
                          const SizedBox(width: 40),
                        const Text(
                          'Varian Rasa',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            color: Color(0xFFFFF8F8), // Putih sesuai Figma #72:728
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white24,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // B. Search Bar Putih Sesuai Figma (#72:729 & #104:439)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x15000000),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(fontSize: 14, color: Colors.black45),
                          suffixIcon: Icon(Icons.search_rounded, color: Colors.black54, size: 24),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

            // 3. List Vertikal 6 Varian Rasa Sesuai Figma (#104:582 & #72:725)
            Expanded(
              child: _filteredProducts.isEmpty
                  ? const Center(
                      child: Text(
                        'Rasa tidak ditemukan.',
                        style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      itemCount: _filteredProducts.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return CatalogItemCard(
                          product: product,
                        );
                      },
                    ),
            ),
          ],
        ),
    );
  }
}

/// Widget Kartu Item Donat Sesuai Desain Figma
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
            // 1. Gambar Donat di Sisi Kiri
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

            // 2. Info Menu di Sisi Kanan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

                  // Rating Bintang 5
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

                  // Tombol Ungu "PESAN"
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
