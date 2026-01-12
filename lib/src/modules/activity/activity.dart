import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invoicediscounting/src/components/total_earning_card.dart';
import 'package:invoicediscounting/src/components/wallet_card.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/mainlayout.dart';
import 'package:invoicediscounting/src/modules/activity/market_news_detail.dart';
import 'package:invoicediscounting/src/modules/activity/trainsation_all.dart';
import 'package:invoicediscounting/src/modules/profile/profile.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  int visibleCount = 2;
  bool showTransaction = false;
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return MainLayout(
      backgroundColor: backgroundColor,
      showDefaultBottom: true,
      ctx: 1,

      appBar:
   AppBar(
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
            child: SvgPicture.asset('assets/icons/bell.svg',width: 20,height: 20,),
      
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 120 : 20,
          //  vertical: 16,
          ),
          child: Column(
            children: [
              SizedBox(height: 10,),
              totalEarningCard(context),
              showTransactionCard(context),
              WalletCard(),
              // walletBalanceCard(context),
              marketNews(context),
            ],
          ),
        ),
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

  // Widget walletBalanceCard(context) {
  //   return Container(
  //     margin: EdgeInsets.only(top: 20),
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: whiteColor,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: Colors.grey.shade200),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text('Wallet Balance', style: Theme.of(context).textTheme.bodyLarge),
  //         const SizedBox(height: 10),

  //         Text(
  //           '₹ 1,00,000 /-',
  //           style: Theme.of(
  //             context,
  //           ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
  //         ),

  //         const SizedBox(height: 6),
  //         Text(
  //           'Add or Withdraw funds anytime',
  //           style: Theme.of(context).textTheme.bodyMedium,
  //         ),

  //         const SizedBox(height: 18),

  //         Row(
  //           children: [
  //             Expanded(
  //               child: OutlinedButton(
  //                 onPressed: () {
  //                   // Navigator.push(
  //                   //   context,
  //                   //   MaterialPageRoute(
  //                   //     builder: (context) => BankDemeteDetails(),
  //                   //   ),
  //                   // );
  //                 },
  //                 style: OutlinedButton.styleFrom(
  //                   backgroundColor: onboardingTitleColor,
  //                   //   side: BorderSide(color: onboardingTitleColor),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   minimumSize: const Size(0, 48),
  //                 ),
  //                 child: Text(
  //                   'Add',
  //                   style: Theme.of(
  //                     context,
  //                   ).textTheme.labelLarge?.copyWith(color: whiteColor),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(width: 15),
  //             Expanded(
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   // Navigator.push(
  //                   //   context,
  //                   //   MaterialPageRoute(
  //                   //     builder: (context) => DocumentVerified(),
  //                   //   ),
  //                   // );
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   side: BorderSide(color: onboardingTitleColor),
  //                   backgroundColor: whiteColor,
  //                   minimumSize: const Size(0, 48),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                 ),
  //                 child: Text(
  //                   'Withdraw',
  //                   style: Theme.of(context).textTheme.labelLarge?.copyWith(
  //                     color: onboardingTitleColor,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
