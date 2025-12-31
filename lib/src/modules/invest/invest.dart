import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/mainlayout.dart';
import 'package:invoicediscounting/src/models/invoicemodel.dart';
import 'package:invoicediscounting/src/modules/invest/invest_details.dart';

class Invest extends StatefulWidget {
  const Invest({super.key});

  @override
  State<Invest> createState() => _InvestState();
}

class _InvestState extends State<Invest> {
  String selectedFilter = 'all';

  final List<InvoiceModel> allInvoices = [
    InvoiceModel(
      buyer: 'Shristi Ispat',
      seller: 'Flipkart',
      buyerImg: 'assets/images/imageone.png',
      sellerImg: 'assets/images/imagetwo.png',
      category: 'high',
    ),
    InvoiceModel(
      buyer: 'Flipkart',
      seller: 'Wheeley',
      buyerImg: 'assets/images/imagetwo.png',
      sellerImg: 'assets/images/imagethree.png',
      category: 'short',
    ),
    InvoiceModel(
      buyer: 'Identifyplus',
      seller: 'Shristi Ispat',
      buyerImg: 'assets/images/imagefour.png',
      sellerImg: 'assets/images/imageone.png',
      category: 'available',
    ),
  ];

  List<InvoiceModel> get filteredInvoices =>
      selectedFilter == 'all'
          ? allInvoices
          : allInvoices.where((e) => e.category == selectedFilter).toList();

  @override
  Widget build(BuildContext context) {
    
    return MainLayout(
      
      backgroundColor: backgroundColor,
      ctx: 0,
      showDefaultBottom: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _TopBar(
                selected: selectedFilter,
                onSelect: (f) => setState(() => selectedFilter = f),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  itemCount: filteredInvoices.length,
                  itemBuilder: (_, index) {
                    final i = filteredInvoices[index];
                    return _InvoiceCard(
                      buyer: i.buyer,
                      seller: i.seller,
                      imagepathbuyer: i.buyerImg,
                      imagepatseller: i.sellerImg,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final String selected;
  final Function(String) onSelect;

  const _TopBar({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person, size: 20),
              const SizedBox(width: 12),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 20,
                      color: onboardingTitleColor,
                    ),
                    SizedBox(width: 6),
                    Text(
                      '₹1,00,000',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Stack(
                children: const [
                  Icon(Icons.notifications_none_outlined, size: 20),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Invoice Discounting',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _Filter('All Products', 'all', selected, onSelect),
              _Filter('High Yield', 'high', selected, onSelect),
              _Filter('Short Term', 'short', selected, onSelect),
              _Filter('Available', 'available', selected, onSelect),
            ],
          ),
        ],
      ),
    );
  }
}

class _Filter extends StatelessWidget {
  final String label, value, selected;
  final Function(String) onTap;

  const _Filter(this.label, this.value, this.selected, this.onTap);

  @override
  Widget build(BuildContext context) {
    final bool isActive = selected == value;

    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? onboardingTitleColor : faintboxbackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(color: isActive ? Colors.white : Colors.black),
        ),
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
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>InvestDetails()));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
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
                CircleAvatar( backgroundColor: whiteColor,
                  radius: 22, child: Image.asset(imagepatseller)),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _Metric(label: 'Unit Cost', value: '₹1,00,000'),
                _Metric(label: 'XIRR', value: '13.65%', green: true),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>InvestDetails()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'View Details',
                        style: Theme.of(context).textTheme.labelLarge,
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
