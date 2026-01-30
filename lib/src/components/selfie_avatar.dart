import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

class SelfieAvatar extends StatelessWidget {
  final File? selfieFile;
  final VoidCallback onCameraTap;

  const SelfieAvatar({
    super.key,
    required this.selfieFile,
    required this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasSelfie = selfieFile != null;

    return Column(
      children: [
        if (hasSelfie) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: onboardingTitleColor, size: 18),
              const SizedBox(width: 6),
              Text(
                'Perfect',
                style: TextStyle(
                  color: onboardingTitleColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],

        GestureDetector(
          onTap: onCameraTap,
          child: DottedBorder(
            options: CircularDottedBorderOptions(
              dashPattern: const [4, 6],
              color: onboardingTitleColorLight,
              strokeWidth: 2,
            ),
            child: Container(
              width: 240,
              height: 240,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: onboardingTitleColorLight,
                ),
                child: ClipOval(
                  child:
                      hasSelfie
                          ? Image.file(selfieFile!, fit: BoxFit.cover)
                          : const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 50,
                          ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
