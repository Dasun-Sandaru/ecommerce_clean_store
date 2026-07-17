import '../../../domain/entities/order.dart';
import '../../../domain/repositories/payment_gateway.dart';

class WalletPayment implements PaymentGateway {
  @override
  Future<bool> processPayment(Order order) async {
    print("[Wallet Payment] processing ... Total: LKR ${order.totalAmount}");
    await Future.delayed(Duration(milliseconds: 800));
    print(
      "[Wallet Payment] LKR ${order.totalAmount} payment processed successfully!",
    );
    return true;
  }
}
