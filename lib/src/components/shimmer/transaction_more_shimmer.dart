import 'package:flutter/material.dart';

import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TransactionMoreShimmer extends StatelessWidget {
  const TransactionMoreShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
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
            Row(
              children: [
                _line(width: 120, height: 18),
                const Spacer(),
                _square(size: 20),
              ],
            ),
            const SizedBox(height: 20),

            _line(width: 90),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_line(width: 160), _line(width: 80)],
            ),

            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade300),

            const SizedBox(height: 10),
            Align(alignment: Alignment.centerRight, child: _line(width: 60)),
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

  Widget _square({double size = 120}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
