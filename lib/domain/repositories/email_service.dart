import '../entities/order.dart';

abstract class EmailService {
  Future<void> sendOrderConfirmationEmail(Order order);
}
