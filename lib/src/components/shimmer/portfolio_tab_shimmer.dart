import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PortfolioTabShimmer extends StatelessWidget {
  const PortfolioTabShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: const [
        _ActiveInvestmentTabShimmer(),
        _ClosedInvestmentTabShimmer(),
      ],
    );
  }
}



class _ActiveInvestmentTabShimmer extends StatelessWidget {
  const _ActiveInvestmentTabShimmer();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer(
        duration: const Duration(milliseconds: 1400),
        interval: const Duration(milliseconds: 300),
        color: Colors.white,
        colorOpacity: 0.7,
        child: Column(
          children: [
            _activeInvestmentCardShimmer(),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (_, __) => const _HoldingCardShimmer(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _activeInvestmentCardShimmer() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: _pill(width: 160, height: 28),
          ),
          const SizedBox(height: 16),

          _line(width: 140, height: 22),
          const SizedBox(height: 8),
          _line(width: 90),

          const Divider(height: 30),

          _line(width: 140, height: 22),
          const SizedBox(height: 8),
          _line(width: 160),
        ],
      ),
    ),
  );
}
class _ClosedInvestmentTabShimmer extends StatelessWidget {
  const _ClosedInvestmentTabShimmer();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer(
        duration: const Duration(milliseconds: 1400),
        interval: const Duration(milliseconds: 300),
        color: Colors.white,
        colorOpacity: 0.7,
        child: Align(
          alignment: Alignment.topCenter,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: _pill(width: 160, height: 28),
                  ),
                  const SizedBox(height: 16),

                  _line(width: 140, height: 22),
                  const SizedBox(height: 8),
                  _line(width: 90),

                  const Divider(height: 30),

                  _line(width: 60),
                  const SizedBox(height: 8),
                  _line(width: 120),

                  const SizedBox(height: 14),

                  _line(width: 60),
                  const SizedBox(height: 8),
                  _line(width: 120),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class _HoldingCardShimmer extends StatelessWidget {
  const _HoldingCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _circle(size: 44),
                const SizedBox(width: 12),
                Expanded(child: _line(width: double.infinity)),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),

            const SizedBox(height: 18),

            _rowShimmer(),
            _rowShimmer(),
            _rowShimmer(valueHighlighted: true),
          ],
        ),
      ),
    );
  }
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

Widget _pill({required double width, double height = 32}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(20),
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

Widget _rowShimmer({bool valueHighlighted = false}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _line(width: 100),
        _line(width: valueHighlighted ? 80 : 60),
      ],
    ),
  );
}


