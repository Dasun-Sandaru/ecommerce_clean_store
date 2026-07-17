import '../../entities/order.dart';
import '../../repositories/order_repository.dart';

class TrackOrderUseCase {
  final OrderRepository _orderRepository;

  TrackOrderUseCase(this._orderRepository);

  Future<Order?> execute(String orderId) async {
    if (orderId.trim().isEmpty) {
      throw Exception('Order ID cannot be empty.');
    }
    return await _orderRepository.getOrderById(orderId);
  }
}
