import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invoicediscounting/src/components/holding_card.dart';
import 'package:invoicediscounting/src/components/total_earning_card.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/mainlayout.dart';
import 'package:invoicediscounting/src/modules/activity/trainsation_all.dart';
import 'package:invoicediscounting/src/modules/portfolio/holding_detail.dart';
import 'package:invoicediscounting/src/modules/profile/profile.dart'
    show Profile;

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  final List<InvestmentCardData> holdings = [
    InvestmentCardData(
      bondName: "Navi Finserv Limited",
      rating: "A+ Rated",
      qty: "1",
      invested: "1,00,000",
      couponRate: "10.50",
      annualCoupon: "5,254.02",
      annualInterest: "10,500",
      maturity: "2030",
    ),
    InvestmentCardData(
      bondName: "Tata Capital",
      rating: "AA Rated",
      qty: "2",
      invested: "2,00,000",
      couponRate: "9.75",
      annualCoupon: "4,900.00",
      annualInterest: "11,500",
      maturity: "2029",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return DefaultTabController(
      length: 2,
      child: MainLayout(
        backgroundColor: backgroundColor,
        showDefaultBottom: true,
        ctx: 2,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          centerTitle: false,
          leadingWidth: 52,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Profile()),
                );
              },
              child: CircleAvatar(
                radius: 34,
                child: Image.asset('assets/icons/profile.png'),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TrainsationAll()),
                  );
                },
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: onboardingTitleColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 20,
                          color: onboardingTitleColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '₹1,00,000',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Notification Bell
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                'assets/icons/bell.svg',
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              totalEarningCard(context),
              const SizedBox(height: 16),
              _portfolioTabs(context),
              const SizedBox(height: 12),
              Expanded(child: _portfolioTabViews(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _portfolioTabs(BuildContext context) {
    return TabBar(
      indicatorColor: onboardingTitleColor,
      indicatorWeight: 2,
      labelColor: blackColor,
      unselectedLabelColor: Colors.grey,
      tabs: const [
        Tab(text: "Active Investments"),
        Tab(text: "Closed Investments"),
      ],
    );
  }

  Widget _portfolioTabViews(BuildContext context) {
    return TabBarView(
      children: [_activeInvestmentTab(context), _closedInvestmentCard(context)],
    );
  }

  // ACTIVE TAB
  Widget _activeInvestmentTab(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _activeInvestmentCard(context),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: holdings.length,
            itemBuilder: (_, i) => holdingCard(holdings[i]),
          ),
        ],
      ),
    );
  }

  Widget _activeInvestmentCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topRow(context),
            const SizedBox(height: 12),
            Text(
              "₹2045.25",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Total Returns",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Divider(height: 30, color: Colors.grey),
            Text(
              "₹1,00,000",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Wheeley Private LTD",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 6),
            Text("15/10/2025", style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _closedInvestmentCard(BuildContext context) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topRow(context),
                const SizedBox(height: 12),
                Text(
                  "₹5045.12",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Total Returns",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Divider(height: 30),
                const Text("-"),
                Text(
                  "Total Earnings",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 14),
                const Text("-"),
                Text(
                  "Realized IRR%",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topRow(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Download Statement",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(width: 6),
            Icon(Icons.mail_outline, size: 14),
          ],
        ),
      ),
    );
  }

  Widget holdingCard(InvestmentCardData data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HoldingDetail()),
        );
      },
      child: Card(
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
                  CircleAvatar(
                    backgroundColor: whiteColor,
                    radius: 22,
                    child: Image.asset('assets/images/imagethree.png'),
                  ),
                  // CircleAvatar(
                  //   backgroundColor: onboardingTitleColor,
                  //   child: const Icon(Icons.trending_up, color: Colors.white),
                  // ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      data.bondName,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),

              const SizedBox(height: 18),

              _row("Invested", data.invested),
              _row("Realised IRR", "-"),
              _row(
                "Total Earning",
                "₹${data.annualCoupon}",
                valueColor: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: valueColor,
              fontWeight: valueColor != null ? FontWeight.w600 : null,
            ),
            // style: TextStyle(
            //   color: valueColor,
            //   fontWeight: valueColor != null ? FontWeight.w600 : null,
            // ),
          ),
        ],
      ),
    );
  }
}
