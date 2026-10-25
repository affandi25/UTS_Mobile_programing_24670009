/// Utilitas pemformatan mata uang Rupiah standar
class CurrencyFormatter {
  CurrencyFormatter._();

  /// Mengubah angka int menjadi format Rupiah dengan pemisah ribuan titik.
  /// Contoh: 20000 -> "20.000", 150000 -> "150.000"
  static String format(int amount) {
    return amount.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  /// Format lengkap dengan prefiks Rp.
  /// Contoh: 20000 -> "Rp 20.000"
  static String formatRp(int amount) {
    return 'Rp ${format(amount)}';
  }
}
