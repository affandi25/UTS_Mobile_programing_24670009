import 'package:flutter/foundation.dart';
import '../models/coupon_model.dart';
import '../models/notification_model.dart';
import 'notification_service.dart';

/// Hasil validasi kupon untuk kebutuhan checkout
class CouponValidationResult {
  final bool isValid;
  final CouponModel? coupon;
  final int discount;
  final String message;

  const CouponValidationResult({
    required this.isValid,
    this.coupon,
    this.discount = 0,
    required this.message,
  });
}

/// Service untuk mengelola kupon promo, dompet voucher, dan verifikasi diskon.
/// Bertindak sebagai single source of truth dan database mock sebelum terhubung ke Laravel REST API.
class CouponService extends ChangeNotifier {
  CouponService._internal();
  static final CouponService instance = CouponService._internal();

  // In-memory data kupon (sesuai promo Figma #253:1127)
  final List<CouponModel> _coupons = [
    const CouponModel(
      id: 'c1',
      code: 'SWEET10K',
      title: '1 Paket Cuma 10k',
      description: 'Potongan Rp 10.000 untuk paket donat box spesial.',
      discountAmount: 10000,
      minSpend: 20000,
      isClaimed: false,
    ),
    const CouponModel(
      id: 'c2',
      code: 'JUMATBERKAH',
      title: 'Jumat Berkah Cuma 5K',
      description: 'Potongan Rp 5.000 spesial berkah manis hari Jumat.',
      discountAmount: 5000,
      minSpend: 15000,
      isClaimed: false,
    ),
    const CouponModel(
      id: 'c3',
      code: 'GRATISTEH',
      title: 'Beli 2 Gratis Es Teh',
      description: 'Potongan Rp 3.000 setara gratis 1 cup es teh segar meluap.',
      discountAmount: 3000,
      minSpend: 20000,
      isClaimed: false,
    ),
  ];

  /// Mengambil semua daftar kupon promo
  List<CouponModel> get allCoupons => List.unmodifiable(_coupons);

  /// Mengambil daftar kupon yang sudah diklaim pengguna
  List<CouponModel> get claimedCoupons =>
      _coupons.where((c) => c.isClaimed).toList();

  /// Memeriksa apakah kupon dengan kode tertentu sudah diklaim
  bool isClaimed(String code) {
    final normalized = code.trim().toUpperCase();
    final index = _coupons.indexWhere((c) => c.code == normalized);
    return index != -1 && _coupons[index].isClaimed;
  }

  /// Mengklaim kupon ke dompet voucher pengguna dan memicu notifikasi sistem
  bool claimCoupon(String code) {
    final normalized = code.trim().toUpperCase();
    final index = _coupons.indexWhere((c) => c.code == normalized);
    if (index == -1) return false;

    if (_coupons[index].isClaimed) {
      return false; // Sudah pernah diklaim sebelumnya
    }

    final target = _coupons[index];
    _coupons[index] = target.copyWith(isClaimed: true);

    // Memicu notifikasi promo baru secara otomatis ke lonceng Beranda
    NotificationService.instance.addNotification(
      title: 'Kupon Berhasil Diklaim! 🎟️',
      message: 'Voucher "${target.code}" (${target.title}) siap dipakai saat checkout.',
      type: NotificationType.promo,
    );

    notifyListeners();
    return true;
  }

  /// Memvalidasi kode kupon terhadap total belanjaan saat ini
  CouponValidationResult validateCoupon(String rawCode, int currentSubtotal) {
    final normalized = rawCode.trim().toUpperCase();
    if (normalized.isEmpty) {
      return const CouponValidationResult(
        isValid: false,
        discount: 0,
        message: '',
      );
    }

    final index = _coupons.indexWhere((c) => c.code == normalized);
    if (index == -1) {
      return const CouponValidationResult(
        isValid: false,
        discount: 0,
        message: 'Kode kupon tidak valid atau tidak ditemukan.',
      );
    }

    final coupon = _coupons[index];

    // Cek syarat minimal belanja
    if (currentSubtotal < coupon.minSpend) {
      return CouponValidationResult(
        isValid: false,
        coupon: coupon,
        discount: 0,
        message: 'Minimal belanja untuk kupon ini adalah Rp ${coupon.minSpend}.',
      );
    }

    return CouponValidationResult(
      isValid: true,
      coupon: coupon,
      discount: coupon.discountAmount,
      message: 'Kupon "${coupon.code}" berhasil diterapkan! Hemat Rp ${coupon.discountAmount}.',
    );
  }
}
