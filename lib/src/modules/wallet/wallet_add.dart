import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/invest/payment_method.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class WalletAdd extends StatefulWidget {
  const WalletAdd({super.key});

  @override
  State<WalletAdd> createState() => _WalletAddState();
}

class _WalletAddState extends State<WalletAdd> {
  final TextEditingController amountController = TextEditingController();

  int selectedAmount = 000000;
  final FocusNode amountFocusNode = FocusNode();

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
          height: 52,
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
                MaterialPageRoute(builder: (context) => SelectPaymentMethod()),
              );
            },
            // onPressed: null,
            child: Text(
              'Continue',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
      //  Container(
      //   padding: const EdgeInsets.all(16),
      //   color: Colors.white,
      //   child: SizedBox(
      //          height: 52,
      //     child: Row(
      //       children: [
      //         Expanded(
      //           child: OutlinedButton(
      //             onPressed: () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => SelectPaymentMethod(),
      //   ),
      // );
      //             },
      //             style: OutlinedButton.styleFrom(
      //               backgroundColor: onboardingTitleColor,
      //               // side: BorderSide(color: onboardingTitleColor, width: 1),
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(6),
      //               ),
      //             ),
      //             child: Text(
      //               "Continue",
      //               style: Theme.of(
      //                 context,
      //               ).textTheme.labelLarge?.copyWith(color: whiteColor),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
        child: Card(
          elevation: 0.1,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Wallet Balance",
                  style: Theme.of(context).textTheme.displaySmall,
                ),

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.only(left: 80, right: 80),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: greycolor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: KeyboardActions(
                      config: KeyboardActionsConfig(
                        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
                        actions: [
                          KeyboardActionsItem(
                            focusNode: amountFocusNode,
                            toolbarButtons: [
                              (node) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: GestureDetector(
                                    onTap: () => node.unfocus(),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            onboardingTitleColor, // your brand color
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.12,
                                            ),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Text(
                                        "Done",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
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
                         cursorColor: onboardingTitleColor,
                        controller: amountController,
                        focusNode: amountFocusNode,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                          signed: false,
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.currency_rupee,
                            size: 15,
                            color: blackColor,
                          ),
                          hintText: 'Enter Amount',
                          hintStyle: Theme.of(context).textTheme.bodySmall,
                          border: InputBorder.none,
                          isCollapsed: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedAmount =
                                int.tryParse(value.replaceAll(',', '')) ?? 0;
                          });
                        },
                      ),
                    ),
                  ),
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
      onTap: () {
        setState(() {
          selectedAmount = amount;
          amountController.text = amount.toString();
        });
      },
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
}
