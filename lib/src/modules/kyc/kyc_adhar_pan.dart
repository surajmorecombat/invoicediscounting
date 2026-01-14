import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/kyc/bank_verification.dart';
import 'package:permission_handler/permission_handler.dart';

class KycAddressScreen extends StatefulWidget {
  const KycAddressScreen({super.key});

  @override
  State<KycAddressScreen> createState() => _KycAddressScreenState();
}

class _KycAddressScreenState extends State<KycAddressScreen> {
  final TextEditingController dobController = TextEditingController();
  File? panFile;
  File? aadhaarFile;
    DateTime? selectedDate;
      final TextEditingController dateController = TextEditingController();
   Future<bool> ensureCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

    Future<void> _selectDOB(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary:
                  onboardingTitleColor, 
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: onboardingTitleColor, 
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text =
            '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
      });
    }
  }
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
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: onboardingTitleColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BankVerification()),
              );
            },
            child: Text(
              "Continue",
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: whiteColor),
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
            _uploadBlock("Upload Aadhar Card", context,true, panFile),
            _field("Aadhar Number ", "Enter Aadhar Number", context),
            _field("Address Line ", "Enter your full address", context),
            _field("Pincode", "Enter pincode", context),
            _field("State", "Enter state", context),
            _field("City", "Enter city", context),
            const SizedBox(height: 24),
            // const Text(
            //   "Upload PAN",
            //   style: TextStyle(fontWeight: FontWeight.w600),
            // ),
            // const SizedBox(height: 10),
            _uploadBlock("Upload PAN", context,false, aadhaarFile),
            _field("Name as per PAN", "Full Name", context),
            _field("PAN Number", "ABCD1234F", context),
            _field(
              "DOB",
              "DD/MM/YYYY",
              context,
              icon: Icons.calendar_today,
              readOnly: true,
              onTap:()=> _selectDOB(context),
              // controller: dobController,
              // onTap: () async {

                
                // DateTime? picked = await showDatePicker(
                //   context: context,
                //   //  initialDate: DateTime(2000),
                //   firstDate: DateTime(1950),
                //   lastDate: DateTime.now(),
                // );

                // if (picked != null) {
                //   dobController.text =
                //       "${picked.day.toString().padLeft(2, '0')}/"
                //       "${picked.month.toString().padLeft(2, '0')}/"
                //       "${picked.year}";
                // }
             // },
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
               RichText(
            text: TextSpan(
              text: label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     Text(
          //       label,
          //       style: Theme.of(
          //         context,
          //       ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          //     ),
          //     Icon(Icons.star, color: Colors.red, size: 8),
          //   ],
          // ),

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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: blackColor,
              fontWeight: FontWeight.w500,
            ),
            readOnly: readOnly,
            onTap: onTap,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.bodySmall,

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

  Widget _uploadBlock(String title, context,bool isPan, File? file) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          RichText(
            text: TextSpan(
              text: title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

        // Row(
        //   children: [
        //     Text(
        //       title,
        // style: Theme.of(
        //   context,
        // ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        //     ),
        //     Icon(Icons.star, color: Colors.red, size: 8),
        //   ],
        // ),
        const SizedBox(height: 8),
        //   Text(
        //     title,
        //     style: Theme.of(
        //       context,
        //     ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        //   ),
        // const SizedBox(height: 10),
        GestureDetector(
        onTap: () => showSourceSheet(isPan),
          child: Container(
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
        ),
      ],
    );
  }

   Future<void> pickDocument(bool isPan, ImageSource source) async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: source,
      imageQuality: 30,
    );

    if (picked != null) {
      setState(() {
        if (isPan) {
          panFile = File(picked.path);
        } else {
          aadhaarFile = File(picked.path);
        }
      });
    }
  }

  void showSourceSheet(bool isPan) {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt, size: 20, color: blackColor),
                  title: Text(
                    "Camera",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pickDocument(isPan, ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo, size: 20, color: blackColor),
                  title: Text(
                    "Gallery",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pickDocument(isPan, ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
    );
  }
}
