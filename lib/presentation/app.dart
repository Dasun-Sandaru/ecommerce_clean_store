import '../domain/entities/cart_item.dart';
import '../domain/entities/order.dart';
import '../domain/entities/product.dart';
import '../domain/usecases/admin/cancel_order_usecase.dart';
import '../domain/usecases/admin/track_order_usecase.dart';
import '../domain/usecases/customer/place_order_usecase.dart';

class App {
  final PlaceOrderUseCase _placeOrderUseCase;
  final TrackOrderUseCase _trackOrderUseCase;
  final CancelOrderUseCase _cancelOrderUseCase;

  App({
    required PlaceOrderUseCase placeOrderUseCase,
    required TrackOrderUseCase trackOrderUseCase,
    required CancelOrderUseCase cancelOrderUseCase,
  }) : _placeOrderUseCase = placeOrderUseCase,
       _trackOrderUseCase = trackOrderUseCase,
       _cancelOrderUseCase = cancelOrderUseCase;

  // 🛒 1. Execute Customer Flow
  Future<void> simulateCustomerFlow({
    required String orderId,
    required String customerId,
    required List<Product> availableProducts,
    required List<int> selectionIndices,
    required List<int> quantities,
  }) async {
    print('\n--- 🛒 CUSTOMER FLOW STARTED ---');
    print('Customer $customerId is selecting products...');

    List<CartItem> cart = [];
    for (int i = 0; i < selectionIndices.length; i++) {
      final product = availableProducts[selectionIndices[i]];
      cart.add(CartItem(product: product, quantity: quantities[i]));
      print('-> Added to cart: ${product.name} x ${quantities[i]}');
    }

    // Create a new order
    final newOrder = Order(
      id: orderId,
      customerId: customerId,
      items: cart,
      timestamp: DateTime.now(),
    );

    try {
      // Place the order using the use case
      await _placeOrderUseCase.execute(newOrder);
      print('🎉 [Success] Customer order has been placed successfully!');
    } catch (e) {
      print('❌ [Error] Failed to place customer order: $e');
    }
  }

  // 🛡️ 2. Execute Admin Flow
  Future<void> simulateAdminFlow(String orderId) async {
    print('\n--- 🛡️ ADMIN FLOW STARTED ---');
    print('Admin is reviewing order #$orderId...');

    // Track the order
    final order = await _trackOrderUseCase.execute(orderId);

    if (order != null) {
      print(
        '🔍 [Order Found] Status: ${order.status.name.toUpperCase()} | Total: LKR ${order.totalAmount}',
      );

      // Attempt to cancel the order
      print('Attempting to cancel the order...');

      try {
        await _cancelOrderUseCase.execute(orderId);
        print(
          '✓ [Success] Order has been cancelled successfully by the admin.',
        );
      } catch (e) {
        print('❌ [Error] Failed to cancel the order: $e');
      }
    } else {
      print('❌ Order not found!');
    }
  }
}
