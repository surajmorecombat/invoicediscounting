import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/wallet_card.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/wallet/wallet_add.dart';

class AddToWallet extends StatefulWidget {
  const AddToWallet({super.key});

  @override
  State<AddToWallet> createState() => _AddToWalletState();
}

class _AddToWalletState extends State<AddToWallet> {
  bool addwallet = false;
  int selectedAmount = 000000;
  int unitCount = 1;
  bool isChecked = false;

  int totalUnit = 30;
  int unitLeft = 23;
  int pricePerUnit = 100000;
  final TextEditingController amountController = TextEditingController();

  int get unitLeftNow => unitLeft + unitCount;
  int get totalAmount => unitCount * pricePerUnit;
  void widrawlCardOne() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder:
          (_) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              color: const Color(0xFF003A8F).withOpacity(.15),
              child: WithdrawalDialog(),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: blackColor),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF003A8F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            // onPressed: () {},
              onPressed: null,
            child: Text(
              'Continue with Payment',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 120 : 20,
            vertical: 16,
          ),
          child: Column(
            children: [unitCalculatorCard(context),
    
             secondaryCard(context),
         SizedBox(height: 16,),

            if (addwallet) lowBalanceCard(context)
            
            
            ],
          ),
        ),
      ),
    );
  }

  Widget secondaryCard(BuildContext context) {
    return Card(
          elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
     
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          children: [
            buildRow(context, 'Unit Value', '₹1,00,000.00'),
            buildRow(context, 'Coupon Rate', '12.5%'),
            buildRow(context, 'Investment Value', '₹1,03,561.64'),
            buildRow(context, 'Unit Price', '₹1,00,000.00'),
            buildRow(
              context,
              'Accrued Interest',
              '₹3,561.64',
              icon: Icons.info_outline,
            ),
            buildRow(
              context,
              'Next Liquidity Event',
              '13/11/2025',
              icon: Icons.info_outline,
            ),
            buildRow(
              context,
              'Liquidity Event Amount',
              '₹1,04,589.98',
              icon: Icons.info_outline,
            ),
            buildRow(
              context,
              'Final Maturity Date',
              '08/01/2028',
              icon: Icons.info_outline,
            ),
            buildRow(
              context,
              'Exp. Maturity Amount',
              '₹1,36,708.72',
              highlight: true,
            ),
          ],
        ),
      ),
    );
  }

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
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          Row(
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: highlight ? Colors.green : blackColor,
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

  Widget unitCalculatorCard(BuildContext context) {
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
            const Text(
              "No. of units",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                _unitButton(Icons.remove, () {
                  if (unitCount > 1) setState(() => unitCount--);
                }),
                const SizedBox(width: 12),

                Container(
                  width: 80,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "$unitCount",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(width: 12),

                _unitButton(Icons.add, () {
                  if (unitCount < totalUnit) {
                    setState(() {
                      unitCount++;
                      addwallet = true;
                    });
                  }
                }),

                const Spacer(),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$unitLeftNow/$totalUnit',
                      // "Unit Left 23/30",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(height: 4),
                    Text(
                      // "₹1,00,000",
                      totalAmount.toString(),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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


  Widget lowBalanceCard(BuildContext context) {
  return Card(
         elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        // margin: const EdgeInsets.only(bottom: 16),
    child: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text("Amplio Pocket",
                  style: Theme.of(  context).textTheme.bodyLarge),
              Text("₹0.25",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
            ],
          ),
          const Divider(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(
                  "You don't have enough balance to purchase the selected units.\n"
                  "Please add funds to proceed.",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.red),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                // height: 38,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF003A8F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletAdd()));
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Text("Add Funds"),
                  ),
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
