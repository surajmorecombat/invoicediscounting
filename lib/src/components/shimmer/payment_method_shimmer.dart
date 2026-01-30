import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';


class PaymentMethodCardShimmer extends StatelessWidget {
  const PaymentMethodCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              shimmerLine(width: 180, height: 14),

              const SizedBox(height: 12),

              /// Method tiles
              const _PaymentMethodTileShimmer(),
              SizedBox(height: 12),
              _PaymentMethodTileShimmer(),
            ],
          ),
        ),
      ),
    );
  }
}


class _PaymentMethodTileShimmer extends StatelessWidget {
  const _PaymentMethodTileShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          /// Text section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerLine(width: 200, height: 14),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: shimmerLine(width: 160, height: 10),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          /// Radio placeholder
          shimmerCircle(size: 20),
        ],
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



Widget shimmerCircle({double size = 20}) {
  return Container(
    width: size,
    height: size,
    decoration: const BoxDecoration(
      color: Colors.grey,
      shape: BoxShape.circle,
    ),
  );
}
