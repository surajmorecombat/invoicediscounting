import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

class InvestmentCardsSlider extends StatefulWidget {
  final List<InvestmentCardData> items;

  const InvestmentCardsSlider({super.key, required this.items});

  @override
  State<InvestmentCardsSlider> createState() => _InvestmentCardsSliderState();
}

class _InvestmentCardsSliderState extends State<InvestmentCardsSlider> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final totalCards = widget.items.length;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 350,

          child: PageView.builder(
            controller: _pageController,
            itemCount: totalCards,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return _buildCard(widget.items[index]);
            },
          ),
        ),

        if (currentIndex > 0)
          Positioned(
            left: 0,
            child: _arrowButton(Icons.arrow_back_ios_new, () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }),
          ),

        if (currentIndex < totalCards - 1)
          Positioned(
            right: 0,
            child: _arrowButton(Icons.arrow_forward_ios, () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }),
          ),
      ],
    );
  }

  Widget _buildCard(InvestmentCardData d) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        elevation: 6,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: onboardingTitleColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      d.bondName,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: whiteColor),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1FAE5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      d.rating,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.green.shade700,
                      ),
                      // style: TextStyle(
                      //   fontWeight: FontWeight.w700,
                      //   fontSize: 11,
                      //   color: Colors.green.shade700,
                      // ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Qty: ${d.qty}",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: whiteColor),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// BODY CONTENT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// INVESTMENT Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Investment",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${d.invested}/- Invested",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Text(
                    "Returns",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${d.couponRate}% Coupon (Annual)",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: blackColor),
                      ),
                      Text(
                        "₹ ${d.annualCoupon}",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: blackColor),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Annual Interest",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: blackColor),
                      ),
                      Text(
                        "₹ ${d.annualInterest}",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: blackColor),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tenure",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: blackColor),
                      ),
                      Text(
                        "Maturity: ${d.maturity}",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: blackColor),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>BondDetails()));
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: onboardingTitleColor,
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            "View Details",
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(color: onboardingTitleColor),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            //    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUnits()));
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: onboardingTitleColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),

                          child: Text(
                            "Sell",
                            style: Theme.of(
                              context,
                            ).textTheme.labelLarge?.copyWith(color: whiteColor),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Interest shown is accrued till date. Final interest is paid annually.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: onboardingTitleColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _arrowButton(IconData icon, VoidCallback onPressed) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: onboardingTitleColor,
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 18,
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}

class InvestmentCardData {
  final String bondName;
  final String rating;
  final String qty;
  final String invested;
  final String couponRate;
  final String annualCoupon;
  final String annualInterest;
  final String maturity;

  InvestmentCardData({
    required this.bondName,
    required this.rating,
    required this.qty,
    required this.invested,
    required this.couponRate,
    required this.annualCoupon,
    required this.annualInterest,
    required this.maturity,
  });
}
