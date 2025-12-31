import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/invest/wallet_success_card.dart';

enum PaymentMethod { upi, netBanking }

class PaymentMode extends StatefulWidget {
  const PaymentMode({super.key});

  @override
  State<PaymentMode> createState() => _PaymentModeState();
}

class _PaymentModeState extends State<PaymentMode> {
  PaymentMethod? selectedMethod;

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Deposite to ABC Pocket',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: Offset(0, -4),
                color: Colors.black12,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Total Amount",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "₹1,00,000",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: onboardingTitleColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletSuccessCard()));
                  },
                  child: Text(
                    "Continue with Payment",
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 120 : 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: DropdownMenu<PaymentMethod>(
                requestFocusOnTap: true,
                inputDecorationTheme: InputDecorationTheme(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: InputBorder.none,
                ),
                enableSearch: false,
                expandedInsets: EdgeInsets.zero,
                hintText: "Select Payment Mode",
                textStyle: Theme.of(context).textTheme.bodyLarge,

                dropdownMenuEntries: [
                  DropdownMenuEntry(
                    value: PaymentMethod.upi,
                    label: "UPI",
                    labelWidget: Text(
                      'UPI',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  DropdownMenuEntry<PaymentMethod>(
                    value: PaymentMethod.netBanking,
                    label: "Net Banking",
                    labelWidget: Text(
                      "Net Banking",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
                onSelected: (value) {
                  setState(() => selectedMethod = value);
                },
              ),
            ),

            const SizedBox(height: 16),
            if (selectedMethod == PaymentMethod.upi)
              paymentTile(
                method: PaymentMethod.upi,
                title: "UPI ID",
                child: Column(
                  children: [
                    TextField(
                      // controller: controller,
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: InputDecoration(
                        // labelText: label,
                        hintText: "yourname@upi",
                        labelStyle: const TextStyle(color: Colors.grey),

                        floatingLabelStyle: TextStyle(
                          color: onboardingTitleColor,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: onboardingTitleColor,
                            width: 1.6,
                          ),
                        ),
                      ),
                    ),
                    // TextField(
                    //   style:  Theme.of(context).textTheme.bodyMedium?.copyWith(color: blackColor),
                    //   decoration: InputDecoration(
                    //     hintText: "yourname@upi",
                    //     hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: blackColor),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Secured by',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(width: 5),
                        Image.asset(
                          'assets/icons/juspay.png',
                          width: 10,
                          height: 10,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'JUSPAY',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    // const Text(
                    //   "Secured by JUSPAY",
                    //   style: TextStyle(fontSize: 11),
                    // ),
                  ],
                ),
              ),
            if (selectedMethod == PaymentMethod.netBanking)
              paymentTile(
                method: PaymentMethod.netBanking,
                title: "Net Banking",
              ),
          ],
        ),
      ),
    );
  }

  Widget paymentTile({
    required PaymentMethod method,
    required String title,
    Widget? child,
  }) {
    final bool isSelected = selectedMethod == method;
    return Column(
      children: [
        ListTile(
          // contentPadding: EdgeInsets.zero,
          title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          trailing: Radio<PaymentMethod>(
            activeColor: onboardingTitleColor,
            value: method,
            groupValue: selectedMethod,
            onChanged: (value) {
              setState(() {
                selectedMethod = value;
              });
            },
          ),
        ),

        if (isSelected)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: child,
          ),
      ],
    );
  }
}
