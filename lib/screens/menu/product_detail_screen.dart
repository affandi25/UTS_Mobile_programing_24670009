import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/currency_formatter.dart';
import '../../models/product_model.dart';
import '../../models/topping_model.dart';
import '../../data/dummy_data.dart';
import '../order/payment_success_screen.dart';

// Layar Detail Produk & Konfirmasi Pesanan Sesuai Figma (iPhone 16 Plus - 11 s/d 18)
// Fitur:
// 1. Gambar & Nama Varian Rasa
// 2. Alamat Pengiriman ("Delivering to : Alamat rumahmu")
// 3. Dropdown Topping ("Tambah Toping" - Komponen gabung #123:443)
// 4. Pengatur Jumlah Pesanan (Component 2 #125:598)
// 5. Input Kode Voucher ("KODE VOUCHER" & tombol "Kirim")
// 6. Ringkasan Total Harga Dinamis
// 7. Tombol CTA "PESAN" (#431BC6)
class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ToppingModel? _selectedTopping;
  int _quantity = 1;
  final TextEditingController _voucherController = TextEditingController();
  int _discount = 0;
  String _voucherMessage = '';

  int get _itemPrice => widget.product.price;
  int get _toppingPrice => _selectedTopping?.price ?? 0;
  int get _subtotal => (_itemPrice + _toppingPrice) * _quantity;
  int get _grandTotal => (_subtotal - _discount) > 0 ? (_subtotal - _discount) : 0;

  void _applyVoucher([String? explicitCode]) {
    final code = (explicitCode ?? _voucherController.text).trim().toUpperCase();
    if (explicitCode != null) {
      _voucherController.text = explicitCode;
    }

    if (code == 'SWEET10K') {
      setState(() {
        _discount = 10000;
        _voucherMessage = 'Voucher SWEET10K berhasil: Diskon Rp 10.000!';
      });
    } else if (code == 'JUMATBERKAH') {
      setState(() {
        _discount = 5000;
        _voucherMessage = 'Voucher JUMATBERKAH berhasil: Diskon Rp 5.000!';
      });
    } else if (code.isEmpty) {
      setState(() {
        _discount = 0;
        _voucherMessage = 'Kode voucher dihapus.';
      });
    } else {
      setState(() {
        _discount = 0;
        _voucherMessage = 'Kode voucher tidak valid.';
      });
    }

    if (_voucherMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_voucherMessage),
          backgroundColor: _discount > 0 ? const Color(0xFF558B2F) : Colors.redAccent,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _processOrder() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentSuccessScreen(
          product: widget.product,
          topping: _selectedTopping,
          quantity: _quantity,
          grandTotal: _grandTotal,
        ),
      ),
    );
  }

  Color _getFlavorColor(String name) {
    if (name.contains('Coklat')) return const Color(0xFF6D4C41);
    if (name.contains('Matcha')) return const Color(0xFF558B2F);
    if (name.contains('Taro')) return const Color(0xFF7E57C2);
    if (name.contains('Strawberi')) return const Color(0xFFE91E63);
    return AppColors.primaryGold;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textDark, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'bayar Pesanan', // Persis teks Figma #72:739
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Kartu Banner Produk
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x10000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: _getFlavorColor(widget.product.name).withValues(alpha: 0.2),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: widget.product.imagePath.isNotEmpty
                            ? Image.asset(
                                widget.product.imagePath,
                                width: 105,
                                height: 105,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) => Icon(
                                  Icons.cake_rounded,
                                  size: 76,
                                  color: _getFlavorColor(widget.product.name),
                                ),
                              )
                            : Icon(
                                Icons.cake_rounded,
                                size: 76,
                                color: _getFlavorColor(widget.product.name),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      CurrencyFormatter.formatRp(widget.product.price),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.product.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 2. Alamat Pengiriman Sesuai Figma ("Delivering to : Alamat rumahmu")
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.grayInput.withValues(alpha: 0.6)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: AppColors.primaryGold, size: 24),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivering to :', // Persis Figma #125:561
                            style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                          ),
                          Text(
                            'Alamat rumahmu', // Persis Figma #125:566
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textDark),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ubah alamat pengiriman')),
                        );
                      },
                      child: const Text('Ubah', style: TextStyle(fontSize: 12, color: AppColors.primaryGold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 3. Topping Selector (Komponen gabung #123:443)
              ToppingSelector(
                selectedTopping: _selectedTopping,
                onToppingSelected: (val) {
                  setState(() {
                    _selectedTopping = val;
                  });
                },
              ),
              const SizedBox(height: 20),

              // 4. Quantity Counter Row (Component 2 #125:598)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Jumlah Pesanan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  QuantityCounter(
                    quantity: _quantity,
                    onQuantityChanged: (newQty) {
                      setState(() {
                        _quantity = newQty;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 5. Kode Voucher Input Sesuai Figma (#72:786, #72:784, #72:785)
              const Text(
                'KODE VOUCHER', // Persis Figma #72:786
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.grayInput),
                      ),
                      child: TextField(
                        controller: _voucherController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                          hintText: 'Masukan Kode Voucher Anda', // Persis Figma #72:784
                          hintStyle: TextStyle(fontSize: 12, color: Colors.black38),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 46,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGold,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                      ),
                      onPressed: _applyVoucher,
                      child: const Text(
                        'Kirim', // Persis Figma #72:785
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Metode Pembayaran Sesuai Figma (#72:795)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.grayInput.withValues(alpha: 0.6)),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'asset/dana_wallet.png',
                      width: 36,
                      height: 36,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF118EEA), size: 32),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DANA e-wallet', // Persis Figma #72:800
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textDark),
                          ),
                          Text(
                            '08123456789', // Persis Figma #72:801
                            style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.check_circle_rounded, color: Color(0xFF2ED542), size: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 6. Rincian Biaya
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${widget.product.name} (x$_quantity)', style: const TextStyle(fontSize: 13, color: AppColors.textMuted)),
                        Text(CurrencyFormatter.formatRp(_itemPrice * _quantity), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    if (_selectedTopping != null) ...[
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Topping: ${_selectedTopping!.name} (x$_quantity)', style: const TextStyle(fontSize: 13, color: AppColors.textMuted)),
                          Text(CurrencyFormatter.formatRp(_toppingPrice * _quantity), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                    if (_discount > 0) ...[
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Diskon Voucher', style: TextStyle(fontSize: 13, color: Color(0xFF558B2F))),
                          Text('-${CurrencyFormatter.formatRp(_discount)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF558B2F))),
                        ],
                      ),
                    ],
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total', // Persis Figma #72:740
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                        ),
                        Text(
                          CurrencyFormatter.formatRp(_grandTotal), // Persis Figma #72:742
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryGold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 7. Tombol CTA PESAN Sesuai Figma (#340:998 / #431BC6)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF431BC6), // Ungu khas Figma
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                  ),
                  onPressed: _processOrder,
                  child: const Text(
                    'PESAN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget Pemilih Topping Sesuai Komponen Figma "gabung" (#123:443)
class ToppingSelector extends StatelessWidget {
  final ToppingModel? selectedTopping;
  final ValueChanged<ToppingModel?> onToppingSelected;
  final List<ToppingModel> availableToppings;

  const ToppingSelector({
    super.key,
    required this.selectedTopping,
    required this.onToppingSelected,
    this.availableToppings = DummyData.toppings,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pilih Topping',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selectedTopping != null
                  ? AppColors.primaryGold
                  : AppColors.grayInput.withValues(alpha: 0.8),
              width: 1.5,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ToppingModel?>(
              value: selectedTopping,
              isExpanded: true,
              hint: const Text(
                'Tambah Toping', // Persis teks Figma #123:402
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primaryGold),
              items: [
                const DropdownMenuItem<ToppingModel?>(
                  value: null,
                  child: Text(
                    'Tanpa Topping (Original)',
                    style: TextStyle(fontSize: 14, color: AppColors.textMuted),
                  ),
                ),
                ...availableToppings.map(
                  (topping) => DropdownMenuItem<ToppingModel?>(
                    value: topping,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          topping.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          '+${CurrencyFormatter.formatRp(topping.price)}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryGold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: onToppingSelected,
            ),
          ),
        ),
      ],
    );
  }
}

/// Widget Counter Kuantitas Sesuai Komponen Figma "Component 2" (#125:598)
class QuantityCounter extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final int minQuantity;
  final int maxQuantity;

  const QuantityCounter({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
    this.minQuantity = 1,
    this.maxQuantity = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.grayInput.withValues(alpha: 0.8),
          width: 1.2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tombol Minus (-) Sesuai Figma Group 38 (#I125:604;125:573)
          InkWell(
            onTap: quantity > minQuantity
                ? () => onQuantityChanged(quantity - 1)
                : null,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: quantity > minQuantity
                    ? AppColors.primaryGold.withValues(alpha: 0.15)
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.remove,
                  size: 18,
                  color: quantity > minQuantity
                      ? AppColors.primaryGold
                      : Colors.grey.shade400,
                ),
              ),
            ),
          ),

          // Angka Kuantitas Sesuai Figma (#I125:604;125:577)
          Container(
            constraints: const BoxConstraints(minWidth: 36),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '$quantity',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ),

          // Tombol Plus (+) Sesuai Figma Group 39 (#I125:604;125:574)
          InkWell(
            onTap: quantity < maxQuantity
                ? () => onQuantityChanged(quantity + 1)
                : null,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: quantity < maxQuantity
                    ? AppColors.primaryGold
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 18,
                  color: quantity < maxQuantity
                      ? Colors.white
                      : Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

