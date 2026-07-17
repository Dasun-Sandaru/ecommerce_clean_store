import 'data/repositories/product_repository_impl.dart';
import 'data/repositories/order_repository_impl.dart';
import 'data/datasources/payment/card_payment.dart';
import 'data/datasources/payment/cod_payment.dart';
import 'data/datasources/payment/wallet_payment.dart';
import 'data/datasources/notification/smtp_email_sender.dart';

import 'domain/usecases/admin/cancel_order_usecase.dart';
import 'domain/usecases/admin/track_order_usecase.dart';
import 'domain/usecases/customer/place_order_usecase.dart';
import 'presentation/app.dart';

void main() async {
  print('=== 📦 ONLINE E-COMMERCE STORE SYSTEM STARTING ===\n');

  // 1. Initialize Repositories (Database Setup)
  final productRepo = ProductRepositoryImpl();
  final orderRepo = OrderRepositoryImpl();

  // 2. Client Requirement: Multiple Payment Methods Available (OCP)
  final creditCardPayment = CardPayment();
  final eWalletPayment = WalletPayment();
  final cashOnDelivery = CodPayment();

  // Prevent unused variable warnings (optional)
  // These instances demonstrate the available payment options.
  // ignore: unused_local_variable
  final _ = [creditCardPayment, cashOnDelivery];

  // 3. Initialize Email Service
  final emailService = SmtpEmailSender();

  // 4. Initialize Use Cases (Injecting Dependencies via Interfaces)
  // Example: Assume the customer chooses Wallet Payment.
  final placeOrderUseCase = PlaceOrderUseCase(
    productRepository: productRepo,
    orderRepository: orderRepo,
    // You can replace this with any payment method (OCP)
    paymentGateway: eWalletPayment,
    emailService: emailService,
  );

  final trackOrderUseCase = TrackOrderUseCase(orderRepo);
  final cancelOrderUseCase = CancelOrderUseCase(orderRepo);

  // 5. Setup UI
  final app = App(
    placeOrderUseCase: placeOrderUseCase,
    trackOrderUseCase: trackOrderUseCase,
    cancelOrderUseCase: cancelOrderUseCase,
  );

  // --- RUN SYSTEM SIMULATION ---

  // Fetch all available products from the database (Product Browsing)
  final products = await productRepo.fetchProducts();

  print('🏪 Available Products in the Store:');
  for (var p in products) {
    print(
      '- [ID: ${p.id}] ${p.name} | Price: LKR ${p.price} | Stock: ${p.stockQuantity}',
    );
  }

  // 🛒 Customer places an order (1 MacBook and 2 iPhones)
  await app.simulateCustomerFlow(
    orderId: 'ORD-2026-99',
    customerId: 'CUST-DASUN',
    availableProducts: products,
    selectionIndices: [0, 1], // MacBook (Index 0) and iPhone (Index 1)
    quantities: [1, 2], // 1 MacBook and 2 iPhones
  );

  // 🛡️ Admin reviews the order and cancels it
  await app.simulateAdminFlow('ORD-2026-99');

  print('\n=== 📦 SYSTEM SIMULATION FINISHED ===');
}
