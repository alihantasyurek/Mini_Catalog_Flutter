import 'package:flutter/material.dart';

import '../models/product.dart';
import '../state/app_scope.dart';
import '../widgets/cart_action.dart';
import '../widgets/product_image.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isPhone = screenWidth < 600;
    final cart = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
        actions: [CartAction(count: cart.totalItems)],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          isPhone ? 16 : 20,
          16,
          isPhone ? 16 : 20,
          24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.brown.shade50, Colors.orange.shade50],
                ),
                borderRadius: BorderRadius.circular(isPhone ? 24 : 28),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  isPhone ? 12 : 20,
                  isPhone ? 18 : 24,
                  isPhone ? 12 : 20,
                  isPhone ? 12 : 16,
                ),
                child: Center(
                  child: SizedBox(
                    height: isPhone ? 300 : 340,
                    child: ProductImage(
                      url: product.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              product.name,
              style: TextStyle(
                fontSize: isPhone ? 24 : 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            if (product.tagline.trim().isNotEmpty)
              Text(
                product.tagline,
                style: TextStyle(
                  fontSize: isPhone ? 14 : 15,
                  height: 1.3,
                  color: Colors.brown.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            const SizedBox(height: 10),
            Text(
              product.displayPrice,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.brown,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  cart.add(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.name} added to cart.')),
                  );
                },
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
