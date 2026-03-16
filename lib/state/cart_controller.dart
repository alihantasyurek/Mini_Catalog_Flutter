import 'package:flutter/foundation.dart';

import '../models/product.dart';

class CartLine {
  final Product product;
  final int quantity;

  const CartLine({required this.product, required this.quantity});
}

class CartController extends ChangeNotifier {
  final Map<int, int> _qtyByProductId = <int, int>{};
  final Map<int, Product> _productsById = <int, Product>{};

  void add(Product product) {
    _productsById[product.id] = product;
    _qtyByProductId[product.id] = (_qtyByProductId[product.id] ?? 0) + 1;
    notifyListeners();
  }

  void increment(int productId) {
    final current = _qtyByProductId[productId];
    if (current == null) return;
    _qtyByProductId[productId] = current + 1;
    notifyListeners();
  }

  void decrement(int productId) {
    final current = _qtyByProductId[productId];
    if (current == null) return;
    if (current > 1) {
      _qtyByProductId[productId] = current - 1;
    } else {
      _qtyByProductId.remove(productId);
      _productsById.remove(productId);
    }
    notifyListeners();
  }

  void remove(int productId) {
    _qtyByProductId.remove(productId);
    _productsById.remove(productId);
    notifyListeners();
  }

  void clear() {
    _qtyByProductId.clear();
    _productsById.clear();
    notifyListeners();
  }

  int get totalItems {
    var total = 0;
    for (final q in _qtyByProductId.values) {
      total += q;
    }
    return total;
  }

  int totalAmountValue() {
    var total = 0;
    _qtyByProductId.forEach((id, qty) {
      final p = _productsById[id];
      if (p == null) return;
      total += p.priceValue * qty;
    });
    return total;
  }

  String currency() {
    for (final p in _productsById.values) {
      return p.currency.toUpperCase();
    }
    return 'USD';
  }

  List<CartLine> lines() {
    final ids = _qtyByProductId.keys.toList()..sort();
    return ids
        .map((id) {
          final product = _productsById[id];
          final qty = _qtyByProductId[id] ?? 0;
          if (product == null || qty <= 0) return null;
          return CartLine(product: product, quantity: qty);
        })
        .whereType<CartLine>()
        .toList(growable: false);
  }
}
