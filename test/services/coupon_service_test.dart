import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_2/services/coupon_service.dart';

void main() {
  group('CouponService Tests', () {
    final service = CouponService.instance;

    test('Memiliki kupon promo awal sesuai Figma', () {
      expect(service.allCoupons.length, 3);
      expect(service.allCoupons.any((c) => c.code == 'SWEET10K'), isTrue);
      expect(service.allCoupons.any((c) => c.code == 'JUMATBERKAH'), isTrue);
      expect(service.allCoupons.any((c) => c.code == 'GRATISTEH'), isTrue);
    });

    test('Mengklaim kupon berhasil dan memicu status claimed', () {
      expect(service.isClaimed('SWEET10K'), isFalse);
      final success = service.claimCoupon('SWEET10K');
      expect(success, isTrue);
      expect(service.isClaimed('SWEET10K'), isTrue);
      expect(service.claimedCoupons.any((c) => c.code == 'SWEET10K'), isTrue);

      // Klaim ulang menghasilkan false
      final secondClaim = service.claimCoupon('SWEET10K');
      expect(secondClaim, isFalse);
    });

    test('Validasi kupon menghitung diskon dan syarat minimal belanja', () {
      // Belanja cukup (30.000 >= 20.000)
      final valid = service.validateCoupon('SWEET10K', 30000);
      expect(valid.isValid, isTrue);
      expect(valid.discount, 10000);

      // Belanja kurang dari minSpend (10.000 < 20.000)
      final invalidMin = service.validateCoupon('SWEET10K', 10000);
      expect(invalidMin.isValid, isFalse);
      expect(invalidMin.discount, 0);

      // Kode asal-asalan
      final unknown = service.validateCoupon('SALAHKODE', 50000);
      expect(unknown.isValid, isFalse);
    });
  });
}
