import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/constant/input_fields.dart';
import 'package:invoicediscounting/src/mainlayout.dart';

class NomineeAdd extends StatelessWidget {
  const NomineeAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nomineeNameController = TextEditingController();
    final TextEditingController nomineeDobController = TextEditingController();
    final TextEditingController gurdianNameController = TextEditingController();
    final TextEditingController nomineeRelationController =
        TextEditingController();
    final TextEditingController contactController = TextEditingController();

    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return MainLayout(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Nominee Details',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
      ),
      ctx: 0,
      showDefaultBottom: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 20),
        child: Column(
          children: [
            const SizedBox(height: 15),
            inputField(
              context,
              'Nominee Name',
              TextInputType.name,
              nomineeNameController,
            ),

            const SizedBox(height: 15),

            inputField(
              context,
              'Nominee Date of Birth',
              TextInputType.emailAddress,
              nomineeDobController,
            ),

            const SizedBox(height: 15),
            inputField(
              context,
              'Name of parent/Guardian name',
              TextInputType.phone,
              gurdianNameController,
            ),

            const SizedBox(height: 15),
            inputField(
              context,
              'Relationship with Nominee',
              TextInputType.name,
              nomineeRelationController,
            ),

            const SizedBox(height: 15),
            inputField(
              context,
              'Contact Number',
              TextInputType.name,
              contactController,
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => VerifyEmailOtp()),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: onboardingTitleColor,
                    foregroundColor: whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    minimumSize: const Size(0, 48),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
