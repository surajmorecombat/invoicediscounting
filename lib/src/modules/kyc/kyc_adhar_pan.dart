import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/kyc/bank_verification.dart';

class KycAddressScreen extends StatefulWidget {
  const KycAddressScreen({super.key});

  @override
  State<KycAddressScreen> createState() => _KycAddressScreenState();
}

class _KycAddressScreenState extends State<KycAddressScreen> {
  final TextEditingController dobController = TextEditingController();

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
          "Personal KYC & Address Details",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            backgroundColor: onboardingTitleColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>BankVerification()));
          },
          child: const Text(
            "Continue",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 120 : 24,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _uploadBlock("Upload Aadhar Card (both side)", context),
            _field("Aadhar Number ", "Enter Aadhar Number", context),
            _field("Address Line ", "Enter your full address", context),
            _field("Pincode", "Enter pincode", context),
            _field("State", "Enter state", context),
            _field("City", "Enter city", context),
            const SizedBox(height: 24),
            const Text(
              "Upload PAN",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            _uploadBlock("", context),
            _field("Name as per PAN", "Full Name", context),
            _field("PAN Number*", "ABCD1234F", context),
            _field(
              "DOB",
              "DD/MM/YYYY",
              context,
              icon: Icons.calendar_today,
              readOnly: true,
              controller: dobController,
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  //  initialDate: DateTime(2000),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                );

                if (picked != null) {
                  dobController.text =
                      "${picked.day.toString().padLeft(2, '0')}/"
                      "${picked.month.toString().padLeft(2, '0')}/"
                      "${picked.year}";
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    String label,
    String hint,
    context, {
    IconData? icon,
    TextEditingController? controller,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              Icon(Icons.star, color: Colors.red, size: 8),
            ],
          ),

          const SizedBox(height: 8),
          // Text(
          //   label,
          //   style: Theme.of(
          //     context,
          //   ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          // ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            style: Theme.of(context).textTheme.bodyLarge,
            readOnly: readOnly,
            onTap: onTap,
            decoration: InputDecoration(
              hintText: hint,

              suffixIcon:
                  icon != null ? Icon(icon, color: onboardingTitleColor) : null,
              filled: true,
              fillColor: const Color(0xFFF2F6FB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _uploadBlock(String title, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Row(
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              Icon(Icons.star, color: Colors.red, size: 8),
            ],
          ),

        const SizedBox(height: 8),
        //   Text(
        //     title,
        //     style: Theme.of(
        //       context,
        //     ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        //   ),
        // const SizedBox(height: 10),
        Container(
          height: 90,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade300,
              style: BorderStyle.solid,
            ),
            color: const Color(0xFFF2F6FB),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.cloud_upload_outlined, size: 30, color: Colors.grey),
              SizedBox(height: 6),
              Text("Upload file", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}
