import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user.state.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_event.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/signUp/verify_email_otp.dart';
import 'package:invoicediscounting/src/utils/validators.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailOrPhoneController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: blackColor),
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
                final userBloc = BlocProvider.of<UserBloc>(context);
                userBloc.add(
                  UserLoginRequested(emailOrPhoneController.text.trim(), true),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => VerifyEmailOtp()),
                // );
              }
            },
            child: Text(
              'Submit',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state.status == UserStatus.otpSent) {
            // Only navigate if we're not already on the OTP screen
            final currentRoute = ModalRoute.of(context)?.settings.name;
            if (currentRoute != '/verify-otp') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: '/verify-otp'),
                  builder:
                      (context) => VerifyEmailOtp(
                        emailOrPhoneNumber: emailOrPhoneController.text.trim(),
                      ),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage.toString()),
                ),
              );

            }
          } else if (state.status == UserStatus.otperror) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage.toString()),
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 60),
                    Text(
                      'Enter your email/phone',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      '''We will send OTP to verify it's you''',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 20),

                    _InputField(
                      controller: emailOrPhoneController,
                      label: 'Phone number/email',
                      hint: 'Enter your number or email',
                      keyboardType: TextInputType.emailAddress,
                      validator: CommonValidators.emailOrPhoneValidator,
                    ),

                    Spacer(),

                    Text(
                      'We only support Indian numbers at the moment',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    // /// Continue Button
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 52,
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(builder: (context) => VerifyEmailOtp()),
                    //       );
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: onboardingTitleColor,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //     ),
                    //     child: Text(
                    //       'Continue',
                    //       style: Theme.of(
                    //         context,
                    //       ).textTheme.labelLarge?.copyWith(color: whiteColor),
                    //     ),
                    //   ),
                    // ),

                    // const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const _InputField({
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          ],
        ),

        const SizedBox(height: 8),

        TextFormField(
          cursorColor: onboardingTitleColor,
          controller: controller,
          style: Theme.of(context).textTheme.bodyLarge,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodySmall,

            labelStyle: const TextStyle(color: Colors.grey),

            floatingLabelStyle: TextStyle(color: onboardingTitleColor),

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
        ),
      ],
    );
  }
}
