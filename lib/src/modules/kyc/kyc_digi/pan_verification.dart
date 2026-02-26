import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicediscounting/src/bloc/kyc_bloc/kyc_bloc.dart';
import 'package:invoicediscounting/src/bloc/kyc_bloc/kyc_event.dart';
import 'package:invoicediscounting/src/bloc/kyc_bloc/kyc_state.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/utils/validators.dart';

class VerifyPanScreen extends StatefulWidget {
  const VerifyPanScreen({super.key});

  @override
  State<VerifyPanScreen> createState() => _VerifyPanScreenState();
}

class _VerifyPanScreenState extends State<VerifyPanScreen> {
  bool isPanValidated = false;
  final FocusNode panNumberFocusNode = FocusNode();
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode middleNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final TextEditingController panNumberController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  String generateReferenceId({String prefix = 'KYC'}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(999999);
    return '$prefix$timestamp$random';
  }

  void panResult(KycState state) {
    if (state.panKycResult != null) {
      final result = state.panKycResult!;
      firstNameController.text = result.firstName;
      middleNameController.text = result.middleName;
      lastNameController.text = result.lastName;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,

        iconTheme: IconThemeData(color: blackColor),
        centerTitle: true,
        title: Text(
          "PAN Verification",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: BlocConsumer<KycBloc, KycState>(
        listener: (context, state) {
          if (state.status == KycStatus.error) {
            setState(() {
              isPanValidated = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'PAN verification failed'),
              ),
            );
          } else if (state.status == KycStatus.success &&
              state.panKycResult != null) {
            panResult(state);
            setState(() {
              isPanValidated = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'PAN verification successful'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 420),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please enter your Permanent Account Number (PAN) '
                      'as it appears on your physical card.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),

                    const SizedBox(height: 12),

                    _field(
                      "PAN NUMBER",
                      "Enter PAN Number",
                      TextInputType.text,
                      panNumberFocusNode,
                      context,
                      controller: panNumberController,
                      validator: CommonValidators.panValidator,
                      suffixIcon: isPanValidated,
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
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
                          context.read<KycBloc>().add(
                            PanVerificationRequested(
                              referenceId: generateReferenceId(),
                              documentType: 'PAN_DETAILED',
                              idNumber: panNumberController.text,
                              consent: "Y",
                              consentPurpose: 'To verify PAN for KYC',
                            ),
                          );
                        },
                        child: const Text(
                          'Validate PAN',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    if (isPanValidated) ...[
                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F7EE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.verified, color: Colors.green),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Verification Status',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Identity successfully verified',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'VALID',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Name Fields
                    _field(
                      "FIRST NAME",
                      "Enter First Name",
                      TextInputType.text,
                      firstNameFocusNode,
                      context,
                      controller: firstNameController,
                      isRequired: false,
                    ),
                    const SizedBox(height: 12),
                    _field(
                      "MIDDLE NAME",
                      "Enter Middle Name",
                      TextInputType.text,
                      middleNameFocusNode,
                      context,
                      controller: middleNameController,
                      isRequired: false,
                    ),
                    const SizedBox(height: 12),
                    _field(
                      "LAST NAME",
                      "Enter Last Name",
                      TextInputType.text,
                      lastNameFocusNode,
                      context,
                      controller: lastNameController,
                      isRequired: false,
                    ),

                    const SizedBox(height: 24),

                    // Incorrect info link
                    Center(
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.info_outline),
                        label: const Text('Is this information incorrect?'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
    FormFieldValidator<String>? validator,
    bool suffixIcon = false,
    bool isRequired = true,
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
                ? const Icon(Icons.check_circle, color: Colors.green)
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
              children:
                  isRequired
                      ? const [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]
                      : [],
            ),
          ),

          const SizedBox(height: 8),
          textField,
        ],
      ),
    );
  }
}
