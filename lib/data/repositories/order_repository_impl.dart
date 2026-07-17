import 'package:ecommerce_clean_store/domain/entities/order.dart';

import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final Map<String, Order> _mockDatabaseOrders = {};

  @override
  Future<Order?> getOrderById(String orderId) async {
    await Future.delayed(Duration(milliseconds: 300));

    return _mockDatabaseOrders[orderId];
  }

  @override
  Future<void> saveOrder(Order order) async {
    await Future.delayed(Duration(milliseconds: 400));
    _mockDatabaseOrders[order.id] = order;
    print("[DB Insert] Order #${order.id} saved");
  }

  @override
  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    await Future.delayed(Duration(milliseconds: 200));

    if (_mockDatabaseOrders.containsKey(orderId)) {
      final updatedOrder = _mockDatabaseOrders[orderId]!;
      print(
        '💾 [DB Update] Order #$orderId status updated to${status.name.toUpperCase()}',
      );
    } else {
      throw Exception('Order not found');
    }
  }
}
