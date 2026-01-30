

import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class InvestAppBarShimmer extends StatelessWidget
    implements PreferredSizeWidget {
  const InvestAppBarShimmer({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Shimmer(
        duration: const Duration(milliseconds: 1400),
        interval: const Duration(milliseconds: 300),
        color: Colors.white,
        colorOpacity: 0.7,
        enabled: true,
        child: Row(
          children: [
            const SizedBox(width: 12),
            _circle(size: 40),
            const Spacer(),
            _pill(width: 110, height: 32),
            const SizedBox(width: 12),
            _square(size: 20),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  Widget _circle({double size = 40}) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _pill({required double width, double height = 32}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _square({double size = 20}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
