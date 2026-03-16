import 'package:flutter/material.dart';

import '../state/app_scope.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = AppScope.of(context);
    final lines = cart.lines();
    final total = cart.totalAmountValue();
    final currency = cart.currency();

    return Scaffold(
      appBar: AppBar(title: const Text('Cart'), centerTitle: true),
      body: lines.isEmpty
          ? const Center(
              child: Text(
                'Your cart is currently empty.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: lines.length,
                    itemBuilder: (context, index) {
                      final line = lines[index];
                      final p = line.product;
                      final qty = line.quantity;
                      final lineTotal = p.priceValue * qty;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.shopping_bag,
                            size: 38,
                            color: Colors.brown,
                          ),
                          title: Text(
                            p.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${p.priceRaw} x $qty = \$$lineTotal $currency',
                          ),
                          trailing: SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () => cart.decrement(p.id),
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                Text(
                                  qty.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => cart.increment(p.id),
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                              ],
                            ),
                          ),
                          onLongPress: () {
                            cart.remove(p.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${p.name} removed from cart.'),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.brown.shade50,
                    border: const Border(
                      top: BorderSide(color: Colors.brown, width: 0.4),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Amount',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$$total $currency',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            cart.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Order processing successfully simulated.',
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Complete Order',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
