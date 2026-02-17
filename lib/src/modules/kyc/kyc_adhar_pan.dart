import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user.state.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_event.dart';

import 'package:invoicediscounting/src/constant/app_color.dart';

import 'package:invoicediscounting/src/modules/kyc/selfie_capture.dart';
import 'package:invoicediscounting/src/utils/validators.dart';

import 'package:permission_handler/permission_handler.dart';

class KycAddressScreen extends StatefulWidget {
  const KycAddressScreen({super.key});

  @override
  State<KycAddressScreen> createState() => _KycAddressScreenState();
}

class _KycAddressScreenState extends State<KycAddressScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController panController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController adharController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  bool isConcentChecked = false;

  Future<bool> ensureCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode panFocusNode = FocusNode();
  final FocusNode dateFocusNode = FocusNode();
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
            '${picked.year}-'
            '${picked.month.toString().padLeft(2, '0')}-'
            '${picked.day.toString().padLeft(2, '0')}';

        // dateController.text =
        //     '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,

        iconTheme: IconThemeData(color: blackColor),
        centerTitle: true,
        title: Text(
          "Personal KYC & Address Details",
          style: Theme.of(context).textTheme.headlineMedium,
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
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => SelfieCapture(
                          name: nameController.text,
                          panId: panController.text,
                          dob: dateController.text,
                          adharId: addressController.text,
                          address: addressController.text,
                        ),
                    // BankVerification()
                  ),
                );
              }
            },
            child: Text(
              'Verify & Continue',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state.status == UserStatus.success &&
              state.uploadedImageUrl != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('File uploaded successfully!')),
            );
          } else if (state.status == UserStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'File upload failed'),
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              // controller: scrollController,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 120 : 16,
                  ),

                  child: Column(
                    children: [
                      Text(
                        'Complete KYC in just a few steps to access full \n investment opportunities',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      const SizedBox(height: 30),

                      buildRow(
                        'Name',
                        buildInput(
                          'Enter Name',
                          context,
                          TextInputType.text,
                          nameFocusNode,
                          nameController,
                          CommonValidators.requiredValidator,
                        ),
                      ),
                      // SizedBox(height: 10),
                      buildRow("PAN Details", buildUploadBox(KycDocType.pan)),

                      // buildUploadBox(KycDocType.pan),
                      if (state.panImageUrl != null)
                        uploadedImagePreview(state.panImageUrl!, false),

                      SizedBox(height: 10),
                      buildRow(
                        'PAN Number',
                        buildInput(
                          'Your PAN Number',
                          context,
                          TextInputType.name,
                          panFocusNode,
                          panController,
                          CommonValidators.requiredValidator,
                        ),
                      ),
                      // SizedBox(height: 5),
                      buildRow('Birth Date', buildDateInput(context)),
                      // SizedBox(height: 5),
                      buildRow(
                        "Aadhaar Front",
                        buildUploadBox(KycDocType.aadhaarFront),
                      ),
                      if (state.aadhaarFrontImageUrl != null)
                        uploadedImagePreview(
                          state.aadhaarFrontImageUrl!,
                          true,
                          isFront: true,
                        ),
                      SizedBox(height: 10),
                      buildRow(
                        "Aadhaar Back",
                        buildUploadBox(KycDocType.aadhaarBack),
                      ),

                      // buildUploadBox(KycDocType.aadhaarBack),
                      if (state.aadhaarBackImageUrl != null)
                        uploadedImagePreview(state.aadhaarBackImageUrl!, true),
                      SizedBox(height: 10),

                      buildRow(
                        'Aadhar Number',
                        buildInput(
                          'Your Aadhar Number',
                          context,
                          TextInputType.number,
                          aadhaarFocusNode,
                          adharController,

                          CommonValidators.requiredValidator,
                        ),
                      ),

                      buildRow(
                        'Address',
                        buildInput(
                          'Enter Address',
                          context,
                          TextInputType.text,
                          addressFocusNode,
                          addressController,

                          CommonValidators.requiredValidator,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Checkbox(
                            activeColor: onboardingTitleColor,
                            value: isConcentChecked,
                            onChanged: (value) {
                              setState(() {
                                isConcentChecked = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'I authorize  ',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  TextSpan(
                                    text: 'BirbalPlus  ',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),

                                  TextSpan(
                                    text:
                                        'to fetch and update my KYC records with KRAs as required by SEBI regulations.',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget uploadedImagePreview(
    String imageUrl,
    bool isAadhaar, {
    bool isFront = false,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullScreenImage(imageUrl: imageUrl),
          ),
        );
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 80),
          child: Stack(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (_, __, ___) {
                      return const Center(child: Icon(Icons.broken_image));
                    },
                  ),
                ),
              ),
            ],
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
    final TextEditingController controller,
    final FormFieldValidator<String>? validator,
  ) {
    // final bool isNumeric =
    //     inputType == TextInputType.number || inputType == TextInputType.phone;

    // final textField =
    return TextFormField(
      cursorColor: onboardingTitleColor,
      controller: controller,
      focusNode: focusNode,
      keyboardType: inputType,
      validator: validator,

      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodySmall,
   
         enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: const BorderSide(color: Colors.grey),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: onboardingTitleColor, width: 1.6),
            ),
      ),
    );
    // if (!isNumeric || focusNode == null) return textField;

    // return SizedBox(height: 60, child: textField);
  }

  Widget buildDateInput(context) {
    return TextField(
      cursorColor: onboardingTitleColor,
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

  Widget buildUploadBox(KycDocType docType) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: adharBox,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: greycolor),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => showSourceSheet(docType),
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: adharInnerBox,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  "Select File",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: blueDark),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Drop files here to upload",
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: onboardingTitleColor),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> pickDocument(KycDocType docType, ImageSource source) async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: source,
      imageQuality: 30,
    );

    if (picked != null) {
      context.read<UserBloc>().add(
        UserFileUploadRequested(filePath: picked.path, docType: docType),
      );
    }
  }

  void showSourceSheet(KycDocType docType) {
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
                    pickDocument(docType, ImageSource.camera);
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
                    pickDocument(docType, ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 4,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const CircularProgressIndicator(color: Colors.white);
            },
          ),
        ),
      ),
    );
  }
}
