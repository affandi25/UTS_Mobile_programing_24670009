import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/currency_formatter.dart';
import '../models/topping_model.dart';
import '../data/dummy_data.dart';

// Widget Pemilih Topping Sesuai Komponen Figma "gabung" (#123:443)
// State Default: "Tambah Toping" dengan panah dropdown
// State Expanded: Pilihan Oreo, Chocochip, Sprinkle, Kacang almond, Keju
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
