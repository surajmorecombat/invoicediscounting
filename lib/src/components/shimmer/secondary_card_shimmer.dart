import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/primary_card_shimmer.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class SecondaryCardShimmer extends StatelessWidget {
  const SecondaryCardShimmer({super.key});

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
              /// Header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  shimmerLine(width: 120, height: 14),
                  shimmerLine(width: 100, height: 16),
                ],
              ),

              const SizedBox(height: 10),

              /// Rows
              const _MetricRowShimmer(),
              const _MetricRowShimmer(),
            ],
          ),
        ),
      ),
    );
  }
}
class LiquidityCardShimmer extends StatelessWidget {
  const LiquidityCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: lightblue,
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
            children: const [
              _MetricRowShimmer(),
              _MetricRowShimmer(),
              _MetricRowShimmer(),
              _MetricRowShimmer(highlight: true),
            ],
          ),
        ),
      ),
    );
  }
}
class _MetricRowShimmer extends StatelessWidget {
  final bool highlight;
  const _MetricRowShimmer({this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Left label (+ icon space)
          Row(
            children: [
              shimmerLine(width: 140, height: 14),
              const SizedBox(width: 6),
              shimmerSquare(size: 16),
            ],
          ),

          /// Right value
          shimmerLine(
            width: highlight ? 110 : 90,
            height: 14,
          ),
        ],
      ),
    );
  }
}
