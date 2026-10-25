class CouponModel {
  final String id;
  final String code;
  final String title;
  final String description;
  final int discountAmount;
  final int minSpend;
  final bool isClaimed;

  const CouponModel({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.discountAmount,
    this.minSpend = 0,
    this.isClaimed = false,
  });

  CouponModel copyWith({
    String? id,
    String? code,
    String? title,
    String? description,
    int? discountAmount,
    int? minSpend,
    bool? isClaimed,
  }) {
    return CouponModel(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      discountAmount: discountAmount ?? this.discountAmount,
      minSpend: minSpend ?? this.minSpend,
      isClaimed: isClaimed ?? this.isClaimed,
    );
  }
}
