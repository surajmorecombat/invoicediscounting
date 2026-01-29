import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/primary_card_shimmer.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class WalletSummaryCardShimmer extends StatelessWidget {
  const WalletSummaryCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Shimmer(
        duration: const Duration(milliseconds: 1400),
        interval: const Duration(milliseconds: 300),
        color: Colors.white,
        colorOpacity: 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            shimmerLine(width: 120, height: 14),

            const SizedBox(height: 10),

            /// Amount
            shimmerLine(width: 160, height: 28),

            const SizedBox(height: 6),

            /// Subtitle
            shimmerLine(width: 200, height: 14),

            const SizedBox(height: 18),

            /// Buttons row
            Row(
              children: const [
                Expanded(child: _WalletButtonShimmer()),
                SizedBox(width: 15),
                Expanded(child: _WalletButtonShimmer()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class _WalletButtonShimmer extends StatelessWidget {
  const _WalletButtonShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
