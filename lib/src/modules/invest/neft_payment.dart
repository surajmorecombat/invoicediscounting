import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoicediscounting/src/components/shimmer/neft_payment_shimmer.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

class PayOfflineScreen extends StatefulWidget {
  const PayOfflineScreen({super.key});

  @override
  State<PayOfflineScreen> createState() => _PayOfflineScreenState();

  static Widget _detailCard(String title, String value, context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 6),
          Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }

  static Widget _copyCard(String title, String value, context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 6),
                Text(value, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy, size: 18),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: value));
            },
          ),
        ],
      ),
    );
  }
}

class _PayOfflineScreenState extends State<PayOfflineScreen> {
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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Pay Offline',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.help_outline, color: Colors.black),
          ),
        ],
      ),
      body:
          isLoading
              ? PayOfflineScreenShimmer(isTablet: isTablet)
              : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 120 : 16,
                  // vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 10,),
                    Text(
                      "₹1,000.00",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Amount to be paid",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),

                    Text(
                      "Account Details",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Use the below details to transfer money using RTGS, NEFT or IMPS",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),

                    PayOfflineScreen._detailCard(
                      "Account Holder Name",
                      "Hemant Gavit",
                      context,
                    ),
                    PayOfflineScreen._copyCard(
                      "Account Number",
                      "TKTTPL35766164",
                      context,
                    ),
                    PayOfflineScreen._copyCard(
                      "IFSC Code",
                      "SBIBOCMSNOC",
                      context,
                    ),
                    PayOfflineScreen._detailCard(
                      "Bank Name",
                      "SBI Bank",
                      context,
                    ),
                    PayOfflineScreen._detailCard(
                      "Account Type",
                      "Current",
                      context,
                    ),

                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F3E9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Please pay only via the bank account linked to your Birbal Plus account. Any transfer from other bank accounts shall be rejected automatically.",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Please be informed that payments might take 1-2 days to be processed. This means you won't be able to invest immediately.",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
