import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicediscounting/src/bloc/kyc_bloc/kyc_bloc.dart';
import 'package:invoicediscounting/src/bloc/kyc_bloc/kyc_event.dart';
import 'package:invoicediscounting/src/bloc/kyc_bloc/kyc_state.dart';

import 'package:invoicediscounting/src/constant/app_color.dart';

import 'package:invoicediscounting/src/modules/kyc/kyc_adhar_pan.dart';

import 'package:url_launcher/url_launcher.dart';

// class KycOpt extends StatefulWidget {
//   const KycOpt({super.key});

//   @override
//   State<KycOpt> createState() => _KycOptState();
// }

// class _KycOptState extends State<KycOpt> {
//   String generateReferenceId({String prefix = 'KYC'}) {
//     final timestamp = DateTime.now().millisecondsSinceEpoch;
//     final random = Random().nextInt(999999);
//     return '$prefix$timestamp$random';
//   }

//   Future<void> openDigiLockerUrl(String url) async {
//     final uri = Uri.parse(url);

//     if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//       throw 'Could not open DigiLocker';
//     }
//   }
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   kycProgesstatus();
//   // }

//   // void kycProgesstatus() async {
//   //   String? sessionId = await storage.read(key: 'sessionId');
//   //   final bloc = BlocProvider.of<UserBloc>(context);
//   //   bloc.add(UserKycProgressRequested(sessionId.toString()));
//   // }

//   void _openDigiLocker(BuildContext context) {
//     final kycBloc = context.read<KycBloc>();
//     kycBloc.add(
//       GetDigiSessionRequested(
//         consent: true,
//         consentPurpose: 'for banking purpose only',
//         referenceId: generateReferenceId(),
//         redirectToSignup: true,
//         redirectUrl: "https://decentro.tech",
//         documentConsent: ["ADHAR", "PANCR", "DRIVING_LICENSE"],
//       ),
//     );
//   }

//   void _openManual(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (c) => KycAddressScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool isTablet = MediaQuery.of(context).size.width >= 600;

//     return BlocListener(listener: (context,state){

//     Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: backgroundColor,
//         elevation: 0,

//         iconTheme: IconThemeData(color: blackColor),
//         centerTitle: true,
//         title: Text(
//           'KYC Verification',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Choose how you want to complete your KYC',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'We’re using DigiLocker for instant, digital verification. It’s government-approved, protects your privacy, and takes just minutes.',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//             const SizedBox(height: 20),
//             _KycOptionCard(
//               icon: Icons.cloud,
//               title: 'DigiLocker',
//               subtitle:
//                   'Fetch your documents securely from DigiLocker (recommended).',
//               onTap: () => _openDigiLocker(context),
//             ),
//             const SizedBox(height: 12),
//             _KycOptionCard(
//               icon: Icons.upload_file,
//               title: 'Manual Upload',
//               subtitle:
//                   'Upload identity and address documents manually from your device.',
//               onTap: () => _openManual(context),
//             ),
//             const SizedBox(height: 20),
//             // TextButton(
//             //   onPressed: () => Navigator.pop(context),
//             //   child: const Text('Cancel'),
//             // ),
//           ],
//         ),
//       ),
//     );
//     });
//     // BlocListener<KycBloc, KycState>(listener: (context,state){
//     //   if (state.status == KycStatus.success &&
//     //     state.sessionUrl != null) {
//     //   openDigiLockerUrl(state.sessionUrl!);
//     // }

//     // if (state.status == KycStatus.error) {
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     SnackBar(content: Text('Failed to start DigiLocker')),
//     //   );
//     // }

//     // },)

//   }
// }

// class _KycOptionCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final VoidCallback onTap;

//   const _KycOptionCard({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(8),
//         onTap: onTap,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 radius: 26,
//                 backgroundColor: lightblue,
//                 child: Icon(icon, color: onboardingTitleColor),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(title, style: theme.textTheme.bodyMedium),
//                     const SizedBox(height: 4),
//                     Text(subtitle, style: theme.textTheme.bodyMedium),
//                   ],
//                 ),
//               ),
//               const Icon(Icons.chevron_right),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import your bloc files
// import 'kyc_bloc.dart';
// import 'kyc_state.dart';
// import 'kyc_event.dart';

class KycOpt extends StatefulWidget {
  const KycOpt({super.key});

  @override
  State<KycOpt> createState() => _KycOptState();
}

class _KycOptState extends State<KycOpt> {
  // ✅ Generate unique reference ID
  String generateReferenceId({String prefix = 'KYC'}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(999999);
    return '$prefix$timestamp$random';
  }

