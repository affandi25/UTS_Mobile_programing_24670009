import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_2/services/product_service.dart';

void main() {
  group('ProductService Tests', () {
    final service = ProductService.instance;

    test('Mengambil semua produk dan best sellers', () {
      expect(service.products.length, 6);
      expect(service.bestSellers.isNotEmpty, true);
    });

    test('Pencarian potongan huruf / prefix berhasil', () {
      final cok = service.searchProducts('cok');
      expect(cok.any((p) => p.name == 'Rasa Coklat'), isTrue);

      final mat = service.searchProducts('mat');
      expect(mat.any((p) => p.name == 'Rasa Matcha'), isTrue);
    });

    test('Pencarian toleransi typo dan ejaan berhasil', () {
      // Ejaan tiramisu (s) vs tiramizu (z)
      final tiramisu = service.searchProducts('tiramisu');
      expect(tiramisu.any((p) => p.name == 'Rasa Tiramizu'), isTrue);

      // Typo coklatt (kelebihan t)
      final coklatt = service.searchProducts('coklatt');
      expect(coklatt.any((p) => p.name == 'Rasa Coklat'), isTrue);

      // Bahasa Inggris strawberry vs strawberi
      final strawberry = service.searchProducts('strawberry');
      expect(strawberry.any((p) => p.name == 'Rasa Strawberi'), isTrue);

      // Sinonim greentea vs matcha
      final greentea = service.searchProducts('greentea');
      expect(greentea.any((p) => p.name == 'Rasa Matcha'), isTrue);
    });

    test('Pencarian kata tidak dikenal menghasilkan list kosong', () {
      final kosong = service.searchProducts('xyz999tidakada');
      expect(kosong.isEmpty, isTrue);
    });
  });
}
