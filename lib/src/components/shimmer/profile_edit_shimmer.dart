import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ProfileEditShimmer extends StatelessWidget {
  const ProfileEditShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(milliseconds: 1400),
      interval: const Duration(milliseconds: 300),
      color: Colors.white,
      colorOpacity: 0.7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Avatar
            const _ProfileAvatarShimmer(),

            const SizedBox(height: 25),

            /// Form fields
            const _InputFieldShimmer(),
            const SizedBox(height: 15),

            const _InputFieldShimmer(),
            const SizedBox(height: 15),

            const _InputFieldShimmer(),
            const SizedBox(height: 15),

            const _InputFieldShimmer(),
            const SizedBox(height: 20),

            /// Update button
            const _ButtonShimmer(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
class _ProfileAvatarShimmer extends StatelessWidget {
  const _ProfileAvatarShimmer();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        shimmerCircle(size: 100),
        Container(
          margin: const EdgeInsets.only(right: 4, bottom: 4),
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
class _InputFieldShimmer extends StatelessWidget {
  const _InputFieldShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shimmerLine(width: 90, height: 12),
        const SizedBox(height: 6),
        Container(
          height: 56,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}
class _ButtonShimmer extends StatelessWidget {
  const _ButtonShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
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

Widget shimmerCircle({double size = 40}) {
  return Container(
    width: size,
    height: size,
    decoration: const BoxDecoration(
      color: Colors.grey,
      shape: BoxShape.circle,
    ),
  );
}
