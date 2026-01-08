import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/constant/input_fields.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  final TextEditingController accountNumberController = TextEditingController(
    text: '98765400103216',
  );
  final TextEditingController ifscController = TextEditingController(
    text: 'HDFC1122007',
  );
  final TextEditingController accountTypeController = TextEditingController(
    text: 'Savings Account',
  );
  final TextEditingController bankNameController = TextEditingController(
    text: 'HDFC Bank',
  );
  bool onOffValye = true;
  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Bank Details',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
            child: Icon(Icons.edit, color: blackColor, size: 20),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),

              if (onOffValye) ...[
                inputField(
                  isEditing: isEditing,
                  context,
                  'Account Number',
                  TextInputType.number,
                  accountNumberController,
                ),

                const SizedBox(height: 15),

                inputField(
                  isEditing: isEditing,
                  context,
                  'IFSC Code',
                  TextInputType.text,
                  ifscController,
                ),

                const SizedBox(height: 15),
                inputField(
                  isEditing: isEditing,
                  context,
                  'Account Type',
                  TextInputType.text,
                  accountTypeController,
                ),

                const SizedBox(height: 15),
                inputField(
                  isEditing: isEditing,
                  context,
                  'Bank Name',
                  TextInputType.name,
                  bankNameController,
                ),

                const SizedBox(height: 15),
                // if (isEditing)
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed:
                          isEditing
                              ? () {
                                setState(() {
                                  isEditing = false;
                                });
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: onboardingTitleColor,
                        foregroundColor: whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                        minimumSize: const Size(0, 48),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isEditing ? whiteColor : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.only(left: 80, right: 80),
                //   child: SizedBox(
                //     width: double.infinity,

                //     child: ElevatedButton(
                //       onPressed:
                // isEditing
                //     ? () {
                //       setState(() {
                //         isEditing = false;
                //       });
                //     }
                //     : null,
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: onboardingTitleColor,
                //         foregroundColor: whiteColor,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8),
                //         ),
                //         elevation: 0,
                //         minimumSize: const Size(0, 48),
                //       ),
                //       child: const Text(
                //         'Update',
                //         style: TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.w600,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
