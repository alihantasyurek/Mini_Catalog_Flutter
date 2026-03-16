class Product {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String priceRaw;
  final String currency;
  final String imageUrl;

  const Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.priceRaw,
    required this.currency,
    required this.imageUrl,
  });

  int get priceValue {
    final digitsOnly = priceRaw.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(digitsOnly) ?? 0;
  }

  String get displayPrice => '$priceRaw ${currency.toUpperCase()}';

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['id'] as num).toInt(),
      name: (json['name'] as String?) ?? '',
      tagline: (json['tagline'] as String?) ?? '',
      description: (json['description'] as String?) ?? '',
      priceRaw: (json['price'] as String?) ?? '\$0',
      currency: (json['currency'] as String?) ?? 'USD',
      imageUrl: (json['image'] as String?) ?? '',
    );
  }
}

