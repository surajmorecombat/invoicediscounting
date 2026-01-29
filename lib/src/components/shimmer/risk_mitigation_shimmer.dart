import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class RiskMitigationCardShimmer extends StatelessWidget {
  const RiskMitigationCardShimmer({super.key});

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
                children: [
                  Expanded(
                    child: shimmerLine(width: 140, height: 16),
                  ),
                  shimmerSquare(size: 24),
                ],
              ),

              const SizedBox(height: 6),

              /// Subtitle
              shimmerLine(width: 260, height: 12),

              const SizedBox(height: 16),

              /// Risk rows (always expanded in shimmer)
              Row(
                children: const [
                  Expanded(child: _RiskItemShimmer()),
                  SizedBox(width: 12),
                  Expanded(child: _RiskItemShimmer()),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: const [
                  Expanded(child: _RiskItemShimmer()),
                  SizedBox(width: 12),
                  Expanded(child: _RiskItemShimmer()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _RiskItemShimmer extends StatelessWidget {
  const _RiskItemShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shimmerLine(width: 60, height: 16),
        const SizedBox(height: 6),
        Row(
          children: [
            shimmerLine(width: 100, height: 14),
            const SizedBox(width: 6),
            shimmerCircle(size: 16),
          ],
        ),
      ],
    );
  }
}
Widget shimmerLine({required double width, double height = 14}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

Widget shimmerSquare({double size = 14}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(3),
    ),
  );
}

Widget shimmerCircle({double size = 16}) {
  return Container(
    width: size,
    height: size,
    decoration: const BoxDecoration(
      color: Colors.grey,
      shape: BoxShape.circle,
    ),
  );
}
