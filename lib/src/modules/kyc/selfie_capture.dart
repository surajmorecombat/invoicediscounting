import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoicediscounting/src/components/selfie_avatar.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/kyc/bank_verification.dart';


class SelfieCapture extends StatefulWidget {
  const SelfieCapture({super.key});

  @override
  State<SelfieCapture> createState() => _SelfieCaptureState();
}

class _SelfieCaptureState extends State<SelfieCapture> {
  File? selfieFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        selfieFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    final bool hasSelfie = selfieFile != null;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: blackColor),
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Text(
          "Selfie Capture",
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
              backgroundColor: hasSelfie ? onboardingTitleColor : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed:
                hasSelfie
                    ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BankVerification(),
                        ),
                      );
                    }
                    : null,
            child: Text(
              'Verify & Continue',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 24),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            Center(
              child: SelfieAvatar(
                selfieFile: selfieFile,
                onCameraTap: _openCamera,
              ),
            ),

            const SizedBox(height: 12),

            if (!hasSelfie)
              Text(
                'Click on camera icon to capture selfie',
                style: TextStyle(
                  color: onboardingTitleColor,
                  fontWeight: FontWeight.w500,
                ),
              ),

            if (hasSelfie) ...[
              const SizedBox(height: 20),
              SizedBox(
                height: 52,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: onboardingTitleColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _openCamera,
                  child: Text(
                    'Retake',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
