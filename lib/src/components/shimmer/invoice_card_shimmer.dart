import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class InvoiceCardShimmer extends StatelessWidget {
  const InvoiceCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Shimmer(
          duration: const Duration(milliseconds: 1500),
          interval: const Duration(milliseconds: 300),
          color: Colors.white,
          colorOpacity: 0.7,
          enabled: true,
          direction: const ShimmerDirection.fromLTRB(),
          child: Column(
            children: [
              Row(
                children: [
                  _circle(),
                  const SizedBox(width: 10),
                  _line(width: 100),
                  const Spacer(),
                  _line(width: 60),
                  const SizedBox(width: 10),
                  _circle(),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (_) => _line(width: 60, height: 14)),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _line(width: 80),
                  _line(width: 110, height: 36, radius: 18),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _line({
    double width = double.infinity,
    double height = 12,
    double radius = 4,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget _circle() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}

class TopBarShimmer extends StatelessWidget {
  const TopBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Shimmer(
          duration: const Duration(milliseconds: 1500),
          interval: const Duration(milliseconds: 300),
          color: Colors.white,
          colorOpacity: 0.7,
          enabled: true,
          direction: const ShimmerDirection.fromLTRB(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _line(width: 180, height: 18),

              const SizedBox(height: 14),

              Row(
                children: [
                  _pill(width: 90),
                  const SizedBox(width: 8),
                  _pill(width: 90),
                  const SizedBox(width: 8),
                  _pill(width: 90),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _line({required double width, double height = 14}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _pill({required double width}) {
    return Container(
      width: width,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
