import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoicediscounting/src/components/keyboard_done.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/kyc/bank_verification.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:permission_handler/permission_handler.dart';

class KycAddressScreen extends StatefulWidget {
  const KycAddressScreen({super.key});

  @override
  State<KycAddressScreen> createState() => _KycAddressScreenState();
}

class _KycAddressScreenState extends State<KycAddressScreen> {
  final TextEditingController dateController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  DateTime? selectedDate;
  bool isConcentChecked = false;
  File? panFile;
  File? aadhaarFile;
  Future<bool> ensureCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  final FocusNode panFocusNode = FocusNode();
  final FocusNode aadhaarFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();

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
              primary: onboardingTitleColor,
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
      // resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,

        iconTheme: IconThemeData(color: blackColor),
        centerTitle: true,
        title: Text(
          "Personal KYC & Address Details",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
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
                MaterialPageRoute(builder: (context) => BankVerification()),
              );
            },
            child: Text(
              'Verify & Continue',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // controller: scrollController,
          child: Padding(
             padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
            
            child: Column(
              children: [
                // Text(
                //   'Complete your KYC',
                //   textAlign: TextAlign.center,
                //   style: Theme.of(context).textTheme.displaySmall
                //       ?.copyWith(color: onboardingTitleColor),
                // ),
        
                // const SizedBox(height: 10),
                Text(
                  'Complete KYC in just a few steps to access full \n investment opportunities',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
        
                const SizedBox(height: 30),
        
                buildRow("PAN Details", buildUploadBox(true, panFile)),
        
                Center(
                  child: Text(
                    'Or',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: greycolor),
                  ),
                ),
                SizedBox(height: 10),
        
                buildRow(
                  'PAN number',
                  buildInput(
                    'Your PAN Number',
                    context,
                    TextInputType.number,
                    panFocusNode,
                  ),
                ),
                SizedBox(height: 10),
                buildRow('Birth date', buildDateInput(context)),
                buildRow("Aadhaar Details", buildUploadBox(false, aadhaarFile)),
                Center(
                  child: Text(
                    'Or',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: greycolor),
                  ),
                ),
                SizedBox(height: 10),
                buildRow(
                  'Aadhar number',
                  buildInput(
                    'Your Aadhar Number',
                    context,
                    TextInputType.number,
                    aadhaarFocusNode,
                  ),
                ),
                SizedBox(height: 10),
                buildRow(
                  'Address',
                  buildInput(
                    'Enter address',
                    context,
                    TextInputType.text,
                    addressFocusNode,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(String label, Widget field) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: blackColor),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: field),
        ],
      ),
    );
  }

  Widget buildInput(
    String hint,
    BuildContext context,
    TextInputType inputType,
    FocusNode? focusNode,
  ) {
    final bool isNumeric =
        inputType == TextInputType.number || inputType == TextInputType.phone;

    final textField = TextField(
      // controller: controller,
      focusNode: focusNode,
      keyboardType: inputType,
      // readOnly: onTap != null, // ✅ for date picker fields
      // onTap: onTap,
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
    if (!isNumeric || focusNode == null) return textField;

    return SizedBox(
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
    );
  }


  Widget buildDateInput(context) {
    return TextField(
      readOnly: true,
      controller: dateController,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: 'DD-MM-YYYY',
        hintStyle: Theme.of(context).textTheme.bodySmall,
        suffixIcon: Icon(
          Icons.calendar_today,
          size: 20,
          color: onboardingTitleColor,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        labelStyle: const TextStyle(color: Colors.grey),

        floatingLabelStyle: TextStyle(color: onboardingTitleColor),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: onboardingTitleColor, width: 1.6),
        ),
      ),
      onTap: () {
        _selectDOB(context);
        FocusScope.of(context).unfocus();
      },
    );
  }

  Widget buildUploadBox(bool isPan, File? file) {
    return GestureDetector(
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
                file == null ? "Drop files here to upload" : "File selected ✓",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: onboardingTitleColor),
              ),
            ),
          ],
        ),
      ),
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
