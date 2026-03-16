import '../models/product.dart';
import 'mock_products.dart';

class ProductRepository {
  const ProductRepository();

  List<Product> getAll() {
    final raw = mockProductsResponse['data'] as List<dynamic>? ?? const [];
    return raw
        .whereType<Map<String, dynamic>>()
        .map(Product.fromJson)
        .toList(growable: false);
  }

  Product? getById(int id) {
    for (final product in getAll()) {
      if (product.id == id) return product;
    }
    return null;
  }
}

