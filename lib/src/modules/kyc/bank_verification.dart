import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoicediscounting/src/components/keyboard_done.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/kyc/review.dart';
import 'package:invoicediscounting/src/modules/signUp/processing.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:permission_handler/permission_handler.dart';

class BankVerification extends StatefulWidget {
  const BankVerification({super.key});

  @override
  State<BankVerification> createState() => _BankVerificationState();
}

class _BankVerificationState extends State<BankVerification> {
  final FocusNode accountNumberFocusNode = FocusNode();
  final FocusNode accountHolderFocusNode = FocusNode();
  final FocusNode ifscFocusNode = FocusNode();
  File? panFile;
  String? accountType;
  Future<bool> ensureCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
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
          "Bank Account Verification",
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Review()),
              // );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerificationProcessing(),
                ),
              );
            },
            child: const Text(
              "Verify & Continue",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 120 : 24,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _uploadBlock("Upload  Passbook/Check", context, true, panFile),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      'Or',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: greycolor),
                    ),
                  ),
                ),
                _field(
                  "Account Number",
                  "Enter your bank account number",
                  TextInputType.number,
                  accountNumberFocusNode,
                  context,
                ),
                _field(
                  "Account Holder Name",
                  "Enter your full name",
        
                  TextInputType.text,
                  accountHolderFocusNode,
                  context,
                ),
        
                accountTypeDropdown(context),
                _field(
                  "IFSC Code",
                  "Enter IFSC Code",
                  TextInputType.text,
                  ifscFocusNode,
                  context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _uploadBlock(String title, context, bool isPan, File? file) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (title.isNotEmpty)
        RichText(
          text: TextSpan(
            text: title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            children: [
              // TextSpan(
              //   text: '*',
              //   style: TextStyle(
              //     fontSize: 12,
              //     color: Colors.red,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ),

        // Row(
        //   children: [
        //     Text(
        //       title,
        //       style: Theme.of(
        //         context,
        //       ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: adharBox,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: greycolor),
            ),
            child: Row(
              children: [
                Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: adharInnerBox,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      file == null ? "Select file" : "Change file",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: blueDark),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    file == null
                        ? "Drop files here to upload"
                        : "File selected ✓",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: onboardingTitleColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // GestureDetector(
        //   onTap: () => showSourceSheet(isPan),
        //   child: Container(
        //     padding: EdgeInsets.all(10),
        //     width: double.infinity,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(12),
        //       border: Border.all(
        //         color: Colors.grey.shade300,
        //         style: BorderStyle.solid,
        //       ),
        //       color: const Color(0xFFF2F6FB),
        //     ),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: const [
        //         Icon(Icons.cloud_upload_outlined, size: 30, color: Colors.grey),
        //         SizedBox(height: 6),
        //         Text("Upload file", style: TextStyle(color: Colors.grey)),
        //       ],
        //     ),
        //   ),
        // ),
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

  Widget _field(
    String label,
    String hint,
    TextInputType inputType,
    FocusNode? focusNode,
    BuildContext context, {
    TextEditingController? controller,
    VoidCallback? onTap,
  }) {
    final bool isNumeric =
        inputType == TextInputType.number || inputType == TextInputType.phone;

    final textField = TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: inputType,
      readOnly: onTap != null, // ✅ for date picker fields
      onTap: onTap,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodySmall,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: onboardingTitleColor, width: 1.6),
        ),
      ),
    );

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
              children: const [
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

          const SizedBox(height: 8),

          // ✅ ONLY numeric fields get KeyboardActions
          if (isNumeric && focusNode != null)
            SizedBox(
              height: 60,
              child: KeyboardActions(
                config: KeyboardActionsConfig(
                  keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
                  actions: [
                    KeyboardActionsItem(
                      focusNode: focusNode,
                      toolbarButtons: [(node) => styledDoneButton(node)],
                    ),
                  ],
                ),
                child: textField,
              ),
            )
          else
            textField,
        ],
      ),
    );
  }

  Widget accountTypeDropdown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Account Type',
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

          SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: DropdownMenu<String>(
              requestFocusOnTap: true,
              enableSearch: false,

              expandedInsets: EdgeInsets.zero,

              hintText: "Account Type",
              textStyle: Theme.of(context).textTheme.bodyLarge,
              inputDecorationTheme: InputDecorationTheme(
                suffixIconColor: onboardingTitleColor,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: "Savings", label: "Savings"),
                DropdownMenuEntry(value: "Current", label: "Current"),
              ],
              onSelected: (value) => setState(() => accountType = value),
            ),
          ),
        ],
      ),
    );
  }
}
