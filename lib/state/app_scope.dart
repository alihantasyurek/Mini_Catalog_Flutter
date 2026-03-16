import 'package:flutter/widgets.dart';

import 'cart_controller.dart';

class AppScope extends InheritedNotifier<CartController> {
  const AppScope({
    super.key,
    required CartController cart,
    required super.child,
  }) : super(notifier: cart);

  static CartController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found in widget tree.');
    return scope!.notifier!;
  }
}
