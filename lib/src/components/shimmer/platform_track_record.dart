import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/primary_card_shimmer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PlatformTrackRecordCardShimmer extends StatelessWidget {
  const PlatformTrackRecordCardShimmer({super.key});

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

              /// Metrics row
              Row(
                children: [
                  _TrackMetricShimmer(),
                  const Spacer(),
                  _TrackMetricShimmer(alignRight: true),
                ],
              ),

              const SizedBox(height: 14),

              /// Percentage
              shimmerLine(width: 60, height: 18),
              const SizedBox(height: 6),
              shimmerLine(width: 140, height: 14),

              const SizedBox(height: 20),

              /// Documents section
              shimmerLine(width: 90, height: 14),
              const SizedBox(height: 4),
              shimmerLine(width: 260, height: 12),

              const SizedBox(height: 12),

              /// Document chips
              Row(
                children: const [
                  _DocChipShimmer(),
                  SizedBox(width: 10),
                  _DocChipShimmer(),
                  SizedBox(width: 10),
                  _DocChipShimmer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _TrackMetricShimmer extends StatelessWidget {
  final bool alignRight;
  const _TrackMetricShimmer({this.alignRight = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        shimmerLine(width: 60, height: 16),
        const SizedBox(height: 4),
        shimmerLine(width: 80, height: 12),
      ],
    );
  }
}
class _DocChipShimmer extends StatelessWidget {
  const _DocChipShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          shimmerSquare(size: 16),
          const SizedBox(width: 6),
          shimmerLine(width: 50, height: 14),
        ],
      ),
    );
  }
}
