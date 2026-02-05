import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/bank_account_shimmer.dart';
import 'package:invoicediscounting/src/components/shimmer/payment_method_shimmer.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/invest/neft_payment.dart'
    show PayOfflineScreen;
import 'package:invoicediscounting/src/modules/invest/payment_mode.dart';
import 'package:invoicediscounting/src/services/razorpay_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SelectPaymentMethod extends StatefulWidget {
  const SelectPaymentMethod({super.key});

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  final RazorpayService _razorpayService = RazorpayService();
  static const String razorpayKeyId = 'rzp_test_SC2UkYjivVaBh1';
  int selectedMethod = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });

    _razorpayService.init(
      onSuccess: _handleSuccess,
      onError: _handleError,
      onExternalWallet: _handleExternalWallet,
    );
  }

  void _handleSuccess(PaymentSuccessResponse response) {
    debugPrint('Payment Success: ${response.paymentId}');
  }

  void _handleError(PaymentFailureResponse response) {
    debugPrint('Payment Error: ${response.code} | ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('External Wallet: ${response.walletName}');
  }

  @override
  void dispose() {
    _razorpayService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Make a Payment',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: onboardingTitleColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              if (selectedMethod == 0) {
                _razorpayService.openCheckout(
                  amount: 50000,
                  keyId: razorpayKeyId,
                  appName: 'Birbal Plus',
                  description: 'Test Payment',
                  contact: '9999999999',
                  email: 'surajmorecombat@gmail.com.com',
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => PaymentMode()),
                // );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PayOfflineScreen()),
                );
              }
              //
            },
            child: Text(
              "Continue with Payment",
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: whiteColor),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 120 : 16,
          // vertical: 16,
        ),
        child: Column(
          children: [
            isLoading ? const BankAccountCardShimmer() : _bankAccountCard(),

            isLoading ? const PaymentMethodCardShimmer() : _paymentMethodCard(),
          ],
        ),
      ),
    );
  }

  Widget _bankAccountCard() {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance),
                SizedBox(width: 8),
                Text(
                  "Registered Bank Account",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Spacer(),
                Icon(Icons.edit, size: 18),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "HDFC Bank",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: blackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Expanded(
                  child: _bankInfo("Account holder name", "Combat Solution AI"),
                ),
                Expanded(child: _bankInfo("Account Number", "23216549875")),
              ],
            ),
            const SizedBox(height: 8),
            Text("IFSC", style: Theme.of(context).textTheme.bodySmall),
            Text(
              "HDFC0009999",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: blackColor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentMethodCard() {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Payment Method",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            _methodTile(
              index: 0,
              title: "UPI, Net Banking, Debit Card",
              tag: "Usually takes 24–48 hours for credit to pocket",
            ),
            const SizedBox(height: 12),
            _methodTile(
              index: 1,
              title: "IMPS, RTGS, NEFT",
              tag: "Typically takes 2–4 hours for credit to pocket",
            ),
          ],
        ),
      ),
    );
  }

  Widget _methodTile({
    required int index,
    required String title,
    required String tag,
  }) {
    final bool selected = selectedMethod == index;

    return GestureDetector(
      onTap: () => setState(() => selectedMethod = index),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? onboardingTitleColor : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: blackColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9F0FF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 11,
                        color: onboardingTitleColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Radio(
              value: index,
              groupValue: selectedMethod,
              activeColor: onboardingTitleColor,
              onChanged: (v) => setState(() => selectedMethod = v as int),
            ),
          ],
        ),
      ),
    );
  }
}

class _bankInfo extends StatelessWidget {
  final String title, value;
  const _bankInfo(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: blackColor,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
