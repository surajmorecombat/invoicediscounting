import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PrimaryCardShimmer extends StatelessWidget {
  const PrimaryCardShimmer({super.key});

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
        child: Column(
          children: [
            /// Buyer / Seller
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buyerSellerShimmer(),
            ),

            /// RBI strip
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              color: Colors.grey.shade200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  shimmerSquare(size: 15),
                  const SizedBox(width: 6),
                  shimmerLine(width: 100),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ALL rows (exact count & order)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: const [
                  _PrimaryRowShimmer(),                 // Minimum Investment
                  _PrimaryRowShimmer(highlight: true),  // XIRR
                  _PrimaryRowShimmer(highlight: true),  // Coupon Rate
                  _PrimaryRowShimmer(),                 // Unit Left
                  _PrimaryRowShimmer(),                 // Tenure
                  _PrimaryRowShimmer(),                 // Type of Interest
                  _PrimaryRowShimmer(),                 // Recourse
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buyerSellerShimmer() {
  return Row(
    children: [
      shimmerCircle(size: 44),
      const SizedBox(width: 8),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shimmerLine(width: 90, height: 16),
            const SizedBox(height: 6),
            shimmerLine(width: 50, height: 14),
          ],
        ),
      ),

      const SizedBox(width: 8),
      shimmerSquare(size: 30),
      const SizedBox(width: 8),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            shimmerLine(width: 90, height: 16),
            const SizedBox(height: 6),
            shimmerLine(width: 50, height: 14),
          ],
        ),
      ),

      const SizedBox(width: 8),
      shimmerCircle(size: 44),
    ],
  );
}

}
class _PrimaryRowShimmer extends StatelessWidget {
  final bool highlight;
  const _PrimaryRowShimmer({this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          shimmerLine(width: 140),

          // Value
          shimmerLine(
            width: highlight ? 60 : 90,
            height: 16,
          ),
        ],
      ),
    );
  }
}


// class _KeyValueRowShimmer extends StatelessWidget {
//   final bool highlight;
//   const _KeyValueRowShimmer({this.highlight = false});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           shimmerLine(width: 140),
//           Row(
//             children: [
//               shimmerLine(width: highlight ? 60 : 80, height: 16),
//               if (highlight) ...[
//                 const SizedBox(width: 6),
//                 shimmerSquare(size: 14),
//               ],
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

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
    decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
  );
}

Widget shimmerSquare({double size = 14}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(3),
    ),
  );
}
