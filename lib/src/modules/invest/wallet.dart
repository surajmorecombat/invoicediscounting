import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/wallet_card.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/wallet/wallet_add.dart';

class AddToWallet extends StatefulWidget {
  const AddToWallet({super.key});

  @override
  State<AddToWallet> createState() => _AddToWalletState();
}

class _AddToWalletState extends State<AddToWallet> {
  bool addwallet = false;
  int selectedAmount = 000000;
  int unitCount = 1;
  bool isChecked = false;
  bool agree = false;
  int totalUnit = 30;
  int unitLeft = 23;
  int pricePerUnit = 100000;
  final TextEditingController amountController = TextEditingController();

  int get unitLeftNow => unitLeft + unitCount;
  int get totalAmount => unitCount * pricePerUnit;
  void widrawlCardOne() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder:
          (_) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              color: const Color(0xFF003A8F).withOpacity(.15),
              child: WithdrawalDialog(),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: blackColor),
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
            // onPressed: () {},
            onPressed: null,
            child: Text(
              'Continue with Payment',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 120 : 20,
            vertical: 16,
          ),
          child: Column(
            children: [
              unitCalculatorCard(context),

              secondaryCard(context),

              liquidityCard(context),

              coveredByCard(context),

              if (addwallet) lowBalanceCard(context),

              termsCheckbox(context, agree, (v) {
                setState(() => agree = v);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget secondaryCard(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 16),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Invested Value',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 10),
            Text(
              '₹1,03,561.64',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            buildRow(context, 'Unit Value', '₹1,00,000.00'),
            // buildRow(context, 'Coupon Rate', '12.5%'),
            // buildRow(context, 'Investment Value', '₹1,03,561.64'),
            // buildRow(context, 'Unit Price', '₹1,00,000.00'),
            buildRow(
              context,
              'Accrued Interest',
              '₹3,561.64',
              icon: Icons.info_outline,
            ),
            // buildRow(
            //   context,
            //   'Next Liquidity Event',
            //   '13/11/2025',
            //   icon: Icons.info_outline,
            // ),
            // buildRow(
            //   context,
            //   'Liquidity Event Amount',
            //   '₹1,04,589.98',
            //   icon: Icons.info_outline,
            // ),
            // buildRow(
            //   context,
            //   'Final Maturity Date',
            //   '08/01/2028',
            //   icon: Icons.info_outline,
            // ),
            // buildRow(
            //   context,
            //   'Exp. Maturity Amount',
            //   '₹1,36,708.72',
            //   highlight: true,
            // ),
          ],
        ),
      ),
    );
  }

  Widget liquidityCard(context) {
    return Card(
      elevation: 0.1,
      color: lightblue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 16),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow(
              context,
              'Next Liquidity Event',
              '13/11/2025',
              icon: Icons.info_outline,
            ),
            buildRow(
              context,
              'Liquidity Event Amount',
              '₹1,04,589.98',
              icon: Icons.info_outline,
            ),
            buildRow(
              context,
              'Final Maturity Date',
              '08/01/2028',
              icon: Icons.info_outline,
            ),
            buildRow(
              context,
              'Exp. Maturity Amount',
              '₹1,36,708.72',
              highlight: true,
              icon: Icons.info_outline,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(
    BuildContext context,
    String title,
    String value, {
    IconData? icon,
    bool highlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              if (icon != null) ...[
                const SizedBox(width: 6),
                Icon(icon, size: 14, color: Colors.grey),
              ],
            ],
          ),

          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: highlight ? Colors.green : blackColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget unitCalculatorCard(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("No. of Units", style: Theme.of(context).textTheme.bodyMedium),

            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _unitIconButton(Icons.remove, () {
                  setState(() {
                    unitCount--;
                    addwallet = true;
                  });
                }, enabled: unitCount > 1),

                const SizedBox(width: 50),

                Column(
                  children: [
                    Text(
                      unitCount.toString().padLeft(2, '0'),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text("Unit", style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),

                const SizedBox(width: 50),

                _unitIconButton(
                  Icons.add,
                  () {
                    setState(() {
                      unitCount++;
                      addwallet = true;
                    });
                  },
                  //  => setState(() => unitCount++),
                  enabled: unitCount < totalUnit,
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _quickUnitChip(5),
                const SizedBox(width: 10),
                _quickUnitChip(10),
                const SizedBox(width: 10),
                _quickUnitChip(20),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(),

            _valueRow("Unit Value", "₹1,00,000.00"),
            const SizedBox(height: 10),
            _valueRow("Coupon Rate", "12.5%"),
          ],
        ),
      ),
    );
  }

  Widget _unitIconButton(
    IconData icon,
    VoidCallback onTap, {
    required bool enabled,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: enabled ? onboardingTitleColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: enabled ? Colors.white : Colors.grey,
          size: 20,
        ),
      ),
    );
  }

  Widget _quickUnitChip(int value) {
    return GestureDetector(
      onTap: () => setState(() => unitCount = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              unitCount == value
                  ? onboardingTitleColor.withOpacity(.12)
                  : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          "$value Unit",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: unitCount == value ? onboardingTitleColor : Colors.black,
          ),

          // style: TextStyle(
          //   color: unitCount == value ? onboardingTitleColor : Colors.black,
          //   fontWeight: FontWeight.w500,
          // ),
        ),
      ),
    );
  }

  Widget _valueRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget coveredByCard(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            /// Left section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Covered by",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Image.asset("assets/images/birbal-full.png", height: 30),
                const SizedBox(width: 6),
              ],
            ),

            const Spacer(),

            /// Right section
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Text(
                    "View Details",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.chevron_right, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget lowBalanceCard(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bibalplus pocket",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "₹0.25",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "You don't have enough balance to purchase the selected units.\n"
                    "Please add funds to proceed.",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.red),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  // height: 38,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: onboardingTitleColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WalletAdd()),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text("Add Funds"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget termsCheckbox(
    BuildContext context,
    bool value,
    Function(bool) onChanged,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.scale(
          scale: 1.2,
          child: Checkbox(
            value: value,
            activeColor: onboardingTitleColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            onChanged: (val) => onChanged(val!),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                const TextSpan(text: "I agree to the "),
                TextSpan(
                  text: "Terms and Conditions",
                  style: const TextStyle(color: Colors.blue),
                ),
                const TextSpan(text: ", "),
                TextSpan(
                  text: "Terms of Use",
                  style: const TextStyle(color: Colors.blue),
                ),
                const TextSpan(text: " and have read and understood the "),
                TextSpan(
                  text: "Privacy Policy",
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
