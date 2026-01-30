
import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/banK_details_shimmer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HelpCenterShimmer extends StatelessWidget {
  const HelpCenterShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer(
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
                
              ],
            ),
          ),
        ),
      ],
    );
  }
}
