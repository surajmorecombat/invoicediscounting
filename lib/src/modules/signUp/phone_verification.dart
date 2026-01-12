// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:invoicediscounting/src/constant/app_color.dart';
// import 'package:invoicediscounting/src/modules/kyc/kyc_adhar_pan.dart';
// import 'package:invoicediscounting/src/modules/signUp/processing.dart';

// class OtpVerificationScreen extends StatefulWidget {
//   const OtpVerificationScreen({super.key});

//   @override
//   State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
// }

// class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
//   bool showOtpSection = false;
//   bool allowEdit = false;
//   Timer? _otpTimer;
//   final List<TextEditingController> _controllers = List.generate(
//     6,
//     (_) => TextEditingController(),
//   );

//   final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

//   int seconds = 29;

//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }

//   void startTimer() {
//     _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (!mounted) {
//         timer.cancel();
//         return;
//       }

//       if (seconds == 0) {
//         timer.cancel();
//       } else {
//         setState(() => seconds--);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _otpTimer?.cancel();
//     for (final c in _controllers) {
//       c.dispose();
//     }
//     for (final f in _focusNodes) {
//       f.dispose();
//     }
//     super.dispose();
//   }

//   void _onOtpChanged(String value, int index) {
//     if (value.isNotEmpty && index < 5) {
//       _focusNodes[index + 1].requestFocus();
//     } else if (value.isEmpty && index > 0) {
//       _focusNodes[index - 1].requestFocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool isTablet = MediaQuery.of(context).size.width >= 600;
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: backgroundColor,
//         elevation: 0,
//         iconTheme: IconThemeData(color: blackColor),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: isTablet ? 120 : 24,
//             vertical: isTablet ? 100 : 50,
//           ),
//           child: Column(
//             children: [
//               const SizedBox(height: 80),

//               TextField(
//                 keyboardType: TextInputType.phone,
//                 style: Theme.of(context).textTheme.bodyLarge,
//                 decoration: InputDecoration(
//                   labelText: 'Phone Number',

//                   labelStyle: const TextStyle(color: Colors.grey),

//                   floatingLabelStyle: TextStyle(color: onboardingTitleColor),

//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(color: Colors.grey),
//                   ),

//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(
//                       color: onboardingTitleColor,
//                       width: 1.6,
//                     ),
//                   ),
//                 ),
//                 // decoration: InputDecoration(
//                 //   labelText: 'Phone Number',
//                 //   hintText: 'Enter your mobile number',
//                 //   border: OutlineInputBorder(
//                 //     borderRadius: BorderRadius.circular(8),
//                 //   ),
//                 //   isDense: true,
//                 //   contentPadding: EdgeInsets.symmetric(
//                 //     vertical: 15,
//                 //     horizontal: 10,
//                 //   ),
//                 // ),
//               ),

//               const SizedBox(height: 25),

//               SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: onboardingTitleColor,
//                     foregroundColor: whiteColor,
//                     shape: const StadiumBorder(),
//                     elevation: 0,
//                   ),
//                   onPressed:
//                       showOtpSection
//                           ? null
//                           : () {
//                             setState(() {
//                               showOtpSection = true;
//                               allowEdit = true;
//                             });
//                           },
//                   // onPressed: () {
//                   //   //            Navigator.pushReplacement(
//                   //   //   context,
//                   //   //   MaterialPageRoute(builder: (context) =>
//                   //   //   //EnterSecurePin()
//                   //   //   CreateSecurePin()
//                   //   //   ),
//                   //   // );
//                   // },
//                   child: Text(
//                     'Continue',
//                     style: Theme.of(context).textTheme.labelLarge,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 24),

//               if (showOtpSection)
//                 Column(
//                   children: [
//                     Text(
//                       'Verify OTP',
//                       style: Theme.of(context).textTheme.displaySmall,
//                     ),

//                     const SizedBox(height: 6),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           '''we have sent OTP to 9988558899''',
//                           textAlign: TextAlign.center,

//                           style: Theme.of(
//                             context,
//                           ).textTheme.bodyMedium?.copyWith(color: blackColor),
//                         ),
//                         SizedBox(width: 5),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               showOtpSection = false;
//                             });
//                           },
//                           child: Icon(Icons.edit, size: 16, color: blackColor),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 32),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: List.generate(
//                         6,
//                         (index) => SizedBox(
//                           width: 50,
//                           height: 50,
//                           child: TextField(
//                             controller: _controllers[index],
//                             focusNode: _focusNodes[index],
//                             keyboardType: TextInputType.number,
//                             textAlign: TextAlign.center,
//                             maxLength: 1,
//                             style: Theme.of(context).textTheme.bodyLarge,

//                             decoration: InputDecoration(
//                               counterText: '',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 borderSide: BorderSide(color: borderColor),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 borderSide: BorderSide(
//                                   color: onboardingTitleColor,
//                                   width: 1.5,
//                                 ),
//                               ),
//                             ),
//                             onChanged: (value) => _onOtpChanged(value, index),
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     Center(
//                       child: Text.rich(
//                         TextSpan(
//                           children: [
//                             TextSpan(
//                               text: 'Expect OTP in',
//                               style: Theme.of(context).textTheme.bodySmall,
//                             ),
//                             TextSpan(
//                               text: ' 29 seconds',
//                               style: Theme.of(
//                                 context,
//                               ).textTheme.bodyMedium?.copyWith(
//                                 fontWeight: FontWeight.w700,
//                                 color: blackColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 24),

//                     SizedBox(
//                       width: double.infinity,
//                       height: 52,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: onboardingTitleColor,
//                           foregroundColor: whiteColor,
//                           shape: const StadiumBorder(),
//                           elevation: 0,
//                         ),
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder:
//                                   (context) =>KycAddressScreen()
//                                       //EnterSecurePin()
//                                      // VerificationProcessing(),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           'Verify OTP',
//                           style: Theme.of(context).textTheme.labelLarge,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
