import '../../../domain/entities/order.dart';
import '../../../domain/repositories/payment_gateway.dart';

class CodPayment implements PaymentGateway {
  @override
  Future<bool> processPayment(Order order) async {
    print("[Cash On Delivery] processing ... Total: LKR ${order.totalAmount}");
    await Future.delayed(Duration(milliseconds: 800));
    print(
      "[Cash On Delivery] Confirmed! We will charge LKR ${order.totalAmount} after delivery.",
    );
    return true;
  }
}
