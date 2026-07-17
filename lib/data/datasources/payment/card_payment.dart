import '../../../domain/entities/order.dart';
import '../../../domain/repositories/payment_gateway.dart';

class CardPayment implements PaymentGateway {
  @override
  Future<bool> processPayment(Order order) async {
    print("[Card Payment] processing ... Total: LKR ${order.totalAmount}");
    await Future.delayed(Duration(milliseconds: 800));
    print(
      "[Card Payment] LKR ${order.totalAmount} payment processed successfully!",
    );
    return true;
  }
}
