import '../entities/order.dart';

abstract class PaymentGateway {
  Future<bool> processPayment(Order order);
}
