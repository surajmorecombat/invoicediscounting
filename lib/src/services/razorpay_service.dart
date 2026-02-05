import 'package:razorpay_flutter/razorpay_flutter.dart';


class RazorpayService {
  late Razorpay _razorpay;

  void init({
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onError,
    required Function(ExternalWalletResponse) onExternalWallet,
  }) {
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
  }


  void openCheckout({
    required int amount, 
    required String keyId,
    String appName = 'My App',
    String description = 'Payment',
    String? contact,
    String? email,
  }) {
    final options = {
      'key': keyId, 
      'amount': amount,
      'name': appName,
      'description': description,
      'prefill': {
        if (contact != null) 'contact': contact,
        if (email != null) 'email': email,
      },
      'theme': {
        'color': '#3399cc',
      },
    };

    _razorpay.open(options);
  }

  
  void dispose() {
    _razorpay.clear();
  }
}
