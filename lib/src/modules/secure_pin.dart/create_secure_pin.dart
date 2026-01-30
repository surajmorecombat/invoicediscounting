import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/kyc/kyc_adhar_pan.dart';

import 'package:keyboard_actions/keyboard_actions.dart';

class CreateSecurePin extends StatefulWidget {
  const CreateSecurePin({super.key});

  @override
  State<CreateSecurePin> createState() => _CreateSecurePinState();
}

class _CreateSecurePinState extends State<CreateSecurePin> {
  final List<TextEditingController> _controllersone = List.generate(
    4,
    (_) => TextEditingController(),
  );

  final List<TextEditingController> _controllerstwo = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodesone = List.generate(4, (_) => FocusNode());
  final List<FocusNode> _focusNodestwo = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllersone) {
      c.dispose();
    }

    for (final c in _controllerstwo) {
      c.dispose();
    }
    for (final f in _focusNodesone) {
      f.dispose();
    }

    for (final f in _focusNodestwo) {
      f.dispose();
    }
    super.dispose();
  }

  void _onPinChangedOne(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      _focusNodesone[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodesone[index - 1].requestFocus();
    }
  }

  void _onPinChangeTwo(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      _focusNodestwo[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodestwo[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          'Create PIN',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: blackColor),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KycAddressScreen()),
              );
            },
            child: Text('Skip', style: TextStyle(color: blackColor)),
          ),
        ],
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
                MaterialPageRoute(builder: (context) => KycAddressScreen()),
              );
            },
            child: Text(
              'Create',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                'Enter your secure PIN',
                style: Theme.of(context).textTheme.displaySmall,
              ),

              const SizedBox(height: 6),
              Text(
                "This allows you to access your investment",
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 32),

              Text(
                'Create your secure PIN',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    width: 60,
                    height: 60,
                    child: KeyboardActions(
                      config: KeyboardActionsConfig(
                        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
                        actions: [
                          KeyboardActionsItem(
                            focusNode: _focusNodesone[index],
                            toolbarButtons: [
                              (node) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: GestureDetector(
                                    onTap: () => node.unfocus(),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            onboardingTitleColor, // your brand color
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.12,
                                            ),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Text(
                                        "Done",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ],
                          ),
                        ],
                      ),
                      child: TextField(
                         cursorColor: onboardingTitleColor,
                        controller: _controllersone[index],
                        focusNode: _focusNodesone[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: Theme.of(context).textTheme.bodyLarge,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: borderColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: onboardingTitleColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                        onChanged: (value) => _onPinChangedOne(value, index),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Text('Confirm PIN', style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    width: 60,
                    height: 60,
                    child: KeyboardActions(
                      config: KeyboardActionsConfig(
                        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
                        actions: [
                          KeyboardActionsItem(
                            focusNode: _focusNodestwo[index],
                            toolbarButtons: [
                              (node) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: GestureDetector(
                                    onTap: () => node.unfocus(),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            onboardingTitleColor, // your brand color
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.12,
                                            ),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Text(
                                        "Done",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ],
                          ),
                        ],
                      ),
                      child: TextField(
                         cursorColor: onboardingTitleColor,
                        controller: _controllerstwo[index],
                        focusNode: _focusNodestwo[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: Theme.of(context).textTheme.bodyLarge,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: borderColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: onboardingTitleColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                        onChanged: (value) => _onPinChangeTwo(value, index),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Forget your PIN? ",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: onboardingTitleColor,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Reset PIN?",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: onboardingTitleColor,
                    ),
                  ),
                ],
              ),

              // const Spacer(),

              // SizedBox(
              //   width: double.infinity,
              //   height: 52,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: onboardingTitleColor,
              //       shape: const StadiumBorder(),
              //     ),
              //     onPressed: () {
              //       Navigator.pushReplacement(
              //         context,
              //         MaterialPageRoute(builder: (context) => HomeScreen()),
              //       );
              //     },
              //     child: Text(
              //       'Create',
              //       style: Theme.of(context).textTheme.labelLarge,
              //     ),
              //   ),
              // ),

              // const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
