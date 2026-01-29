import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/primary_card_shimmer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PayOfflineScreenShimmer extends StatelessWidget {
  final bool isTablet;
  const PayOfflineScreenShimmer({super.key, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
      child: Shimmer(
        duration: const Duration(milliseconds: 1400),
        interval: const Duration(milliseconds: 300),
        color: Colors.white,
        colorOpacity: 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Amount
            shimmerLine(width: 120, height: 26),
            const SizedBox(height: 6),
            shimmerLine(width: 140, height: 14),

            const SizedBox(height: 24),

            /// Section title
            shimmerLine(width: 160, height: 16),
            const SizedBox(height: 8),
            shimmerLine(width: 300, height: 14),

            const SizedBox(height: 16),

            /// Account detail cards
            const _DetailCardShimmer(),
            _DetailCardShimmer(),
            _DetailCardShimmer(),
            _DetailCardShimmer(),
            _DetailCardShimmer(),

            const SizedBox(height: 16),

            /// Info box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerLine(width: double.infinity, height: 12),
                  const SizedBox(height: 6),
                  shimmerLine(width: 260, height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _DetailCardShimmer extends StatelessWidget {
  const _DetailCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shimmerLine(width: 160, height: 14),
          const SizedBox(height: 6),
          shimmerLine(width: 220, height: 16),
        ],
      ),
    );
  }
}
