import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_event.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/constant/storage_constant.dart';
import 'package:invoicediscounting/src/modules/kyc/kyc_adhar_pan.dart';

class KycOpt extends StatefulWidget {
  const KycOpt({super.key});

  @override
  State<KycOpt> createState() => _KycOptState();
}

class _KycOptState extends State<KycOpt> {
  @override
  void initState() {
    super.initState();
    kycProgesstatus();
  }

  void kycProgesstatus() async {
    String? sessionId = await storage.read(key: 'sessionId');
    final bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(UserKycProgressRequested(sessionId.toString()));
  }

  void _openDigiLocker(BuildContext context) {
    Navigator.pushNamed(context, '/kyc/digilocker');
  }

  void _openManual(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (c) => KycAddressScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Choose how you want to complete your KYC',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'We’re using DigiLocker for instant, digital verification. It’s government-approved, protects your privacy, and takes just minutes.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            _KycOptionCard(
              icon: Icons.cloud,
              title: 'DigiLocker',
              subtitle:
                  'Fetch your documents securely from DigiLocker (recommended).',
              onTap: () => _openDigiLocker(context),
            ),
            const SizedBox(height: 12),
            _KycOptionCard(
              icon: Icons.upload_file,
              title: 'Manual Upload',
              subtitle:
                  'Upload identity and address documents manually from your device.',
              onTap: () => _openManual(context),
            ),
            const SizedBox(height: 20),
            // TextButton(
            //   onPressed: () => Navigator.pop(context),
            //   child: const Text('Cancel'),
            // ),
          ],
        ),
      ),
    );
  }
}

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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
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
