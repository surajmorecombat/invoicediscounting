import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/primary_card_shimmer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class WalletBalanceCardShimmer extends StatelessWidget {
  final bool isTablet;
  const WalletBalanceCardShimmer({super.key, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
      child: Card(
        elevation: 0.1,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Shimmer(
          duration: const Duration(milliseconds: 1400),
          interval: const Duration(milliseconds: 300),
          color: Colors.white,
          colorOpacity: 0.7,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Title
                shimmerLine(width: 140, height: 18),

                const SizedBox(height: 16),

                /// Amount input placeholder
                Padding(
                  padding: const EdgeInsets.only(left: 80, right: 80),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: shimmerLine(width: 120, height: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Amount chips
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _AmountChipShimmer(),
                    _AmountChipShimmer(),
                    _AmountChipShimmer(),
                  ],
                ),

                const SizedBox(height: 20),

                /// Info text (2 lines)
                shimmerLine(width: double.infinity, height: 12),
                const SizedBox(height: 6),
                shimmerLine(width: 260, height: 12),

                const SizedBox(height: 24),
                const Divider(),

                /// Balance rows
                const _BalanceRowShimmer(),
                _BalanceRowShimmer(),
                _BalanceRowShimmer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _AmountChipShimmer extends StatelessWidget {
  const _AmountChipShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(24),
      ),
      child: shimmerLine(width: 50, height: 14),
    );
  }
}
class _BalanceRowShimmer extends StatelessWidget {
  const _BalanceRowShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          shimmerLine(width: 120, height: 12),
          shimmerLine(width: 60, height: 12),
        ],
      ),
    );
  }
}
