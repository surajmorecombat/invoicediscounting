import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/news_shimmer.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/mainlayout.dart';

class MarketNewsDetail extends StatefulWidget {
  const MarketNewsDetail({super.key});

  @override
  State<MarketNewsDetail> createState() => _MarketNewsDetailState();
}

class _MarketNewsDetailState extends State<MarketNewsDetail> {
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
    return MainLayout(
      backgroundColor: backgroundColor,
      showDefaultBottom: true,
      ctx: 1,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
        title: Text('News', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 120 : 16,
          vertical: 16,
        ),
        child: Column(children:  [Expanded(child: isLoading?MarketNewsDetailShimmer():
        
        _Content())]),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/image_one.png',
              height: 190,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            'Market Rally Continues: Sensex Hits the Historic 81,000 Milestone',
            style: Theme.of(context).textTheme.displaySmall,
          ),

          const SizedBox(height: 12),

          buildPara(
            'India’s equity markets witnessed another landmark moment today as the BSE Sensex surged past the 81,000 mark...',
          ),
          buildPara(
            'The rally reflects sustained investor confidence, strong macroeconomic fundamentals...',
          ),

          const SizedBox(height: 16),
          buildTitle("What’s Driving the Rally?"),

          buildBulletTitle("Strong Domestic Growth Outlook"),
          buildPara(
            'India’s GDP projections remain optimistic, supported by steady manufacturing growth...',
          ),

          buildBulletTitle("FIIs Turning Net Buyers"),
          buildPara(
            'Foreign Institutional Investors have gradually returned to Indian equities...',
          ),

          buildBulletTitle("Corporate Earnings Momentum"),
          buildPara(
            'Several large-cap companies have delivered earnings growth...',
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget buildTitle(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      t,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
  );

  Widget buildBulletTitle(String t) => Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 6),
    child: Text('• $t', style: const TextStyle(fontWeight: FontWeight.w600)),
  );

  Widget buildPara(String p) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(p, style: const TextStyle(height: 1.5)),
  );
}
