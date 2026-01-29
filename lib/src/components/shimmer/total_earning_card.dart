import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TotalEarningCardShimmer extends StatelessWidget {
  const TotalEarningCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            // Header row
            Row(
              children: [
                _line(width: 140, height: 20),
                const Spacer(),
                _chartPlaceholder(),
              ],
            ),

            const SizedBox(height: 14),

            // Total earning value
            _line(width: 180, height: 28),

            const SizedBox(height: 24),

            // Value blocks
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [_ValueBlockShimmer(), _ValueBlockShimmer()],
            ),

            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade300),

            const SizedBox(height: 10),

            // Returns row
            Row(children: [_line(width: 70), const Spacer(), _line(width: 60)]),
          ],
        ),
      ),
    );
  }

  Widget _line({required double width, double height = 14}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _chartPlaceholder() {
    return Container(
      width: 70,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class _ValueBlockShimmer extends StatelessWidget {
  const _ValueBlockShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 90,
          height: 14,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 110,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
