import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/payment_method_shimmer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Shimmer(
      duration: const Duration(milliseconds: 1400),
      interval: const Duration(milliseconds: 300),
      color: Colors.white,
      colorOpacity: 0.7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
              child: Column(
                children: [
                  const _ProfileHeaderShimmer(),
                  const SizedBox(height: 15),
                  const _ProfileMenuShimmer(),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const _SupportCardShimmer(),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeaderShimmer extends StatelessWidget {
  const _ProfileHeaderShimmer();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            shimmerCircle(size: 68),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerLine(width: 160, height: 14),
                const SizedBox(height: 6),
                shimmerLine(width: 120, height: 12),
                const SizedBox(height: 6),
                shimmerLine(width: 180, height: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuShimmer extends StatelessWidget {
  const _ProfileMenuShimmer();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: const [
          _MenuItemShimmer(),
          _MenuItemShimmer(),
          _MenuItemShimmer(),
          _MenuItemShimmer(),
          _MenuItemShimmer(),
          _MenuItemShimmer(),
        ],
      ),
    );
  }
}

class _MenuItemShimmer extends StatelessWidget {
  const _MenuItemShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          shimmerSquare(size: 22),
          const SizedBox(width: 16),
          Expanded(child: shimmerLine(width: double.infinity, height: 14)),
          const SizedBox(width: 16),
          shimmerSquare(size: 18),
        ],
      ),
    );
  }
}

class _SupportCardShimmer extends StatelessWidget {
  const _SupportCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            shimmerCircle(size: 40),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerLine(width: 160, height: 12),
                  const SizedBox(height: 6),
                  shimmerLine(width: 120, height: 14),
                  const SizedBox(height: 6),
                  shimmerLine(width: 200, height: 12),
                ],
              ),
            ),

            const SizedBox(width: 10),
            shimmerSquare(size: 24),
            const SizedBox(width: 6),
            shimmerSquare(size: 24),
            const SizedBox(width: 6),
            shimmerSquare(size: 24),
          ],
        ),
      ),
    );
  }
}
// Widget shimmerLine({required double width, double height = 14}) {
//   return Container(
//     width: width == double.infinity ? null : width,
//     height: height,
//     decoration: BoxDecoration(
//       color: Colors.grey.shade300,
//       borderRadius: BorderRadius.circular(4),
//     ),
//   );
// }

// Widget shimmerCircle({double size = 40}) {
//   return Container(
//     width: size,
//     height: size,
//     decoration: const BoxDecoration(
//       color: Colors.grey,
//       shape: BoxShape.circle,
//     ),
//   );
// }

Widget shimmerSquare({double size = 20}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(4),
    ),
  );
}
