import 'dart:math';
import 'package:flutter/foundation.dart';
import '../data/dummy_data.dart';
import '../models/product_model.dart';

/// Service untuk mengelola katalog produk, pencarian cerdas, dan toleransi typo.
/// Bertindak sebagai single source of truth sebelum nanti disambungkan ke Laravel REST API.
class ProductService extends ChangeNotifier {
  ProductService._();
  static final ProductService instance = ProductService._();

  // In-memory data (akan diganti response HTTP dari Laravel API nantinya)
  final List<ProductModel> _products = List.unmodifiable(DummyData.products);

  /// Mengambil semua produk
  List<ProductModel> get products => _products;

  /// Mengambil produk yang ditandai Best Seller
  List<ProductModel> get bestSellers =>
      _products.where((p) => p.isBestSeller).toList();

  /// Mencari produk berdasarkan ID
  ProductModel? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Mencari produk berdasarkan kata kunci nama dengan fallback aman
  ProductModel findByNameKeyword(String keyword, {ProductModel? fallback}) {
    final lower = keyword.toLowerCase();
    try {
      return _products.firstWhere(
        (p) => p.name.toLowerCase().contains(lower),
      );
    } catch (_) {
      return fallback ?? _products.first;
    }
  }

  // Kamus alias untuk normalisasi typo dan sinonim bahasa umum
  static const Map<String, String> _synonymAliases = {
    // Tiramizu / Tiramisu
    'tiramisu': 'tiramizu',
    'tiramis': 'tiramizu',
    'tiramiz': 'tiramizu',
    'tira': 'tiramizu',

    // Coklat / Chocolate
    'chocolate': 'coklat',
    'choclate': 'coklat',
    'choc': 'coklat',
    'choco': 'coklat',
    'cokelat': 'coklat',
    'coklatt': 'coklat',
    'coklt': 'coklat',

    // Strawberi / Strawberry
    'strawberry': 'strawberi',
    'stroberi': 'strawberi',
    'strobery': 'strawberi',
    'strawbery': 'strawberi',
    'berry': 'strawberi',
    'beri': 'strawberi',

    // Matcha / Green Tea
    'greentea': 'matcha',
    'green tea': 'matcha',
    'teh hijau': 'matcha',
    'maca': 'matcha',
    'macha': 'matcha',
    'matchaa': 'matcha',

    // Taro / Talas
    'talas': 'taro',
    'ungu': 'taro',
    'taroo': 'taro',

    // Mix Rasa
    'campur': 'mix',
    'aneka': 'mix',
    'kombinasi': 'mix',
  };

  /// Pencarian produk cerdas:
  /// 1. Substring match (nama & deskripsi)
  /// 2. Kamus sinonim & typo populer
  /// 3. Toleransi selisih 1-2 huruf (Levenshtein Distance)
  List<ProductModel> searchProducts(String rawQuery) {
    final query = rawQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return _products;
    }

    // 1. Cek langsung kecocokan substring pada nama atau deskripsi
    final directMatches = _products.where((p) {
      final name = p.name.toLowerCase();
      final desc = p.description.toLowerCase();
      return name.contains(query) || desc.contains(query);
    }).toList();

    if (directMatches.isNotEmpty) {
      return directMatches;
    }

    // 2. Cek kamus sinonim / alias typo umum
    final resolvedKeyword = _synonymAliases[query];
    if (resolvedKeyword != null) {
      final aliasMatches = _products.where((p) {
        final name = p.name.toLowerCase();
        return name.contains(resolvedKeyword);
      }).toList();
      if (aliasMatches.isNotEmpty) {
        return aliasMatches;
      }
    }

    // 3. Toleransi typo menggunakan perbandingan kemiripan karakter
    final fuzzyMatches = _products.where((p) {
      final words = p.name.toLowerCase().split(' ');
      for (final word in words) {
        if (_isSimilar(query, word)) {
          return true;
        }
      }
      return false;
    }).toList();

    return fuzzyMatches;
  }

  /// Menilai kemiripan dua kata (maksimal 1 typo untuk kata pendek, 2 typo untuk kata panjang)
  bool _isSimilar(String a, String b) {
    if ((a.length - b.length).abs() > 2) return false;
    final dist = _levenshteinDistance(a, b);
    final maxAllowed = a.length <= 4 ? 1 : 2;
    return dist <= maxAllowed;
  }

  /// Menghitung jarak Levenshtein antara dua kata
  int _levenshteinDistance(String s, String t) {
    if (s == t) return 0;
    if (s.isEmpty) return t.length;
    if (t.isEmpty) return s.length;

    List<int> v0 = List<int>.generate(t.length + 1, (i) => i);
    List<int> v1 = List<int>.filled(t.length + 1, 0);

    for (int i = 0; i < s.length; i++) {
      v1[0] = i + 1;
      for (int j = 0; j < t.length; j++) {
        final cost = s[i] == t[j] ? 0 : 1;
        v1[j + 1] = min(v1[j] + 1, min(v0[j + 1] + 1, v0[j] + cost));
      }
      for (int j = 0; j <= t.length; j++) {
        v0[j] = v1[j];
      }
    }
    return v0[t.length];
  }
}
