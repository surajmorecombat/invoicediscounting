import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/invest/payment_mode.dart';

class SelectPaymentMethod extends StatefulWidget {
  const SelectPaymentMethod({super.key});

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  int selectedMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: 
      Container(
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentMode()));
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _bankAccountCard(),
            const SizedBox(height: 16),
            _paymentMethodCard(),
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
            Text("HDFC Bank", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: blackColor, fontWeight: FontWeight.w500)),
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
             Text(
              "IFSC",
               style: Theme.of(
                context,
              ).textTheme.bodySmall
            ),
             Text("HDFC0009999", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: blackColor, fontWeight: FontWeight.normal)),
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
             style: Theme.of(context).textTheme.bodyMedium
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
            color: selected ? onboardingTitleColor: Colors.grey.shade300,
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
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: blackColor, fontWeight: FontWeight.normal)
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
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF003A8F),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Radio(
              value: index,
              groupValue: selectedMethod,
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
        Text(value,  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: blackColor, fontWeight: FontWeight.normal)),
      ],
    );
  }
}
