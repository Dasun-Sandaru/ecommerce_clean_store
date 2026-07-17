import '../../repositories/order_repository.dart';

class CancelOrderUseCase {
  final OrderRepository _orderRepository;

  CancelOrderUseCase(this._orderRepository);

  Future<void> execute(String orderId) async {
    if (orderId.trim().isEmpty) {
      throw Exception('Order ID cannot be empty.');
    }

    final order = await _orderRepository.getOrderById(orderId);

    if (order == null) {
      throw Exception('Order not found.');
    }

    order.cancleOrder();

    await _orderRepository.updateOrderStatus(orderId, order.status);
  }
}
