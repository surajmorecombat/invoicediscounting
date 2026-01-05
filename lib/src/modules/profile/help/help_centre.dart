import 'package:flutter/material.dart';

import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/mainlayout.dart';
import 'package:invoicediscounting/src/modules/activity/trainsation_all.dart';
import 'package:invoicediscounting/src/modules/invest/invest.dart';
import 'package:invoicediscounting/src/modules/portfolio/portfolio.dart';

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
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 20),
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
