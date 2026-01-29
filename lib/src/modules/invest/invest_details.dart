import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/about_entity_shimmer.dart';
import 'package:invoicediscounting/src/components/shimmer/opportunity_summary_card.dart';
import 'package:invoicediscounting/src/components/shimmer/platform_track_record.dart';
import 'package:invoicediscounting/src/components/shimmer/primary_card_shimmer.dart';
import 'package:invoicediscounting/src/components/shimmer/risk_mitigation_shimmer.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/invest/payment_done_success.dart';
import 'package:invoicediscounting/src/modules/invest/wallet.dart';
import 'package:super_tooltip/super_tooltip.dart';

class InvestDetails extends StatefulWidget {
  bool? investNow;
  InvestDetails({super.key, this.investNow});

  @override
  State<InvestDetails> createState() => _InvestDetailsState();
}

class _InvestDetailsState extends State<InvestDetails> {
  bool isLoading = true;
  bool showRiskSection = true;
  bool faqOne = false;
  bool faqTwo = false;
  bool faqThree = false;
  bool showPlatformTrack = false;
  bool showOpportunitySummary = false;
  bool showAboutEntities = false;

  int unitCount = 1;
  int totalUnit = 30;
  int unitLeft = 23;
  int pricePerUnit = 100000;
  bool isChecked = false;
  final SuperTooltipController _tooltipController = SuperTooltipController();

