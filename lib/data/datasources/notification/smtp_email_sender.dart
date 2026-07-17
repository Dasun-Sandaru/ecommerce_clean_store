import '../../../domain/entities/order.dart';
import '../../../domain/repositories/email_service.dart';

class SmtpEmailSender implements EmailService {
  @override
  Future<void> sendOrderConfirmationEmail(Order order) async {
    print('📧 [Email Service] Sending confirmation email to customer...');
    await Future.delayed(Duration(seconds: 1));
    print('====================================================');
    print('📧 CONFIRMATION EMAIL SENT!');
    print('To: customer_${order.customerId}@gmail.com');
    print('Subject: Your order #${order.id} Succesfully Placed!');
    print(
      'Message: Total amount of your order is LKR ${order.totalAmount} paid successfully.',
    );
    print('====================================================');
  }
}
