import 'package:flutter/material.dart';

import '../data/product_repository.dart';
import '../state/app_scope.dart';
import '../state/cart_controller.dart';
import '../screens/cart_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/home_screen.dart';

class GiftStoreApp extends StatefulWidget {
  const GiftStoreApp({super.key});

  @override
  State<GiftStoreApp> createState() => _GiftStoreAppState();
}

class _GiftStoreAppState extends State<GiftStoreApp> {
  late final CartController _cart;
  late final ProductRepository _repo;

  @override
  void initState() {
    super.initState();
    _cart = CartController();
    _repo = const ProductRepository();
  }

  @override
  void dispose() {
    _cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      cart: _cart,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gift Store',
        theme: ThemeData(primarySwatch: Colors.brown),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return MaterialPageRoute(
              builder: (context) => HomeScreen(repo: _repo),
            );
          }

          if (settings.name == '/product') {
            final id = settings.arguments as int?;
            if (id == null) {
              return MaterialPageRoute(
                builder: (context) => const _NotFoundScreen(
                  message: 'Invalid product id.',
                ),
              );
            }
            final product = _repo.getById(id);
            if (product == null) {
              return MaterialPageRoute(
                builder: (context) => const _NotFoundScreen(
                  message: 'Product not found.',
                ),
              );
            }
            return MaterialPageRoute(
              builder: (context) => DetailScreen(product: product),
            );
          }

          if (settings.name == '/cart') {
            return MaterialPageRoute(builder: (context) => const CartScreen());
          }

          return MaterialPageRoute(
            builder: (context) => const _NotFoundScreen(
              message: 'Page not found.',
            ),
          );
        },
      ),
    );
  }
}

class _NotFoundScreen extends StatelessWidget {
  final String message;
  const _NotFoundScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

