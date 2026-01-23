import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invoicediscounting/src/components/total_earning_card.dart';
import 'package:invoicediscounting/src/components/wallet_card.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/mainlayout.dart';
import 'package:invoicediscounting/src/modules/activity/market_news_detail.dart';
import 'package:invoicediscounting/src/modules/activity/trainsation_all.dart';
import 'package:invoicediscounting/src/modules/invest/invest_details.dart';
import 'package:invoicediscounting/src/modules/portfolio/demat/demat_details.dart';
import 'package:invoicediscounting/src/modules/profile/profile.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  int visibleCount = 2;
  bool showTransaction = true;
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return MainLayout(
      backgroundColor: backgroundColor,
      showDefaultBottom: true,
      ctx: 1,

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
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 120 : 16,
            //  vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // totalEarningCard(context),
               SizedBox(height: 10),
              buildDemateAddCard(context),
              SizedBox(height: 10),

              Text(
                'Recent Activity',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: blackColor),
              ),
              SizedBox(height: 10),
              _InvoiceCard(
                buyer: 'Shristi Ispat',
                seller: 'Flipkart',
                imagepathbuyer: 'assets/images/imageone.png',
                imagepatseller: 'assets/images/imagetwo.png',
              ),
       
              showTransactionCard(context),
              // WalletCard(),
              // walletBalanceCard(context),
              marketNews(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDemateAddCard(context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // gradient: bannerCard,
        color: onboardingTitleColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Update Your Demat Details',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
                SizedBox(height: 6),
                Text(
                  'For secured and safe transaction with Birbalplus',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: whiteColor),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: whiteColor,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DematDetails()),
              );
            },
            child: Text(
              'Fill Details',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: blackColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget showTransactionCard(context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showTransaction = !showTransaction;
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Transaction',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: blackColor),
                  ),
                ),
                Icon(
                  showTransaction
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),

            if (showTransaction) ...[
              SizedBox(height: 20),
              Text('Investment'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Wheeley Private LTD 15/10/2025 '),
                  Text('+ ₹1,00,000'),
                ],
              ),

              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade300),

              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TrainsationAll()),
                  );
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'See All >',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget marketNews(context) {
    final imageList = [
      'assets/images/image_one.png',
      'assets/images/image_two.png',
      'assets/images/image_one.png',
      'assets/images/image_two.png',
      'assets/images/image_one.png',
      'assets/images/image_two.png',
      'assets/images/image_one.png',
      'assets/images/image_two.png',
      'assets/images/image_one.png',
      'assets/images/image_two.png',
    ];

    final data = [
      '''Market Rally Continues
Sensex hits 81K milestone''',
      '''RBI Policy Update
Interest rates remain stable''',
      '''Market Rally Continues
Sensex hits 81K milestone''',
      '''RBI Policy Update
Interest rates remain stable''',
      '''Market Rally Continues
Sensex hits 81K milestone''',
      '''RBI Policy Update
Interest rates remain stable''',
      '''Market Rally Continues
Sensex hits 81K milestone''',
      '''RBI Policy Update
Interest rates remain stable''',
      '''Market Rally Continues
Sensex hits 81K milestone''',
      '''RBI Policy Update
Interest rates remain stable''',
    ];
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Market News', style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: visibleCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MarketNewsDetail()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4),
                    ],
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 110, // FIXED image height
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.asset(
                            imageList[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          data[index],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 14),

          if (visibleCount < imageList.length)
            Center(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    visibleCount = (visibleCount + 4).clamp(
                      0,
                      imageList.length,
                    );
                  });
                },
                child: Text(
                  'Show More',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: onboardingTitleColor),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _InvoiceCard extends StatelessWidget {
  String imagepathbuyer;
  String imagepatseller;

  final String buyer, seller;
  _InvoiceCard({
    required this.imagepathbuyer,
    required this.buyer,
    required this.seller,
    required this.imagepatseller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InvestDetails()),
        );
      },
      child: Card(
        elevation: 0.1,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        // margin: const EdgeInsets.only(bottom: 16),
        // padding: const EdgeInsets.all(16),
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(16),
        //   border: Border.all(color: Colors.grey.shade200),
        // ),
        child: Container(
          //  margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: whiteColor,
                    radius: 22,
                    child: Image.asset(imagepathbuyer),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      buyer,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Icon(Icons.swap_horiz, size: 35, color: blackColor),
                  Expanded(
                    child: Text(
                      seller,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(width: 6),
                  CircleAvatar(
                    backgroundColor: whiteColor,
                    radius: 22,
                    child: Image.asset(imagepatseller),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _Metric(label: 'Unit Cost', value: '₹1,00,000'),
                  _Metric(label: 'XIRR', value: '13.65%', green: true),
                     _Metric(label: 'Coupon Rate', value: '12.5%', green: true),
                  _Metric(label: 'Tenure', value: '90 Days'),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _Metric(label: 'Unit Left', value: '23/30'),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: onboardingTitleColor,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InvestDetails(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'View Details',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_forward, size: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label, value;
  final bool green;
  const _Metric({required this.label, required this.value, this.green = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: green ? Colors.green : Colors.black,
          ),
          // style: TextStyle(
          //   fontWeight: FontWeight.bold,
          //   color: green ? Colors.green : Colors.black,
          // ),
        ),
      ],
    );
  }
}
