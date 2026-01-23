import 'package:flutter/material.dart';

import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/kyc/bank_verification.dart';
import 'package:invoicediscounting/src/modules/signUp/processing.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  bool isChecked = false;
  bool isCheckedOne = false;
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
        centerTitle: true,
        title: Text(
          "Review & Submit",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoCard(context, 'Personal Information', [
              infoRow(context, 'First Name:', 'VICKY'),
              infoRow(context, 'Last Name:', 'Rathod'),

              infoRow(context, 'Date of Birth :', '25-12-1997'),
            ]),

                infoCard(context, 'Address Information', [
              const Text(
                'Flat 204, Tranquil Heights, Gangapur Road, Near Sula Junction, Nashik, Nashik 422111 MAHARASHTRA 422111',
                style: TextStyle(color: Colors.black54),
              ),
            ]),

            infoCard(context, 'Documents Details', [
              infoRow(context, 'Aadhar Number', '9876 6541 3214'),
              infoRow(context, 'PAN Number', 'ABCDS9855L'),
            ]),

        

            infoCard(context, 'Bank Details', [
              infoRow(context, 'Bank A/c Number', 'HDFC BANK'),
              infoRow(context, 'IFSC Code', 'EXFB0000456'),
            ]),

            // Text(
            //   textAlign: TextAlign.center,
            //   'You can edit before submitting',
            //   style: Theme.of(context).textTheme.bodyMedium,
            // ),
            Spacer(),

            Text('Consent', style: Theme.of(context).textTheme.bodyLarge),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: 0.75,
                  child: Checkbox(
                    value: isChecked,
                    activeColor: onboardingTitleColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: 0,
                    ),
                    onChanged: (v) => setState(() => isChecked = v!),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'I confirm that the details provided are correct',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: blackColor),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: 0.75,
                  child: Checkbox(
                    value: isCheckedOne,
                    activeColor: onboardingTitleColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: 0,
                    ),
                    onChanged: (v) => setState(() => isCheckedOne = v!),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'I agree to the KYC and regulatory terms',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: blackColor),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BankVerification(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: onboardingTitleColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(0, 48),
                    ),
                    child: Text(
                      'Back',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: onboardingTitleColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerificationProcessing(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: onboardingTitleColor,
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Confirm & Submit',
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(color: whiteColor),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget infoCard(context, String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyLarge),
              const Spacer(),
              const Icon(Icons.edit, size: 18),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget infoRow(context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
