import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/faq_card.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

class HelpPortfolioFAQ extends StatelessWidget {
  const HelpPortfolioFAQ({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Portfolio", style: Theme.of(context).textTheme.bodyLarge),
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
        child: Column(
          children: const [
            FAQCard(
              question: "What is on time repayment?",
              answer:
                  "On-time repayment refers to the borrower paying principal and interest on or before the due date.",
            ),
            FAQCard(
              question:
                  "Why is the Invoice Discounting Investment Tenure longer than the campaign period?",
              answer:
                  "Campaign period indicates funding time, whereas tenure represents the full investment lifecycle including repayment.",
            ),
            FAQCard(
              question: "What is annualized earning and how is it calculated?",
              answer:
                  "Annualized earning is your yearly return percentage calculated based on actual returns over time.",
            ),
            FAQCard(
              question: "What is annualized earning and how is it calculated?",
              answer:
                  "It measures the effective yearly growth rate of your investment.",
            ),
            FAQCard(
              question:
                  "What is extended Internal Rate of Return (XIRR)?",
              answer:
                  "XIRR measures the actual return considering the timing of each cash flow.",
            ),
          ],
        ),
      ),
    );
  }
}
