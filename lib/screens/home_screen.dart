import 'package:flutter/material.dart';

import '../data/product_repository.dart';
import '../models/product.dart';
import '../state/app_scope.dart';
import '../widgets/cart_action.dart';
import '../widgets/product_image.dart';
import '../widgets/top_banner.dart';

class HomeScreen extends StatefulWidget {
  final ProductRepository repo;

  const HomeScreen({super.key, required this.repo});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isPhone = screenWidth < 600;
    final cart = AppScope.of(context);
    final products = widget.repo.getAll();
    final filtered = products
        .where((p) {
          final q = search.trim().toLowerCase();
          if (q.isEmpty) return true;
          return p.name.toLowerCase().contains(q) ||
              p.tagline.toLowerCase().contains(q);
        })
        .toList(growable: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gift Store'),
        centerTitle: true,
        actions: [CartAction(count: cart.totalItems)],
      ),
      body: Column(
        children: [
          const TopBanner(),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
            child: TextField(
              onChanged: (value) => setState(() => search = value),
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.brown.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.fromLTRB(
                isPhone ? 12 : 10,
                8,
                isPhone ? 12 : 10,
                12,
              ),
              itemCount: filtered.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: isPhone ? 12 : 10,
                mainAxisSpacing: isPhone ? 12 : 10,
                childAspectRatio: isPhone ? 0.7 : 0.95,
              ),
              itemBuilder: (context, index) {
                final Product p = filtered[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () =>
                      Navigator.pushNamed(context, '/product', arguments: p.id),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(isPhone ? 8 : 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: isPhone ? 7 : 5,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                isPhone ? 2 : 8,
                                isPhone ? 6 : 10,
                                isPhone ? 2 : 8,
                                isPhone ? 2 : 8,
                              ),
                              child: ProductImage(
                                url: p.imageUrl,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: isPhone ? 8 : 10),
                          Text(
                            p.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: isPhone ? 15 : 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: isPhone ? 4 : 8),
                          Text(
                            p.displayPrice,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isPhone ? 14 : 15,
                              color: Colors.brown.shade800,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
