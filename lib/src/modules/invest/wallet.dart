import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/invest/payment_method.dart';

class AddToWallet extends StatefulWidget {
  const AddToWallet({super.key});

  @override
  State<AddToWallet> createState() => _AddToWalletState();
}

class _AddToWalletState extends State<AddToWallet> {
  int selectedAmount = 000000;
  int unitCount = 1;
  bool isChecked = false;

  int totalUnit = 30;
  int unitLeft = 23;
  int pricePerUnit = 100000;

  int get unitLeftNow => unitLeft + unitCount;
  int get totalAmount => unitCount * pricePerUnit;

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
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectPaymentMethod(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: onboardingTitleColor,
                  // side: BorderSide(color: onboardingTitleColor, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  "Add",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: whiteColor),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUnits()));
                },

                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: onboardingTitleColor, width: 1),
                  backgroundColor: whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),

                child: Text(
                  "Withdraw",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: onboardingTitleColor),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 120 : 20,
            vertical: 16,
          ),
          child: Column(
            children: [
              walletBalanceAdd(context),
              secondaryCard(context),
              unitCalculatorCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget walletBalanceAdd(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Wallet Balance",
              style: Theme.of(context).textTheme.displaySmall,
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("₹ ", style: Theme.of(context).textTheme.displaySmall),
                Text(
                  _format(selectedAmount),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(" /-", style: Theme.of(context).textTheme.displaySmall),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _amountChip(5000),
                _amountChip(10000),
                _amountChip(25000),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              "For your security, we can accept payments only from your registered bank account. "
              "Any payment from a different account will be declined automatically.",
              // textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),

            const SizedBox(height: 24),
            const Divider(),

            _balanceRow("Current Balance", "₹0.00"),
            _balanceRow("New Deposit", "₹0.00"),
            _balanceRow("New Balance", "₹0.00"),
          ],
        ),
      ),
    );
  }

  Widget _balanceRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodySmall),
          Text(value, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _amountChip(int amount) {
    final bool selected = selectedAmount == amount;

    return GestureDetector(
      onTap: () => setState(() => selectedAmount = amount),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? onboardingTitleColor.withOpacity(.1) : Colors.white,
          border: Border.all(
            color: selected ? onboardingTitleColor : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          "₹${_format(amount)}",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: selected ? onboardingTitleColor : Colors.black,
          ),
        ),
      ),
    );
  }

  String _format(int n) {
    return n.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }

  Widget secondaryCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                    setState(() => unitCount++);
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

            const SizedBox(height: 12),

            Row(
              children: [
                Checkbox(
                  activeColor: onboardingTitleColor,
                  value: isChecked,
                  onChanged: (v) => setState(() => isChecked = v!),
                ),
                Expanded(
                  child: Text(
                    'I am 18 years old and I can enter into a contract',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
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
}
