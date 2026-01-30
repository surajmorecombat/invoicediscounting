import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BankDetailsFormShimmer extends StatelessWidget {
  const BankDetailsFormShimmer({super.key});

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
            const SizedBox(height: 10),

            const InputFieldShimmer(),
            const SizedBox(height: 15),

            const InputFieldShimmer(),
            const SizedBox(height: 15),

            const InputFieldShimmer(),
            const SizedBox(height: 15),

            const InputFieldShimmer(),
            const SizedBox(height: 15),

            const ButtonShimmer(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
class InputFieldShimmer extends StatelessWidget {
  const InputFieldShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // /// Label
          // shimmerLine(width: 120, height: 12),
          // const SizedBox(height: 6),

          /// Input box
          Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
class ButtonShimmer extends StatelessWidget {
  const ButtonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

