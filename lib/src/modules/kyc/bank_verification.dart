import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user.state.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_event.dart';

import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/constant/storage_constant.dart'
    show storage;

import 'package:invoicediscounting/src/modules/signUp/processing.dart';
import 'package:invoicediscounting/src/utils/validators.dart';

import 'package:permission_handler/permission_handler.dart';

class BankVerification extends StatefulWidget {
  const BankVerification({super.key});

  @override
  State<BankVerification> createState() => _BankVerificationState();
}

class _BankVerificationState extends State<BankVerification> {
  @override
  void initState() {
    super.initState();
    // kycProgesstatus();
  }

  void kycProgesstatus() async {
    String? sessionId = await storage.read(key: 'sessionId');
    final bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(UserKycProgressRequested(sessionId.toString()));
  }

  String? bankPassbookUploadError;
  String? bankChequeUploadError;
  final _formKey = GlobalKey<FormState>();
  final FocusNode accountNumberFocusNode = FocusNode();
  final FocusNode accountHolderFocusNode = FocusNode();
  final FocusNode ifscFocusNode = FocusNode();
  final FocusNode branchNameFocusNode = FocusNode();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountHolderController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController branchNameController = TextEditingController();

  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController bankShortCodeController = TextEditingController();
  File? bankFile;
  String? accountType = "Savings";
  String? selectedDocumentType = "Passbook";
  KycDocType getKycDocType() {
    if (selectedDocumentType == "Cheque") {
      return KycDocType.bankCheque;
    }
    return KycDocType.bankPassbook;
  }

