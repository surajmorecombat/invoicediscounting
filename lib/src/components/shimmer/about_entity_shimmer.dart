import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/primary_card_shimmer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class AboutEntitiesCardShimmer extends StatelessWidget {
  const AboutEntitiesCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 16),
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
              /// Header
              Row(
                children: [
                  Expanded(child: shimmerLine(width: 220, height: 16)),
                  shimmerSquare(size: 24),
                ],
              ),

              const SizedBox(height: 16),

              /// FAQ blocks (fixed count)
              const _FaqItemShimmer(),
              SizedBox(height: 16),
              _FaqItemShimmer(),
              SizedBox(height: 16),
              _FaqItemShimmer(),
            ],
          ),
        ),
      ),
    );
  }
}
class _FaqItemShimmer extends StatelessWidget {
  const _FaqItemShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Question row
        Row(
          children: [
            Expanded(child: shimmerLine(width: double.infinity, height: 14)),
            const SizedBox(width: 8),
            shimmerSquare(size: 20),
          ],
        ),

        const SizedBox(height: 8),

        /// Answer (multi-line)
        shimmerLine(width: double.infinity, height: 12),
        const SizedBox(height: 4),
        shimmerLine(width: double.infinity, height: 12),
        const SizedBox(height: 4),
        shimmerLine(width: 240, height: 12),
      ],
    );
  }
}
