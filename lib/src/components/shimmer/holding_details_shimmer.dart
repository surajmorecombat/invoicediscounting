import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/primary_card_shimmer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class InvestedAmountCardShimmer extends StatelessWidget {
  const InvestedAmountCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(milliseconds: 1400),
      interval: const Duration(milliseconds: 300),
      color: Colors.white,
      colorOpacity: 0.7,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            shimmerLine(width: 160, height: 14),

            const SizedBox(height: 12),

            shimmerLine(width: 180, height: 22),

            const SizedBox(height: 18),

            shimmerLine(width: 220, height: 14),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  shimmerSquare(size: 14),
                  const SizedBox(width: 6),
                  shimmerLine(width: 80, height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class InvestmentDetailsCardShimmer extends StatelessWidget {
  const InvestmentDetailsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(milliseconds: 1400),
      interval: const Duration(milliseconds: 300),
      color: Colors.white,
      colorOpacity: 0.7,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            shimmerLine(width: 200, height: 18),

            const SizedBox(height: 22),

            /// Row 1
            const _DetailRowShimmer(),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(height: 1, thickness: 1),
            ),

            /// Row 2
            const _DetailRowShimmer(),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(height: 1, thickness: 1),
            ),

            /// Row 3
            const _DetailRowShimmer(),
          ],
        ),
      ),
    );
  }
}

class _DetailItemShimmer extends StatelessWidget {
  final bool alignRight;
  const _DetailItemShimmer({this.alignRight = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        shimmerLine(width: 90, height: 16),
        const SizedBox(height: 6),
        shimmerLine(width: 120, height: 12),
      ],
    );
  }
}

class _DetailRowShimmer extends StatelessWidget {
  const _DetailRowShimmer();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _DetailItemShimmer()),
        const SizedBox(width: 16),
        Expanded(child: _DetailItemShimmer(alignRight: true)),
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

class RepaymentDetailsCardShimmer extends StatelessWidget {
  const RepaymentDetailsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(milliseconds: 1400),
      interval: const Duration(milliseconds: 300),
      color: Colors.white,
      colorOpacity: 0.7,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            shimmerLine(width: 220, height: 18),

            const SizedBox(height: 22),

            /// Rows
            const _RepaymentRowShimmer(),
            const _RepaymentRowShimmer(),
            const _RepaymentRowShimmer(),
            const _RepaymentRowShimmer(),
          ],
        ),
      ),
    );
  }
}

class _RepaymentRowShimmer extends StatelessWidget {
  const _RepaymentRowShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          /// Left label (flex: 3)
          Expanded(
            flex: 3,
            child: shimmerLine(width: double.infinity, height: 12),
          ),

          const SizedBox(width: 12),

          /// Right value (flex: 2, right aligned)
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: shimmerLine(width: 110, height: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class PartiesCardShimmer extends StatelessWidget {
  const PartiesCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(milliseconds: 1400),
      interval: const Duration(milliseconds: 300),
      color: Colors.white,
      colorOpacity: 0.7,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            /// Header
            Row(
              children: [
                shimmerLine(width: 180, height: 18),
                const Spacer(),
                shimmerSquare(size: 20),
              ],
            ),

            const SizedBox(height: 16),

            /// Party row 1
            const _PartyRowShimmer(),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(height: 1, thickness: 1),
            ),

            /// Party row 2
            const _PartyRowShimmer(),
          ],
        ),
      ),
    );
  }
}

class _PartyRowShimmer extends StatelessWidget {
  const _PartyRowShimmer();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Left side
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 6),
            shimmerLine(width: 160, height: 14),
          ],
        ),

        /// Right role pill
        Container(
          width: 80,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ],
    );
  }
}


class DocumentCardShimmer extends StatelessWidget {
  const DocumentCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(milliseconds: 1400),
      interval: const Duration(milliseconds: 300),
      color: Colors.white,
      colorOpacity: 0.7,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            shimmerLine(width: 120, height: 14),

            const SizedBox(height: 6),

            /// Description
            shimmerLine(width: double.infinity, height: 12),
            const SizedBox(height: 4),
            shimmerLine(width: 220, height: 12),

            const SizedBox(height: 14),

            /// Chips row
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
    );
  }
}
class _DocChipShimmer extends StatelessWidget {
  const _DocChipShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          shimmerSquare(size: 16),
          const SizedBox(width: 6),
          shimmerLine(width: 50, height: 12),
        ],
      ),
    );
  }
}
