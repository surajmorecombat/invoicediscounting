import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/primary_card_shimmer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TransactionListShimmer extends StatelessWidget {
  const TransactionListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TransactionTopBarShimmer(),
        const SizedBox(height: 16),

        Expanded(
          child: ListView.builder(
            itemCount: 8,
            itemBuilder: (_, __) => const TransactionTileShimmer(),
          ),
        ),
      ],
    );
  }
}

class _TransactionTopBarShimmer extends StatelessWidget {
  const _TransactionTopBarShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(milliseconds: 1400),
      interval: const Duration(milliseconds: 300),
      color: Colors.white,
      colorOpacity: 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shimmerLine(width: 140, height: 16),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _FilterChipShimmer(width: 70),
              _FilterChipShimmer(width: 70),
              _FilterChipShimmer(width: 70),
              _FilterChipShimmer(width: 70),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterChipShimmer extends StatelessWidget {
  final double width;
  const _FilterChipShimmer({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: shimmerLine(width: width, height: 12),
    );
  }
}

class TransactionTileShimmer extends StatelessWidget {
  const TransactionTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Shimmer(
        duration: const Duration(milliseconds: 1400),
        interval: const Duration(milliseconds: 300),
        color: Colors.white,
        colorOpacity: 0.7,
        child: Row(
          children: [
            /// Left text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerLine(width: 180, height: 14),
                  const SizedBox(height: 4),
                  shimmerLine(width: 120, height: 12),
                ],
              ),
            ),

            /// Amount column
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                shimmerLine(width: 80, height: 14),
                const SizedBox(height: 4),
                shimmerLine(width: 40, height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
