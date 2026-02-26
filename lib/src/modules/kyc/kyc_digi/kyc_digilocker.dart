import 'package:decentrotech_fabric/decentrotech_fabric.dart'
    show UIStreamWebView;
import 'package:flutter/material.dart';

class KycDigilocker extends StatelessWidget {
  final String uistreamUrl;
  const KycDigilocker({super.key, required this.uistreamUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Digilocker KYC')),
      body: UIStreamWebView(uistreamUrl: uistreamUrl),
    );
  }
}
