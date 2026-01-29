import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/primary_card_shimmer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BankAccountCardShimmer extends StatelessWidget {
  const BankAccountCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Shimmer(
        duration: const Duration(milliseconds: 1400),
        interval: const Duration(milliseconds: 300),
        color: Colors.white,
        colorOpacity: 0.7,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header row
              Row(
                children: [
                  shimmerSquare(size: 20),
                  const SizedBox(width: 8),
                  shimmerLine(width: 180, height: 14),
                  const Spacer(),
                  shimmerSquare(size: 18),
                ],
              ),

              const SizedBox(height: 12),

              /// Bank name
              shimmerLine(width: 120, height: 14),

              const SizedBox(height: 10),

              /// Account info row
              Row(
                children: const [
                  Expanded(child: _BankInfoShimmer()),
                  Expanded(child: _BankInfoShimmer()),
                ],
              ),

              const SizedBox(height: 8),

              /// IFSC
              shimmerLine(width: 40, height: 12),
              const SizedBox(height: 4),
              shimmerLine(width: 120, height: 14),
            ],
          ),
        ),
      ),
    );
  }
}
class _BankInfoShimmer extends StatelessWidget {
  const _BankInfoShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shimmerLine(width: 100, height: 12),
        const SizedBox(height: 4),
        shimmerLine(width: 140, height: 14),
      ],
    );
  }
}
