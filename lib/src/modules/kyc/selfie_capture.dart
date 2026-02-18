import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user.state.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_bloc.dart';
import 'package:invoicediscounting/src/bloc/user_authentication/user_event.dart';
import 'package:invoicediscounting/src/components/selfie_avatar.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/constant/storage_constant.dart';
import 'package:invoicediscounting/src/modules/kyc/bank_verification.dart';

class SelfieCapture extends StatefulWidget {
  final String? name;
  final String? panId;
  final String? dob;
  final String? adharId;
  final String address;

  const SelfieCapture({
    super.key,
    this.name,
    this.panId,
    this.dob,
    this.adharId,
    required this.address,
  });

  @override
  State<SelfieCapture> createState() => _SelfieCaptureState();
}

/*
 Future<void> pickDocument(KycDocType docType, ImageSource source) async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: source,
      imageQuality: 30,
    );

    if (picked != null) {
      context.read<UserBloc>().add(
        UserFileUploadRequested(filePath: picked.path, docType: docType),
      );
    }
  }


*/
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
        context.read<UserBloc>().add(
          UserFileUploadRequested(
            filePath: selfieFile!.path,
            docType: KycDocType.selfie,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    final bool hasSelfie = selfieFile != null;

    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state.status == UserStatus.kycRegistered) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: onboardingTitleColor,
              content: Text(state.errorMessage.toString(),style: TextStyle(color: Colors.white), ),),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BankVerification()),
          );
        } else if (state.status == UserStatus.kycNotRegistered) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                state.errorMessage.toString() ,style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
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
                  backgroundColor:
                      hasSelfie ? onboardingTitleColor : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                //       onPressed: () {
                //            Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => BankVerification()),
                // );
                //       },
                onPressed:
                    hasSelfie
                        ? () async {
                          String? sessionId = await storage.read(
                            key: 'sessionId',
                          );
                          final userBloc = BlocProvider.of<UserBloc>(context);
                          final panDetails = {
                            'submittedInvestorName': widget.name,
                            'submittedPanNumber': widget.panId,
                            'submittedDateOfBirth': widget.dob,
                          };
                          userBloc.add(
                            InvestorRegistrationRequested(
                              formData: {
                                'sessionId': sessionId,
                                'fullName': widget.name,
                                'gender': 'male', //assuming gender
                                'kycMode': 'manual',
                                'humanInteraction': true,
                                'submittedPanDetails': panDetails,
                                'panCardDocumentId': state.panDocId,
                                'aadharFrontImageId': state.aadhaarFrontDocId,
                                'aadharBackImageId': state.aadhaarBackDocId,
                                "selfieId": state.selfieDocId,
                              },
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
      },
    );
  }
}
