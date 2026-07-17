import '../../entities/order.dart';
import '../../repositories/email_service.dart';
import '../../repositories/order_repository.dart';
import '../../repositories/payment_gateway.dart';
import '../../repositories/product_repository.dart';

class PlaceOrderUseCase {
  final ProductRepository _productRepository;
  final OrderRepository _orderRepository;
  final PaymentGateway _paymentGateway;
  final EmailService _emailService;

  PlaceOrderUseCase({
    required ProductRepository productRepository,
    required OrderRepository orderRepository,
    required PaymentGateway paymentGateway,
    required EmailService emailService,
  }) : _productRepository = productRepository,
       _orderRepository = orderRepository,
       _paymentGateway = paymentGateway,
       _emailService = emailService;

  Future<void> execute(Order order) async {
    // Step 1: Check product stock and reduce stock
    for (var item in order.items) {
      item.product.reduceStock = item.quantity;
    }

    // Step 2: Process payment
    bool paymentSuccess = await _paymentGateway.processPayment(order);

    if (!paymentSuccess) {
      throw Exception('Payment failed.');
    }

    // Step 3: Save order
    order.markAsPaid();

    // Step 4: Update product stock
    for (var item in order.items) {
      await _productRepository.updatedProductStock(
        item.product.id,
        item.quantity,
      );
    }

    // Step 5: Save order
    await _orderRepository.saveOrder(order);

    // Step 6: Send order confirmation
    await _emailService.sendOrderConfirmationEmail(order);
  }
}
