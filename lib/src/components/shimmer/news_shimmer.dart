import 'package:flutter/material.dart';

import 'package:invoicediscounting/src/components/shimmer/payment_method_shimmer.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class MarketNewsDetailShimmer extends StatelessWidget {
  const MarketNewsDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(milliseconds: 1400),
      interval: const Duration(milliseconds: 300),
      color: whiteColor,
      colorOpacity: 0.7,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 190,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
            ),

            const SizedBox(height: 16),

            shimmerLine(width: double.infinity, height: 22),
            const SizedBox(height: 6),
            shimmerLine(width: 260, height: 22),

            const SizedBox(height: 12),

            _ParagraphShimmer(lines: 3),
            _ParagraphShimmer(lines: 2),

            const SizedBox(height: 16),

            shimmerLine(width: 220, height: 18),

            const SizedBox(height: 10),

            _BulletSectionShimmer(),
            _BulletSectionShimmer(),
            _BulletSectionShimmer(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _BulletSectionShimmer extends StatelessWidget {
  const _BulletSectionShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Bullet title
          shimmerLine(width: 260, height: 16),
          const SizedBox(height: 6),

          /// Bullet paragraph
          shimmerLine(width: double.infinity, height: 14),
          const SizedBox(height: 6),
          shimmerLine(width: 240, height: 14),
        ],
      ),
    );
  }
}

class _ParagraphShimmer extends StatelessWidget {
  final int lines;
  const _ParagraphShimmer({required this.lines});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(lines, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: shimmerLine(
            width: i == lines - 1 ? 220 : double.infinity,
            height: 14,
          ),
        );
      }),
    );
  }
}
