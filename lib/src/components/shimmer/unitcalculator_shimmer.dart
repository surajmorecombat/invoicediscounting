import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/primary_card_shimmer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class UnitCalculatorCardShimmer extends StatelessWidget {
  const UnitCalculatorCardShimmer({super.key});

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
              /// Title
              shimmerLine(width: 100, height: 14),

              const SizedBox(height: 14),

              /// Center unit selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  shimmerSquare(size: 40), // minus button

                  const SizedBox(width: 50),

                  Column(
                    children: [
                      shimmerLine(width: 60, height: 28), // unit value
                      const SizedBox(height: 6),
                      shimmerLine(width: 30, height: 12), // "Unit"
                    ],
                  ),

                  const SizedBox(width: 50),

                  shimmerSquare(size: 40), // plus button
                ],
              ),

              const SizedBox(height: 16),

              /// Quick unit chips
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _UnitChipShimmer(),
                  SizedBox(width: 10),
                  _UnitChipShimmer(),
                  SizedBox(width: 10),
                  _UnitChipShimmer(),
                ],
              ),

              const SizedBox(height: 20),
              const Divider(),

              /// Value rows
              _ValueRowShimmer(),
              const SizedBox(height: 10),
              _ValueRowShimmer(),
            ],
          ),
        ),
      ),
    );
  }
}
class _UnitChipShimmer extends StatelessWidget {
  const _UnitChipShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: shimmerLine(width: 50, height: 14),
    );
  }
}
class _ValueRowShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        shimmerLine(width: 90, height: 14),
        shimmerLine(width: 80, height: 16),
      ],
    );
  }
}
