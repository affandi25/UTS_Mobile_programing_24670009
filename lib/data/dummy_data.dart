class DummyData {
  // 6 Varian Rasa dari Figma
  static const List<Map<String, dynamic>> products = [
    {
      'id': 'p1',
      'name': 'Rasa Coklat',
      'price': 20000,
      'imagePath': 'asset/rasa_coklat.png',
      'description': 'Donat lezat dengan lelehan coklat premium yang kaya rasa.',
      'isBestSeller': true,
    },
    {
      'id': 'p2',
      'name': 'Rasa Strawberi',
      'price': 20000,
      'imagePath': 'asset/rasa_strawberi.png',
      'description': 'Perpaduan manis dan segar buah strawberi alami.',
      'isBestSeller': false,
    },
    {
      'id': 'p3',
      'name': 'Rasa Taro',
      'price': 23000,
      'imagePath': 'asset/rasa_taro.png',
      'description': 'Cita rasa khas talas ungu lembut yang creamy.',
      'isBestSeller': true,
    },
    {
      'id': 'p4',
      'name': 'Rasa Matcha',
      'price': 22000,
      'imagePath': 'asset/rasa_matcha.png',
      'description': 'Matcha hijau autentik dengan aroma teh menenangkan.',
      'isBestSeller': true,
    },
    {
      'id': 'p5',
      'name': 'Rasa Tiramizu',
      'price': 23000,
      'imagePath': 'asset/rasa_tiramizu.png',
      'description': 'Aroma kopi espresso berpadu keju mascarpone lembut.',
      'isBestSeller': false,
    },
    {
      'id': 'p6',
      'name': 'Mix Rasa',
      'price': 25000,
      'imagePath': 'asset/mix_rasa.png',
      'description': 'Kombinasi aneka rasa favorit dalam satu sajian istimewa.',
      'isBestSeller': true,
    },
  ];

  // Mock Pesanan Aktif untuk My Order Screen (Sesuai Figma #125:670)
  static const List<Map<String, dynamic>> sampleOrders = [
    {
      'name': 'Rasa Coklat',
      'price': 20000,
      'imagePath': 'asset/rasa_coklat.png',
      'topping': 'Oreo',
      'quantity': 2,
      'totalPrice': 46000,
      'status': 'delivery',
    },
    {
      'name': 'Rasa Tiramizu',
      'price': 23000,
      'imagePath': 'asset/rasa_tiramizu.png',
      'topping': 'Oreo',
      'quantity': 2,
      'totalPrice': 52000,
      'status': 'delivery',
    },
    {
      'name': 'Rasa Matcha',
      'price': 22000,
      'imagePath': 'asset/rasa_matcha.png',
      'topping': 'Oreo',
      'quantity': 2,
      'totalPrice': 50000,
      'status': 'delivery',
    },
    {
      'name': 'Rasa Taro',
      'price': 23000,
      'imagePath': 'asset/rasa_taro.png',
      'topping': 'Oreo',
      'quantity': 2,
      'totalPrice': 52000,
      'status': 'delivery',
    },
  ];
}
