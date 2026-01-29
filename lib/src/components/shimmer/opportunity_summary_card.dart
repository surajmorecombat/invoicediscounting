import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/primary_card_shimmer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class OpportunitySummaryCardShimmer extends StatelessWidget {
  const OpportunitySummaryCardShimmer({super.key});

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
                  Expanded(child: shimmerLine(width: 180, height: 16)),
                  shimmerSquare(size: 24),
                ],
              ),

              const SizedBox(height: 6),

              /// Subtitle
              shimmerLine(width: double.infinity, height: 12),
              const SizedBox(height: 4),
              shimmerLine(width: 260, height: 12),

              const SizedBox(height: 16),

              /// Sections (fixed count to match real UI)
              const _OpportunitySectionShimmer(),
              SizedBox(height: 16),
              _OpportunitySectionShimmer(),
              SizedBox(height: 16),
              _OpportunitySectionShimmer(),
              SizedBox(height: 16),
              _OpportunitySectionShimmer(),
            ],
          ),
        ),
      ),
    );
  }
}
class _OpportunitySectionShimmer extends StatelessWidget {
  const _OpportunitySectionShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        shimmerLine(width: 140, height: 14),

        const SizedBox(height: 6),

        // Description (3–4 lines)
        shimmerLine(width: double.infinity, height: 12),
        const SizedBox(height: 4),
        shimmerLine(width: double.infinity, height: 12),
        const SizedBox(height: 4),
        shimmerLine(width: 220, height: 12),
      ],
    );
  }
}
