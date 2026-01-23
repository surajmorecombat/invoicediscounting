import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/faq_card.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

class HelpGettingStarted extends StatelessWidget {
  const HelpGettingStarted({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Getting started", style: Theme.of(context).textTheme.headlineMedium),
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
        child: Column(
          children: const [
            FAQCard(
              question: "Can you invest as a non-individual?",
              answer:
                  "Yes, BirbalPlus allows non-individual investors such as HUFs, trusts, and corporate entities to invest after completing KYC.",
            ),
            FAQCard(
              question: "How do I register on BirbalPlus?",
              answer:
                  "You can register by signing up using your mobile number, completing OTP verification and KYC.",
            ),
            FAQCard(
              question: "How can I invest via BirbalPlus?",
              answer:
                  "You can browse available bonds, select your desired investment and pay via UPI, Net Banking or wallet.",
            ),
            FAQCard(
              question: "What is the minimum investment amount?",
              answer:
                  "The minimum investment amount depends on the bond and usually starts from ₹10,000.",
            ),
            FAQCard(
              question: "Who can invest via BirbalPlus?",
              answer:
                  "Any Indian resident above 18 years who has completed KYC can invest.",
            ),
          ],
        ),
      ),
    );
  }
}