  Future<bool> ensureCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  void ifscData(UserState state) {
    branchNameController.text = state.ifscBankDetails!.branchName;
    bankNameController.text = state.ifscBankDetails!.bankName;
    bankShortCodeController.text = state.ifscBankDetails!.bankShortCode;
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state.status == UserStatus.ifscfetched) {
          ifscData(state);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 500),
              backgroundColor: onboardingTitleColor,
              content: Text(
                state.errorMessage.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        if (state.status == UserStatus.ifscfetchError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 500),
              backgroundColor: Colors.red,
              content: Text(
                state.errorMessage.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        if (state.status == UserStatus.bankAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 500),
              backgroundColor: onboardingTitleColor,
              content: Text(
                state.errorMessage.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerificationProcessing()),
          );
        } else if (state.status == UserStatus.bankAddFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 500),
              backgroundColor: Colors.red,
              content: Text(
                state.errorMessage ?? "Bank details submission failed!",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: backgroundColor,
            iconTheme: IconThemeData(color: blackColor),
            centerTitle: true,
            title: Text(
              "Bank Account Verification",
              style: Theme.of(context).textTheme.headlineMedium,
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final userState = context.read<UserBloc>().state;
                    setState(() {
                      bankPassbookUploadError = null;
                      bankChequeUploadError = null;
                    });
                    if (userState.bankChequeImageUrl == null &&
                        getKycDocType() == KycDocType.bankCheque) {
                      setState(() {
                        bankChequeUploadError = "Please upload a cheque image";
                      });
                      return;
                    } else if (userState.bankPassbookImageUrl == null &&
                        getKycDocType() == KycDocType.bankPassbook) {
                      setState(() {
                        bankPassbookUploadError =
                            "Please upload a passbook image";
                      });
                      return;
                    }
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Review()),
                    // );
                    String? usersId = await storage.read(key: 'usersId');
                    final userBloc = context.read<UserBloc>();
                    final bankDetails = {
                      "bankName": bankNameController.text.trim(),
                      "bankShortCode": bankShortCodeController.text.trim(),
                      "ifscCode": ifscController.text.trim(),
                      "branchName": branchNameController.text.trim(),
                      "bankAddress": "",
                      "accountHolderName": accountHolderController.text.trim(),
                      "accountNumber": accountNumberController.text.trim(),
                      "accountType": accountType == "Savings" ? 0 : 1,
                      "bankAccountProofType":
                          getKycDocType() == KycDocType.bankPassbook ? 0 : 1,
                      "bankAccountProofId":
                          getKycDocType() == KycDocType.bankPassbook
                              ? state.bankPassbookDocId ?? ""
                              : state.bankChequeDocId ?? "",
                    };
                    //
                    userBloc.add(
                      InvestorBankAddRequested(
                        formData: {
                          "usersId": usersId,
                          "bankDetails": bankDetails,
                        },
                      ),
                    );
                  }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Review()),
                  // );

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => VerificationProcessing(),
                  //   ),
                  // );
                },
                child: Text(
                  "Verify & Continue",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 120 : 24,
                  //  vertical: 20,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      documentTypeDropdown(context),
                      SizedBox(height: 10),
                      _uploadBlock(
                        "Upload  Document",
                        context,
                        getKycDocType(),
                      ),
                      SizedBox(height: 5),
                      if (state.bankChequeImageUrl != null &&
                          getKycDocType() == KycDocType.bankCheque)
                        uploadedImagePreview(state.bankChequeImageUrl!),

                      if (state.bankPassbookImageUrl != null &&
                          getKycDocType() == KycDocType.bankPassbook)
                        uploadedImagePreview(state.bankPassbookImageUrl!),

                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10),
                      //   child: Center(
                      //     child: Text(
                      //       'OR',
                      //       style: Theme.of(
                      //         context,
                      //       ).textTheme.bodyLarge?.copyWith(color: greycolor),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 10),
                      _field(
                        "IFSC Code",
                        "Enter IFSC Code",
                        TextInputType.text,
                        ifscFocusNode,
                        context,
                        controller: ifscController,
                        validator: CommonValidators.requiredValidator,
                        suffixIcon: true,
                      ),
                      SizedBox(height: 10),
                      _field(
                        "Account Number",
                        "Enter your bank account number",
                        TextInputType.number,
                        accountNumberFocusNode,
                        context,
                        controller: accountNumberController,
                        validator: CommonValidators.requiredValidator,
                      ),

                      _field(
                        "Account Holder Name",
                        "Enter your full name",

                        TextInputType.text,
                        accountHolderFocusNode,
                        context,
                        controller: accountHolderController,
                        validator: CommonValidators.requiredValidator,
                      ),

                      accountTypeDropdown(context),

                      SizedBox(height: 10),
                      _field(
                        "Branch Name",
                        "Enter your Branch Name",

                        TextInputType.text,
                        branchNameFocusNode,
                        context,
                        controller: branchNameController,
                        validator: CommonValidators.requiredValidator,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget uploadedImagePreview(String imageUrl) {
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
    );
  }

  Widget _uploadBlock(String title, context, KycDocType docType) {
    String? error;
    if (docType == KycDocType.bankPassbook) {
      error = bankPassbookUploadError;
    } else if (docType == KycDocType.bankCheque) {
      error = bankChequeUploadError;
    }
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
          onTap: () => showSourceSheet(docType),
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
                      "Select File",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: blueDark),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    docType == KycDocType.bankPassbook ||
                            docType == KycDocType.bankCheque
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
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Future<void> pickDocument(KycDocType docType, ImageSource source) async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: source,
      imageQuality: 30,
    );

    if (picked != null) {
      setState(() {
        // if (docType == KycDocType.bankPassbook || docType == KycDocType.bankCheque) {
        //   bankFile = File(picked.path);
        // }
        context.read<UserBloc>().add(
          UserFileUploadRequested(filePath: picked.path, docType: docType),
        );
      });
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

  Widget _field(
    String label,
    String hint,
    TextInputType inputType,
    FocusNode? focusNode,
    BuildContext context, {
    TextEditingController? controller,
    VoidCallback? onTap,

    final FormFieldValidator<String>? validator,
    bool suffixIcon = false,
  }) {
    final bool isNumeric =
        inputType == TextInputType.number || inputType == TextInputType.phone;

    final textField = TextFormField(
      validator: validator,
      cursorColor: onboardingTitleColor,
      controller: controller,
      focusNode: focusNode,
      keyboardType: inputType,
      readOnly: onTap != null,
      onTap: onTap,
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
        suffixIcon:
            suffixIcon
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // if (isNumeric) {
                      String ifscCode = ifscController.text.trim();
                      if (ifscCode.isNotEmpty) {
                        context.read<UserBloc>().add(
                          IfscDetailsRequested(ifscCode),
                        );
                      }

                      print('ifsc ifsc ifsc');

                      // }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: onboardingTitleColor,
                        borderRadius: BorderRadius.circular(6),
                      ),

                      width: 80,
                      child: Center(
                        child: Text(
                          'Fetch',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
                : SizedBox.shrink(),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 5),
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
              requestFocusOnTap: false,
              enableSearch: false,

              expandedInsets: EdgeInsets.zero,

              hintText: "Account Type",

              textStyle: Theme.of(context).textTheme.bodyLarge,
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: Theme.of(context).textTheme.bodySmall,
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

  Widget documentTypeDropdown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Document Type',
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
              requestFocusOnTap: false,
              enableSearch: false,

              expandedInsets: EdgeInsets.zero,

              hintText: "Document Type",

              textStyle: Theme.of(context).textTheme.bodyLarge,
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: Theme.of(context).textTheme.bodySmall,
                suffixIconColor: onboardingTitleColor,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: "Passbook", label: "Passbook"),
                DropdownMenuEntry(value: "Cheque", label: "Cheque"),
              ],
              onSelected:
                  (value) => setState(() => selectedDocumentType = value),
            ),
          ),
        ],
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
