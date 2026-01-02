import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/widrawl_success_card.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

class WalletCard extends StatefulWidget {
  const WalletCard({super.key});

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
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
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Wallet Balance', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 10),

          Text(
            '₹ 1,00,000 /-',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: successText,
            ),
          ),

          const SizedBox(height: 6),
          Text(
            'Add or Withdraw funds anytime',
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => BankDemeteDetails(),
                    //   ),
                    // );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: onboardingTitleColor,
                    //   side: BorderSide(color: onboardingTitleColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(0, 48),
                  ),
                  child: Text(
                    'Add',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: whiteColor),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widrawlCardOne();
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: onboardingTitleColor),
                    backgroundColor: whiteColor,
                    minimumSize: const Size(0, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Withdraw',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: onboardingTitleColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WithdrawalDialog extends StatelessWidget {
  const WithdrawalDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFEAEAEA),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Text(
              "Funds in Co. Pocket are managed by a SEBI Registered Trustee.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Withdrawal",
                  style: Theme.of(context).textTheme.displaySmall,
                ),

                const SizedBox(height: 12),
                TextField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Enter Amount',
                    border: InputBorder.none,
                  ),
                ),

                // const Text(
                //   "Enter Amount",
                //   style: TextStyle(fontWeight: FontWeight.w500),
                // ),
                // Container(height: 2, width: 100, color: Colors.black),
                const SizedBox(height: 18),

                Text(
                  "Credit to your bank account may take up to 48 hours",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 20),

                // Bank Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.account_balance),
                    SizedBox(width: 8),
                    Text(
                      "Registered Bank Account",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),

                const SizedBox(height: 6),
                Text(
                  "HDFC Bank",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _WField(
                      label: "Account Holder Name",
                      value: "Hrithik Vidhate",
                    ),
                    _WField(label: "Account Number", value: "0******7"),
                  ],
                ),

                const SizedBox(height: 14),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: _WField(label: "IFSC Code", value: "HDFC00002548"),
                ),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
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
                        MaterialPageRoute(
                          builder: (context) => WidrawalSuccessCard(),
                        ),
                      );
                    },
                    child: const Text("Proceed"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WField extends StatelessWidget {
  final String label;
  final String value;
  const _WField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
