import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/birbal_assuresheet.dart';
import 'package:invoicediscounting/src/components/wallet_card.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/invest/payment_done_success.dart';
import 'package:invoicediscounting/src/modules/wallet/wallet_add.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:super_tooltip/super_tooltip.dart';

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
  bool agree = false;
  int totalUnit = 30;
  int unitLeft = 23;
  int pricePerUnit = 100000;
  final TextEditingController amountController = TextEditingController();
  late final SuperTooltipController _controller;
  TextEditingController unitController = TextEditingController();
  bool isEditingUnit = false;

  final FocusNode _unitFocusNode = FocusNode();

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

  void showAmpliAssuredSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const BirbalAssuresheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Invest Now', style: Theme.of(context).textTheme.bodyLarge),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: blackColor),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              termsCheckbox(context, agree, (v) {
                setState(() => agree = v);
              }),

              const SizedBox(height: 12),

              SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      agree
                          ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentDoneSuccess(),
                              ),
                            );
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: onboardingTitleColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Continue with Payment"),
                ),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 120 : 16,
            vertical: 16,
          ),
          child: Column(
            children: [
              unitCalculatorCard(context),

              secondaryCard(context),

              liquidityCard(context),

              coveredByCard(context),

              if (addwallet) lowBalanceCard(context),

              // termsCheckbox(context, agree, (v) {
              //   setState(() => agree = v);
              // }),
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
      margin: const EdgeInsets.only(bottom: 16),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Investment Value',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                //  SizedBox(width: 10),
                Text(
                  '₹1,03,561.64',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),

            buildRow(context, 'Unit Value', '₹1,00,000.00'),
            // buildRow(context, 'Coupon Rate', '12.5%'),
            // buildRow(context, 'Investment Value', '₹1,03,561.64'),
            // buildRow(context, 'Unit Price', '₹1,00,000.00'),
            buildRow(
              context,
              'Accrued Interest',
              '₹3,561.64',
              tooltip: "Interest is credited to your bank account every month.",
              tooltipWidth: 200,
              icon: Icons.info_outline,
            ),
            // buildRow(
            //   context,
            //   'Next Liquidity Event',
            //   '13/11/2025',
            //   icon: Icons.info_outline,
            // ),
            // buildRow(
            //   context,
            //   'Liquidity Event Amount',
            //   '₹1,04,589.98',
            //   icon: Icons.info_outline,
            // ),
            // buildRow(
            //   context,
            //   'Final Maturity Date',
            //   '08/01/2028',
            //   icon: Icons.info_outline,
            // ),
            // buildRow(
            //   context,
            //   'Exp. Maturity Amount',
            //   '₹1,36,708.72',
            //   highlight: true,
            // ),
          ],
        ),
      ),
    );
  }

  Widget liquidityCard(context) {
    return Card(
      elevation: 0.1,
      color: lightblue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 16),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow(
              context,
              'Next Liquidity Event',
              '13/11/2025',
              icon: Icons.info_outline,
              tooltip: "Interest is credited to your bank account every month.",
              tooltipWidth: 200,
            ),
            buildRow(
              context,
              'Liquidity Event Amount',
              '₹1,04,589.98',
              icon: Icons.info_outline,
              tooltip: "Interest is credited to your bank account every month.",
              tooltipWidth: 200,
            ),
            buildRow(
              context,
              'Final Maturity Date',
              '08/01/2028',
              icon: Icons.info_outline,
              tooltip: "Interest is credited to your bank account every month.",
              tooltipWidth: 200,
            ),
            buildRow(
              context,
              'Exp. Maturity Amount',
              '₹1,36,708.72',
              highlight: true,
              icon: Icons.info_outline,
              tooltip: "Interest is credited to your bank account every month.",
              tooltipWidth: 200,
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
    String? tooltip,
    double tooltipWidth = 200,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              if (icon != null) ...[
                const SizedBox(width: 6),
                if (tooltip != null) ...[
                  SuperTooltip(
                    popupDirection: TooltipDirection.down,
                    backgroundColor: const Color(0xff2f2d2f),
                    content: SizedBox(
                      width: tooltipWidth,
                      child: Text(
                        tooltip,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    child: const Icon(Icons.info_outline, size: 16),
                  ),
                ],
              ],
            ],
          ),

          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: highlight ? Colors.green : blackColor,
              fontWeight: FontWeight.normal,
            ),
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
            Text("No. of Units", style: Theme.of(context).textTheme.bodyMedium),

            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _unitIconButton(Icons.remove, () {
                  setState(() {
                    unitCount--;
                    addwallet = true;
                  });
                }, enabled: unitCount > 1),

                const SizedBox(width: 50),

                // Column(
                //   children: [

                //     Text(
                //       unitCount.toString().padLeft(2, '0'),
                //       style: Theme.of(context).textTheme.displaySmall,
                //     ),

                //     Text("Unit", style: Theme.of(context).textTheme.bodySmall),
                //   ],
                // ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isEditingUnit = true;
                          unitController.text = unitCount.toString();
                        });

                        // open keyboard
                        Future.delayed(const Duration(milliseconds: 50), () {
                          FocusScope.of(context).requestFocus(_unitFocusNode);
                          unitController.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: unitController.text.length,
                          );
                        });
                      },
                      child:
                          isEditingUnit
                              ? SizedBox(
                                width: 60,
                                height: 40,
                                child: KeyboardActions(
                                  config: KeyboardActionsConfig(
                                    keyboardActionsPlatform:
                                        KeyboardActionsPlatform.IOS,
                                    actions: [
                                      KeyboardActionsItem(
                                        focusNode: _unitFocusNode,
                                        toolbarButtons: [
                                          (node) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                right: 12,
                                              ),
                                              child: GestureDetector(
                                                onTap: () => node.unfocus(),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 18,
                                                        vertical: 8,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        onboardingTitleColor, // your brand color
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.12),
                                                        blurRadius: 6,
                                                        offset: const Offset(
                                                          0,
                                                          2,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  child: const Text(
                                                    "Done",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ],
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: unitController,
                                    focusNode: _unitFocusNode,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(
                                          context,
                                        ).textTheme.displaySmall,
                                    decoration: const InputDecoration(
                                      isCollapsed: true,
                                      border: InputBorder.none,
                                    ),
                                    onSubmitted: _applyUnitValue,
                                    onEditingComplete: () {
                                      _applyUnitValue(unitController.text);
                                    },
                                  ),
                                ),
                              )
                              : Text(
                                unitCount.toString().padLeft(2, '0'),
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                    ),
                    Text("Unit", style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),

                const SizedBox(width: 50),

                _unitIconButton(
                  Icons.add,
                  () {
                    setState(() {
                      unitCount++;
                      addwallet = true;
                    });
                  },
                  //  => setState(() => unitCount++),
                  enabled: unitCount < totalUnit,
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _quickUnitChip(5),
                const SizedBox(width: 10),
                _quickUnitChip(10),
                const SizedBox(width: 10),
                _quickUnitChip(20),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(),

            _valueRow("Unit Value", "₹1,00,000.00"),
            const SizedBox(height: 10),
            _valueRow("Coupon Rate", "12.5%"),
          ],
        ),
      ),
    );
  }

  void _applyUnitValue(String value) {
    final parsed = int.tryParse(value);

    if (parsed != null && parsed > 0 && parsed <= totalUnit) {
      setState(() {
        unitCount = parsed;
        addwallet = true;
      });
    }

    setState(() {
      isEditingUnit = false;
    });

    _unitFocusNode.unfocus();
  }

  Widget _unitIconButton(
    IconData icon,
    VoidCallback onTap, {
    required bool enabled,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: enabled ? onboardingTitleColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: enabled ? Colors.white : Colors.grey,
          size: 20,
        ),
      ),
    );
  }

  Widget _quickUnitChip(int value) {
    return GestureDetector(
      onTap: () => setState(() => unitCount = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              unitCount == value
                  ? onboardingTitleColor.withOpacity(.12)
                  : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          "$value Unit",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: unitCount == value ? onboardingTitleColor : Colors.black,
          ),

          // style: TextStyle(
          //   color: unitCount == value ? onboardingTitleColor : Colors.black,
          //   fontWeight: FontWeight.w500,
          // ),
        ),
      ),
    );
  }

  Widget _valueRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget coveredByCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAmpliAssuredSheet(context);
      },
      child: Card(
        elevation: 0.1,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              /// Left section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Covered by",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Image.asset("assets/images/birbal-full.png", height: 30),
                  const SizedBox(width: 6),
                ],
              ),

              const Spacer(),

              /// Right section
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      "View Details",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.chevron_right, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget lowBalanceCard(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Birbalplus pocket",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "₹0.25",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "You don't have enough balance to purchase the selected units.\n"
                    "Please add funds to proceed.",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.red),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: onboardingTitleColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WalletAdd()),
                      );
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

  Widget termsCheckbox(
    BuildContext context,
    bool value,
    Function(bool) onChanged,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.scale(
          scale: 1.0,
          child: Checkbox(
            value: value,
            activeColor: onboardingTitleColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            onChanged: (val) => onChanged(val!),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                const TextSpan(text: "I agree to the "),
                TextSpan(
                  text: "Terms and Conditions",
                  style: TextStyle(color: onboardingTitleColor),
                ),
                const TextSpan(text: ", "),
                TextSpan(
                  text: "Terms of Use",
                  style: TextStyle(color: onboardingTitleColor),
                ),
                const TextSpan(text: " and have read and understood the "),
                TextSpan(
                  text: "Privacy Policy",
                  style: TextStyle(color: onboardingTitleColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
