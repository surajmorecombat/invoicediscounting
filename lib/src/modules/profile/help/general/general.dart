import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/faq_card.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

class HelpGeneral extends StatelessWidget {
  const HelpGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("General", style: Theme.of(context).textTheme.bodyLarge),
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 20),
        child: Column(
          children: const [
            FAQCard(
              question: "Does BirbalPlus guarantee any return on investment?",
              answer:
                  "No investment returns are guaranteed. All investments carry market risk and returns depend on market performance.",
            ),
            FAQCard(
              question: "What modes are available for investing?",
              answer:
                  "You can invest using UPI, Net Banking and wallet balance.",
            ),
            FAQCard(
              question: "How to edit your details?",
              answer:
                  "You can update your personal information from Profile → Edit Profile.",
            ),
          ],
        ),
      ),
    );
  }
}
