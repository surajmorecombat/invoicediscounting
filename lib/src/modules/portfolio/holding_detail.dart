import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/sell_unit_dialog.dart';
import 'package:invoicediscounting/src/components/shimmer/holding_details_shimmer.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

class HoldingDetail extends StatefulWidget {
  const HoldingDetail({super.key});

  @override
  State<HoldingDetail> createState() => _HoldingDetailState();
}

class _HoldingDetailState extends State<HoldingDetail> {
  late BuildContext rootContext;
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
  void didChangeDependencies() {
    rootContext = context;
    super.didChangeDependencies();
  }

  void _openSellDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder:
          (_) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              color: const Color(0xFF003A8F).withOpacity(.15),
              child: const SellUnitDialog(),
            ),
          ),
      // => const SellUnitDialog(),
    );
  }

  bool showParties = false;
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Holding Detail',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: onboardingTitleColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              _openSellDialog();
              // showDialog(

              //   barrierColor: const Color(0xFF003A8F).withOpacity(.15),
              //   builder: (_) => const SellUnitDialog(),
              // );
            },
            child: Text('Sell', style: Theme.of(context).textTheme.labelLarge),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //    const SizedBox(height: 12),
              isLoading
                  ? InvestedAmountCardShimmer()
                  : investedAmountCard(context),
              SizedBox(height: 12),

              isLoading
                  ? InvestmentDetailsCardShimmer()
                  : investmentDetailsCard(context),
              SizedBox(height: 12),
              isLoading
                  ? const RepaymentDetailsCardShimmer()
                  : repaymentDetailsCard(context),

              SizedBox(height: 12),
              isLoading ? const PartiesCardShimmer() : partiesCard(context),

              SizedBox(height: 12),
              isLoading ? const DocumentCardShimmer() : documentCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget investedAmountCard(context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text('INVESTED AMOUNT', style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 10),
          Text(
            '₹1,00,000.00',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 15),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Expected Earnings :',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(
                  text: ' ₹13,300 for 1 year',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: lightGreen,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icons/tick.png', width: 15, height: 15),
                SizedBox(width: 5),
                Text(
                  'REGULATED',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget investmentDetailsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Investment Details",
            style: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 22),

          _detailRow(
            context,
            leftValue: "₹1,00,000/-",
            leftLabel: "Invested",
            rightValue: "30 Days",
            rightLabel: "Compounding Frequency",
          ),

          const Divider(height: 30, color: Colors.black12, thickness: 1),

          _detailRow(
            context,
            leftValue: "1",
            leftLabel: "Number of Units",
            rightValue: "Compound",
            rightLabel: "Type of Interest",
          ),

          const Divider(height: 30, color: Colors.black12, thickness: 1),

          _detailRow(
            context,
            leftValue: "13.24%",
            leftLabel: "XIRR",
            rightValue: "12.5%",
            rightLabel: "Interest Rate",
          ),
        ],
      ),
    );
  }

  Widget _detailRow(
    BuildContext context, {
    required String leftValue,
    required String leftLabel,
    required String rightValue,
    required String rightLabel,
  }) {
    return Row(
      children: [
        Expanded(child: _detailItem(context, leftValue, leftLabel)),
        const SizedBox(width: 16),
        Expanded(
          child: _detailItem(context, rightValue, rightLabel, alignRight: true),
        ),
      ],
    );
  }

  Widget _detailItem(
    BuildContext context,
    String value,
    String label, {
    bool alignRight = false,
  }) {
    return Column(
      crossAxisAlignment:
          alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget repaymentDetailsCard(context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Repayment Details",
            style: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 22),
          repaymentRow(
            context,
            'Expected Repayment Amount (at maturity)',
            '₹1,36,766  approx.',
          ),
          repaymentRow(
            context,
            'Expected Repayment Amount (at next liquidity event)',
            '₹1,01,041.67 approx.',
          ),

          repaymentRow(context, 'Final Maturity Date', '21/04/2028'),
          repaymentRow(context, 'Liquidity Event Frequency', '30 Days'),
        ],
      ),
    );
  }

  Widget repaymentRow(
    BuildContext context,
    String leftLabel,
    String rightLabel,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              leftLabel,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              rightLabel,
              textAlign: TextAlign.end,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget partiesCard(context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() => showParties = !showParties);
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Parties Involved',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineLarge?.copyWith(color: blackColor),
                  ),
                ),
                Icon(
                  showParties
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          if (showParties) ...[
            partiesRow(
              context,
              'FL',
              'Flipkart Private LTD',
              'BUYER',
              changeColor: true,
            ),
            const Divider(height: 30, color: Colors.black12, thickness: 1),
            partiesRow(context, 'WL', 'Wheeley Private LTD', 'SELLER'),
          ],
        ],
      ),
    );
  }

  Widget partiesRow(
    context,
    String partyName,
    String leftLabel,
    String rightLabel, {
    bool changeColor = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: changeColor ? lightGreen : pinkLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                partyName,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: changeColor ? successText : Colors.red,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(leftLabel, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: changeColor ? successText : Colors.red,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            rightLabel,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: whiteColor),
          ),
        ),
      ],
    );
  }

  Widget documentCard(context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Documents",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: blackColor),
          ),
          const SizedBox(height: 4),
          Text(
            "All the document for you to read and invest for understanding the deal.",
            style: Theme.of(context).textTheme.bodySmall,
          ),

          const SizedBox(height: 12),
          Row(
            children: const [
              _DocChip("Invoice"),
              SizedBox(width: 10),
              _DocChip("Agreement"),
              SizedBox(width: 10),
              _DocChip("PDC"),
            ],
          ),
        ],
      ),
    );
  }
}

class _DocChip extends StatelessWidget {
  final String text;
  const _DocChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.download, size: 17),
          SizedBox(width: 5),
          Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: blackColor),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade100,
    );
  }
}