  int get unitLeftNow => unitLeft + unitCount;
  int get totalAmount => unitCount * pricePerUnit;

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
  void dispose() {
    _tooltipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Investment Details',
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
              if (widget.investNow == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentDoneSuccess()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddToWallet()),
                );
              }
            },
            child: Text(
              'Invest Now',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 120 : 16,
          // vertical: 16,
        ),
        child: Column(
          children: [
            isLoading ? PrimaryCardShimmer() : _primaryCard(context),

            // const SizedBox(height: 16),
            isLoading
                ? const RiskMitigationCardShimmer()
                : riskMitigationCard(context),

            isLoading
                ? const PlatformTrackRecordCardShimmer()
                : platformTrackRecordCard(context),

            isLoading
                ? const OpportunitySummaryCardShimmer()
                : opportunitySummaryCard(context),

            isLoading
                ? const AboutEntitiesCardShimmer()
                : aboutEntitiesCard(context),

            shareDealCard(context),
          ],
        ),
      ),
    );
  }

  Widget _primaryCard(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          /// Padded content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [buyerSeller(context), const SizedBox(height: 12)],
            ),
          ),

          /// FULL-WIDTH STRIP (no padding leak)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(color: Colors.grey.shade200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/shild.png', width: 15, height: 15),
                const SizedBox(width: 6),
                Text(
                  'Regulated by RBI',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          /// Padded content continues
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                // const Divider(height: 24),
                buildRow(context, 'Minimum Investment', '₹1,00,000.00'),
                buildRow(context, 'XIRR', '13.65%', highlight: true),
                buildRow(context, 'Coupon Rate', '12.5%', highlight: true),
                buildRow(context, 'Unit Left', '23/30'),
                buildRow(context, 'Tenure', '90 Days'),
                buildRow(context, 'Type of Interest', 'Compound'),
                buildRow(context, 'Recourse', 'Seller'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget riskMitigationCard(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() => showRiskSection = !showRiskSection);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Risk Mitigation',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    showRiskSection
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),
            Text(
              'Financial safeguards designed to reduce the risk of loss',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),

            if (showRiskSection) ...[
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: _RiskItem(
                      "5%",
                      "Credit Enhancement",
                      tooltip:
                          "Interest is credited to your bank account every month.",
                      tooltipWidth: 200,
                    ),
                  ),
                  Expanded(
                    child: _RiskItem(
                      "Secured",
                      "Collateral Security",
                      tooltip:
                          "Interest is credited to your bank account every month.",
                      tooltipWidth: 200,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: _RiskItem(
                      "125%",
                      "Collateral Cover",
                      tooltip:
                          "Interest is credited to your bank account every month.",
                      tooltipWidth: 200,
                    ),
                  ),
                  Expanded(
                    child: _RiskItem(
                      "Amplio Assured",
                      "Built-In Insurance",
                      tooltip:
                          "Interest is credited to your bank account every month.",
                      tooltipWidth: 200,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget shareDealCard(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),

      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              "Share this Deal",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: blackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shareButton("Copy Link", 'assets/icons/link.png'),
                _shareButton("WhatsApp", 'assets/icons/whatsapp.png'),
                _shareButton("Email", 'assets/icons/mail.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _shareButton(String text, String imagePath) {
    return OutlinedButton.icon(
      onPressed: () {},
      label: Row(
        children: [
          Image.asset(imagePath, width: 15, height: 15),
          SizedBox(width: 5),

          Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget platformTrackRecordCard(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            GestureDetector(
              onTap:
                  () => setState(() => showPlatformTrack = !showPlatformTrack),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Platform Track Record",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    showPlatformTrack
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),
            Text(
              "Information provided for all previous campaigns for which repayment has been completed",
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),

            if (showPlatformTrack) ...[
              const SizedBox(height: 16),

              Row(
                children: [
                  _trackMetric("91", "Campaigns"),
                  const Spacer(),
                  _trackMetric("₹13,69,81,111.0", "Repaid", alignRight: true),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Text(
                    "100%",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    // style: TextStyle(
                    //   color: Colors.green,
                    //   fontWeight: FontWeight.w600,
                    // ),
                  ),
                  SizedBox(width: 6),
                ],
              ),
              Row(
                children: [
                  const Text("On-time Repayment"),
                  const SizedBox(width: 6),
                  SuperTooltip(
                    controller: _tooltipController,
                    showBarrier: true,
                    backgroundColor: const Color(0xff2f2d2f),
                    popupDirection: TooltipDirection.down,
                    content: SizedBox(
                      width: 220,
                      child: Text(
                        'Interest is credited to your bank account every month.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _tooltipController.showTooltip();
                      },
                      child: const Icon(
                        Icons.info_outline,
                        size: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Text(
                "Documents",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: blackColor),
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
          ],
        ),
      ),
    );
  }

  Widget _trackMetric(String value, String label, {bool alignRight = false}) {
    return Column(
      crossAxisAlignment:
          alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget opportunitySummaryCard(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            GestureDetector(
              onTap:
                  () => setState(
                    () => showOpportunitySummary = !showOpportunitySummary,
                  ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Opportunity Summary",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    showOpportunitySummary
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),
            Text(
              "Information provided for all previous campaigns for which repayment has been completed",
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),

            if (showOpportunitySummary) ...[
              const SizedBox(height: 16),

              _section(
                "About Buyer",
                "Sampoorna Feeds Pvt Ltd is a Phagwara, Punjab-based company specializing in manufacturing and selling a range of animal feed, including poultry and cattle feed, primarily produced through contract farming.",
              ),

              const SizedBox(height: 16),

              _section(
                "About Seller",
                "Annapurna Feeds deals in FMCG food sector.",
              ),

              const SizedBox(height: 16),
              _section(
                "About the Trustee",
                "Beacon Trusteeship Limited is a SEBI-registered debenture trustee that provides a wide range of trustee services, including Debenture Trustee Services, Security Trustee Services, Trustee to Alternate Investment Funds (AIF), Trustee to Securitization transactions, Bond Trusteeship Services, Escrow Services, and Safekeeping.",
              ),

              const SizedBox(height: 16),

              _section(
                "About NBFC",
                "Gangotree Baitar Private Limited (GBPL) is a Non Deposit-Taking NBFC registered with RBI having registration number as 05.02902. Backed by a team of qualified investment professionals, GBPL specializes in providing Invoice Discounting and Supply Chain Financing to Corporates in India.",
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _section(String title, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: blackColor),
        ),
        const SizedBox(height: 4),
        Text(desc, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget aboutEntitiesCard(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap:
                  () => setState(() => showAboutEntities = !showAboutEntities),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Frequently Asked Questions",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    showAboutEntities
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),

            if (showAboutEntities) ...[
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'What is Invoice Discounting?',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: blackColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        faqOne = !faqOne;
                      });
                    },
                    icon: Icon(
                      faqOne
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                  ),
                ],
              ),

              if (faqOne) ...[
                Text(
                  'Invoice discounting is a financial service where a business sells its outstanding, unpaid invoices to a third-party financier (a bank or specialist firm) at a discount in exchange for an immediate cash advance [1]. This allows companies to quickly access working capital they would otherwise have to wait 30 to 90 days or more to receive from customers.',
                ),
              ],

              Row(
                children: [
                  Expanded(
                    child: Text(
                      'How are the returns generated?',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: blackColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        faqTwo = !faqTwo;
                      });
                    },
                    icon: Icon(
                      faqTwo
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                  ),
                ],
              ),

              if (faqTwo) ...[
                Text(
                  'Returns in invoice discounting are generated in two ways: for the business (through improved cash flow and operational efficiency) and for the financier/investor (through fees and the discount rate applied to the invoice).',
                ),
              ],

              Row(
                children: [
                  Expanded(
                    child: Text(
                      'How are the returns calculated?',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: blackColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        faqThree = !faqThree;
                      });
                    },
                    icon: Icon(
                      faqThree
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                  ),
                ],
              ),

              if (faqThree) ...[
                Text(
                  '''Returns in invoice discounting are primarily calculated as the difference between the full value of an invoice and the discounted amount paid upfront, often expressed as a percentage rate. This calculation is a simple arithmetic difference for the financier's nominal return, and a time-value-adjusted calculation to determine the actual annualized rate of return.''',
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  // Widget _aboutSection(String title, String description) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         title,
  //         style: Theme.of(
  //           context,
  //         ).textTheme.headlineLarge?.copyWith(color: blackColor),
  //       ),
  //       const SizedBox(height: 6),
  //       Text(description, style: const TextStyle(color: Colors.grey)),
  //     ],
  //   );
  // }

  Widget buyerSeller(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: whiteColor,
          radius: 22,
          child: Image.asset('assets/images/imagetwo.png'),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Flipkart\nBuyer',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              // fontSize: 18,
              color: blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Icon(Icons.swap_horiz, size: 30, color: blackColor),
        Expanded(
          child: Text(
            'Wheeley\nSeller',
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              // fontSize: 18,
              color: blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          backgroundColor: whiteColor,
          radius: 22,
          child: Image.asset('assets/images/imageone.png'),
        ),
      ],
    );
  }

  // Widget secondaryCard(BuildContext context) {
  //   return Card(
  //     elevation: 0.7,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  //       child: Column(
  //         children: [
  //           buildRow(context, 'Unit Value', '₹1,00,000.00'),
  //           buildRow(context, 'Coupon Rate', '12.5%'),
  //           buildRow(context, 'Investment Value', '₹1,03,561.64'),
  //           buildRow(context, 'Unit Price', '₹1,00,000.00'),
  //           buildRow(
  //             context,
  //             'Accrued Interest',
  //             '₹3,561.64',
  //             icon: Icons.info_outline,
  //           ),
  //           buildRow(
  //             context,
  //             'Next Liquidity Event',
  //             '13/11/2025',
  //             icon: Icons.info_outline,
  //           ),
  //           buildRow(
  //             context,
  //             'Liquidity Event Amount',
  //             '₹1,04,589.98',
  //             icon: Icons.info_outline,
  //           ),
  //           buildRow(
  //             context,
  //             'Final Maturity Date',
  //             '08/01/2028',
  //             icon: Icons.info_outline,
  //           ),
  //           buildRow(
  //             context,
  //             'Exp. Maturity Amount',
  //             '₹1,36,708.72',
  //             highlight: true,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget buildRow(
    BuildContext context,
    String title,
    String value, {
    IconData? icon,
    bool highlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: blackColor),
          ),
          Row(
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: highlight ? Colors.green : blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 6),
                Icon(icon, size: 14, color: Colors.grey),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // Widget unitCalculatorCard(BuildContext context) {
  //   return Card(
  //     elevation: 0.7,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Text(
  //             "No. of units",
  //             style: TextStyle(fontWeight: FontWeight.w600),
  //           ),
  //           const SizedBox(height: 12),

  //           Row(
  //             children: [
  //               _unitButton(Icons.remove, () {
  //                 if (unitCount > 1) setState(() => unitCount--);
  //               }),
  //               const SizedBox(width: 12),

  //               Container(
  //                 width: 80,
  //                 height: 42,
  //                 alignment: Alignment.center,
  //                 decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.grey.shade300),
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: Text(
  //                   "$unitCount",
  //                   style: const TextStyle(fontSize: 16),
  //                 ),
  //               ),

  //               const SizedBox(width: 12),

  //               _unitButton(Icons.add, () {
  //                 if (unitCount < totalUnit) {
  //                   setState(() => unitCount++);
  //                 }
  //               }),

  //               const Spacer(),

  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Text(
  //                     '$unitLeftNow/$totalUnit',
  //                     // "Unit Left 23/30",
  //                     style: TextStyle(fontSize: 12, color: Colors.grey),
  //                   ),
  //                   SizedBox(height: 4),
  //                   Text(
  //                     // "₹1,00,000",
  //                     totalAmount.toString(),
  //                     style: TextStyle(fontWeight: FontWeight.w600),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),

  //           const SizedBox(height: 12),

  //           Row(
  //             children: [
  //               Checkbox(
  //                 activeColor: onboardingTitleColor,
  //                 value: isChecked,
  //                 onChanged: (v) => setState(() => isChecked = v!),
  //               ),
  //               Expanded(
  //                 child: Text(
  //                   'I am 18 years old and I can enter into a contract',
  //                   style: Theme.of(context).textTheme.bodyMedium,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _unitButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon),
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

class _DownloadButton extends StatelessWidget {
  final String text;
  const _DownloadButton(this.text);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        onPressed: () {},
        icon: const Icon(Icons.download, size: 16),
        label: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: whiteColor),
        ),
      ),
    );
  }
}

class _RiskItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final String tooltip;
  final double tooltipWidth;
  const _RiskItem(
    this.title,
    this.subtitle, {
    required this.tooltip,
    this.tooltipWidth = 220,
  });

  @override
  State<_RiskItem> createState() => _RiskItemState();
}

class _RiskItemState extends State<_RiskItem> {
  late final SuperTooltipController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SuperTooltipController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  widget.subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () => _controller.showTooltip(),
                  child: SuperTooltip(
                    controller: _controller,
                    showBarrier: true,
                    backgroundColor: const Color(0xff2f2d2f),
                    popupDirection: TooltipDirection.down,
                    content: SizedBox(
                      width: widget.tooltipWidth,
                      child: Text(
                        widget.tooltip,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    child: const Icon(Icons.info_outline, size: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
