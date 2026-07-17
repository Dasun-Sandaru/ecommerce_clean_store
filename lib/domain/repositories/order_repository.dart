import '../entities/order.dart';

abstract class OrderRepository {
  Future<void> saveOrder(Order order);
  Future<Order?> getOrderById(String orderId);
  Future<void> updateOrderStatus(String orderId, OrderStatus status);
}
