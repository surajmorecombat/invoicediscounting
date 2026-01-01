import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

class HoldingDetail extends StatelessWidget {
  const HoldingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF003A8F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              //   Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => PaymentDoneSuccess()),
              // );
            },
            child: Text('Sell', style: Theme.of(context).textTheme.labelLarge),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 20),
        child: Column(
          children: [const SizedBox(height: 12), investedAmountCard(context),
          SizedBox(height: 12),
            investmentDetailsCard(context),
          ],
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
        Text("Investment Details",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.w600)),

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
          leftValue: "-",
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
      Expanded(
        child: _detailItem(context, leftValue, leftLabel),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: _detailItem(context, rightValue, rightLabel, alignRight: true),
      ),
    ],
  );
}

Widget _detailItem(BuildContext context, String value, String label,
    {bool alignRight = false}) {
  return Column(
    crossAxisAlignment:
        alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      Text(value,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w600)),
      const SizedBox(height: 4),
      Text(label, style: Theme.of(context).textTheme.bodySmall),
    ],
  );
}

}
