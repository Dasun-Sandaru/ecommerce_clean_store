import 'cart_item.dart';

enum OrderStatus { pending, paid, shipped, cancled }

class Order {
  final String id;
  final String customerId;
  final List<CartItem> items;
  final DateTime timestamp;
  OrderStatus _status;

  Order({
    required this.id,
    required this.customerId,
    required this.items,
    required this.timestamp,
  }) : _status = OrderStatus.pending;

  OrderStatus get status => _status;

  double get totalAmount {
    double total = 0;
    for (var item in items) {
      total += item.subtotal;
    }
    return total;
  }

  void cancleOrder() {
    if (_status == OrderStatus.shipped) {
      throw Exception('Cannot cancel an order that has been shipped.');
    }

    _status = OrderStatus.cancled;
  }

  void markAsPaid() {
    if (_status == OrderStatus.cancled) {
      throw Exception('Cannot mark an order that has been cancled.');
    }
    _status = OrderStatus.paid;
  }
}
