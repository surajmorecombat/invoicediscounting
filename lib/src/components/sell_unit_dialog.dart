import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/wallet_card.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/activity/trainsation_all.dart';

class SellUnitDialog extends StatefulWidget {
  const SellUnitDialog({super.key});

  @override
  State<SellUnitDialog> createState() => _SellUnitDialogState();
}

class _SellUnitDialogState extends State<SellUnitDialog> {
  void _openConfirmDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder:
          (_) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              color: const Color(0xFF003A8F).withOpacity(.15),
              child: const ConfirmSellDialog(),
            ),
          ),
      //  ConfirmSellDialog()
    );
  }

  int units = 1;
  bool agree = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sell Your Units",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(
                "Available Units : 1",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Select No Units",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: blackColor,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        if (units > 1) setState(() => units--);
                      },
                      icon: const Icon(Icons.remove, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  units.toString().padLeft(2, '0'),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(width: 20),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: blackColor,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () => setState(() => units++),
                      icon: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Expected Repayment Amount",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Text(
              "₹1,02045.25",
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(color: Colors.green),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  activeColor: onboardingTitleColor,
                  value: agree,
                  onChanged: (v) => setState(() => agree = v!),
                ),
                const Expanded(
                  child: Text("I agree to the Terms of Use and Privacy Policy"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              // height: 48,
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003A8F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed:
                    agree
                        ? () {
                          Navigator.pop(context);
                          _openConfirmDialog();
                        }
                        : null,
                child: Text(
                  "Continue",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmSellDialog extends StatefulWidget {
  const ConfirmSellDialog({super.key});

  @override
  State<ConfirmSellDialog> createState() => _ConfirmSellDialogState();
}

class _ConfirmSellDialogState extends State<ConfirmSellDialog> {
  @override
  Widget build(BuildContext context) {
    void openSuccessDialog() {
      showDialog(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder:
            (_) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                color: const Color(0xFF003A8F).withOpacity(.15),
                child: const SuccessDialog(),
              ),
            ),
      );
    }

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
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

            const SizedBox(height: 4),

            Text(
              "Confirm Your Sell Order",
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Available Units: 1",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            const SizedBox(height: 20),

            Text("No. of Units", style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 6),
            Text("01", style: Theme.of(context).textTheme.headlineLarge),

            const Divider(height: 32),

            Row(
              children: const [
                Expanded(
                  child: _Detail(
                    label: "Repayment Amount",
                    value: "₹101,012.25",
                  ),
                ),
                Expanded(child: _Detail(label: "Stamp Duty", value: "₹15.15")),
              ],
            ),

            const SizedBox(height: 12),

            const Align(
              alignment: Alignment.centerLeft,
              child: _Detail(
                label: "Consideration Amount",
                value: "₹100,000.00",
              ),
            ),

            const SizedBox(height: 18),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFF6F7F8),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Note:',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' You will receive the payment in your ABC Pocket.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              // Text(
              //   "Note:  You will receive the payment in your ABC Pocket.",
              //   textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyMedium,
              // ),
            ),

            const SizedBox(height: 22),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: onboardingTitleColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003A8F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      openSuccessDialog();
                    },
                    child: Text(
                      "Confirm & Sell",
                      style: Theme.of(context).textTheme.labelLarge,
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
}

class _Detail extends StatelessWidget {
  final String label;
  final String value;
  const _Detail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close),
              ),
            ),

            const SizedBox(height: 4),

            Text(
              "Sell Request Received",
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            const SizedBox(height: 22),

            Icon(Icons.copy, size: 56, color: onboardingTitleColor),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You've successfully Sold ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "01 unit",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.green),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Text(
              "The amount will be credited to your Amplio Pocket shortly.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 6),
            Text(
              "Your transaction is being processed securely.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),

            const SizedBox(height: 22),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003A8F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TrainsationAll()),
                    ),
                child: Text(
                  "Okay",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
