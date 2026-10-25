import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../data/dummy_data.dart';
import '../../models/product_model.dart';
import '../../widgets/catalog_item_card.dart';
import 'product_detail_screen.dart';

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
  List<ProductModel> _filteredProducts = DummyData.products;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery ?? '');
    if (widget.initialQuery != null && widget.initialQuery!.trim().isNotEmpty) {
      final query = widget.initialQuery!.toLowerCase().trim();
      _filteredProducts = DummyData.products
          .where((p) => p.name.toLowerCase().contains(query))
          .toList();
    }
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = DummyData.products;
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailScreen(product: product),
                              ),
                            );
                          },
                          onPesan: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailScreen(product: product),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
    );
  }
}