  // ✅ Open DigiLocker in external browser
  Future<void> openDigiLockerUrl(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not open DigiLocker';
    }
  }

  void _openDigiLocker(BuildContext context) {
    context.read<KycBloc>().add(
      GetDigiSessionRequested(
        consent: true,
        consentPurpose: 'for banking purpose only',
        referenceId: generateReferenceId(),
        redirectToSignup: true,
        redirectUrl: "https://decentro.tech",
        documentConsent: ["ADHAR", "PANCR", "DRIVING_LICENSE"],
      ),
    );
  }

  void _openManual(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => KycAddressScreen()),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return BlocListener<KycBloc, KycState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == KycStatus.success && state.sessionUrl != null) {
          openDigiLockerUrl(state.sessionUrl!);
        }
        if (state.status == KycStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to start DigiLocker')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FC),
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,

          iconTheme: IconThemeData(color: blackColor),
          centerTitle: true,
          title: Text(
            'Choose verification method',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Complete your KYC to start investing securely\nwith our protected platform.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),

              /// DigiLocker Card
              _KycOptionTile(
                recommended: true,
                title: 'DigiLocker KYC',
                subtitle:
                    'Instantly verify using your Aadhaar.\nNo documents needed. Secure and encrypted.',
                footer: 'Verified in < 1 min',
                icon: Icons.cloud,
                onTap: () => _openDigiLocker(context),
              ),

              const SizedBox(height: 16),

              /// Manual Card
              _KycOptionTile(
                recommended: false,
                title: 'Manual KYC',
                subtitle:
                    'Upload photos of your ID and address\nproof. For users without DigiLocker.',
                footer: 'Takes 24–48 hours',
                icon: Icons.upload_file,
                onTap: () => _openManual(context),
              ),

              const SizedBox(height: 24),

              /// Footer Info
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF4FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.shield, color: Color(0xFF2563EB)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Your data is encrypted and stored securely. '
                        'We only use it for identity verification purposes '
                        'as per financial regulations.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              TextButton(
                onPressed: () {},
                child: const Text(
                  'Need Help?',
                  style: TextStyle(color: Color(0xFF2563EB)),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _KycOptionTile extends StatelessWidget {
  final bool recommended;
  final String title;
  final String subtitle;
  final String footer;
  final IconData icon;
  final VoidCallback onTap;

  const _KycOptionTile({
    required this.recommended,
    required this.title,
    required this.subtitle,
    required this.footer,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor =
        recommended ? const Color(0xFF2563EB) : Colors.grey.shade300;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header row (icon + badge)
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor:
                      recommended ? const Color(0xFFEFF4FF) : Colors.grey[200],
                  child: Icon(
                    icon,
                    color:
                        recommended ? const Color(0xFF2563EB) : Colors.black54,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                if (recommended)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2563EB),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'RECOMMENDED • FASTEST',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              subtitle,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.access_time, size: 14, color: Colors.black45),
                const SizedBox(width: 4),
                Text(
                  footer,
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
                const Spacer(),
                const Icon(Icons.chevron_right),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



/*
class KycOpt extends StatefulWidget {
  const KycOpt({super.key});

  @override
  State<KycOpt> createState() => _KycOptState();
}

class _KycOptState extends State<KycOpt> {
  // ✅ Generate unique reference ID
  String generateReferenceId({String prefix = 'KYC'}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(999999);
    return '$prefix$timestamp$random';
  }

  late final StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null &&
          uri.scheme == 'invoicediscounting' &&
          uri.host == 'kyc') {
        final status = uri.queryParameters['status'];
        final txnId = uri.queryParameters['initiation_decentro_transaction_id'];

        if (status == 'SUCCESS') {
          // ✅ KYC completed successfully
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      }
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
  // ✅ Open DigiLocker in external browser
  // Future<void> openDigiLockerUrl(String url) async {
  //   final uri = Uri.parse(url);

  //   if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
  //     throw 'Could not open DigiLocker';
  //   }
  // }

  void _openDigiLocker(BuildContext context) {
    context.read<KycBloc>().add(
      GetDigiUIStreamRequested(
        consent: true,
        consentPurpose: 'for banking purpose only',
        referenceId: generateReferenceId(),
        uistream: "AADHAAR",
        callBackUrl: "invoicediscounting://kyc/callback",
        redirectUrl: 'https://decentro.tech',
      ),
      // GetDigiUIStreamRequested(
      //   consent: true,
      //   consentPurpose: 'for banking purpose only',
      //   referenceId: generateReferenceId(),

      //   redirectUrl: "https://decentro.tech",

      //   uistream: "AADHAAR",
      //   callBackUrl: "invoicediscounting://kyc/callback",
      // ),
    );
  }

  void _openManual(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => KycAddressScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return BlocListener<KycBloc, KycState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        // ✅ Success → Open DigiLocker
        // if (state.status == KycStatus.success && state.sessionUrl != null) {
        //   openDigiLockerUrl(state.sessionUrl!);
        // }
        if (state.status == KycStatus.success && state.sessionUrl != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => KycDigilocker(uistreamUrl: state.sessionUrl!),
            ),
          );
        }
        // ❌ Error → Show message
        if (state.status == KycStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to start DigiLocker')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: blackColor),
          centerTitle: true,
          title: Text(
            'KYC Verification',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Choose how you want to complete your KYC',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Text(
                'We’re using DigiLocker for instant, digital verification. '
                'It’s government-approved, protects your privacy, and takes just minutes.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),

              // DigiLocker option
              _KycOptionCard(
                icon: Icons.cloud,
                title: 'DigiLocker',
                subtitle:
                    'Fetch your documents securely from DigiLocker (recommended).',
                onTap: () => _openDigiLocker(context),
              ),

              const SizedBox(height: 12),

              // Manual option
              _KycOptionCard(
                icon: Icons.upload_file,
                title: 'Manual Upload',
                subtitle:
                    'Upload identity and address documents manually from your device.',
                onTap: () => _openManual(context),
              ),

              const SizedBox(height: 20),

              // Loader
              BlocBuilder<KycBloc, KycState>(
                builder: (context, state) {
                  if (state.status == KycStatus.loading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------

class _KycOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _KycOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: lightblue,
                child: Icon(icon, color: onboardingTitleColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    Text(subtitle, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
*/