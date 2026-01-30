import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/help_center_shimmer.dart';

import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/profile/help/general/general.dart';
import 'package:invoicediscounting/src/modules/profile/help/get_started/get_started.dart';
import 'package:invoicediscounting/src/modules/profile/help/help_portfolio/help_portfolio.dart';
import 'package:invoicediscounting/src/modules/profile/help/return_taxation/return_taxation.dart';

class HelpCentre extends StatefulWidget {
  const HelpCentre({super.key});

  @override
  State<HelpCentre> createState() => _HelpCentreState();
}

class _HelpCentreState extends State<HelpCentre> {
    bool isLoading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Help Centre',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
        child:isLoading? HelpCenterShimmer():
        Column(
          children: [
            helpCategoryCard(
              context,
              "General",
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpGeneral()),
                );
              },
            ),
            SizedBox(height: 16),
            helpCategoryCard(
              context,
              "Getting started",
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpGettingStarted()),
                );
              },
            ),
            SizedBox(height: 16),
            helpCategoryCard(
              context,
              "Portfolio",
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpPortfolioFAQ()),
                );
              },
            ),

            SizedBox(height: 16),
            helpCategoryCard(
              context,
              "Returns & Taxation",
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReturnTaxation()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget helpCategoryCard(context, String title, {VoidCallback? ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

/*
class HelpCentre extends StatelessWidget {
  const HelpCentre({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return MainLayout(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Help Centre',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
      ),
      ctx: 0,
      showDefaultBottom: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  helpCategoryCard(
                    context,
                    'assets/icons/get-start.png',
                    "Getting Started",
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Invest()),
                        ),
                  ),
                  helpCategoryCard(
                    context,
                    'assets/icons/deposite.png',
                    "Deposits & Withdrawals",
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrainsationAll(),
                          ),
                        ),
                  ),
                  helpCategoryCard(
                    context,
                    'assets/icons/portfolioo.png',
                    "Portfolio & Earnings",
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Portfolio()),
                        ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  helpCategoryCard(
                    context,
                    'assets/icons/return.png',
                    "Returns & Taxation",
                    onTap: () {},
                    // () =>
                    //  Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Invest()),
                    // ),
                  ),
                  helpCategoryCard(
                    context,
                    'assets/icons/security.png',
                    "Security & Fraud",
                    onTap: () {},
                    // onTap:
                    //     () => Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => Invest()),
                    //     ),
                  ),
                  helpCategoryCard(
                    context,
                    'assets/icons/business.png',
                    "Business Accounts",
                    onTap: () {},
                    // onTap:
                    //     () => Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => Invest()),
                    //     ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
            Text(
              'Contact Support',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(height: 20),
            support(
              context,
              'assets/icons/email.png',
              'Email Support',
              ' Reply within 4 hours',
            ),
            const Divider(),
            SizedBox(height: 20),
            support(
              context,
              'assets/icons/whatsapp-black.png',
              'WhatsApp Chat',
              'instant replies (9 AM–7 PM)',
            ),
            const Divider(),
            SizedBox(height: 20),
            support(
              context,
              'assets/icons/call-support.png',
              'Call Support',
              'Mon–Fri, 10 AM–6 PM',
            ),
            const Divider(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget helpCategoryCard(
    context,
    String imagePath,
    String title, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, width: 40, height: 40),
            // Icon(icon, size: 28),
            const Spacer(),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget support(context, String imagePath, String title, String subtitle) {
    return Row(
      children: [
        Image.asset(imagePath, width: 30, height: 30),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 5),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}


*/
