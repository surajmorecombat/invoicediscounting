import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/constant/input_fields.dart';
import 'package:invoicediscounting/src/mainlayout.dart';
import 'package:invoicediscounting/src/modules/profile/help/help_centre.dart';
import 'package:invoicediscounting/src/modules/profile/nominee/nominee_add.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController nameController = TextEditingController(
    text: 'Combat Solution Ai',
  );
  final TextEditingController emailController = TextEditingController(
    text: 'combat@gmail.com',
  );
  final TextEditingController phoneController = TextEditingController(
    text: '9988558866',
  );
  final TextEditingController addressController = TextEditingController(
    text: 'nashik',
  );
  final TextEditingController cityController = TextEditingController(
    text: 'nashik',
  );
  final TextEditingController zipController = TextEditingController(
    text: '422222',
  );
  final TextEditingController bankController = TextEditingController(
    text: '3*********877',
  );
  bool onOffValye = true;
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return MainLayout(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Profile', style: Theme.of(context).textTheme.bodyLarge),
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
      ),
      ctx: 0,
      showDefaultBottom: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                //  margin: EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.camera_alt_outlined, color: whiteColor),
                    ),
                    Spacer(),
                    Text(
                      'Public Profile',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    Switch(
                      value: onOffValye,
                      activeColor: successText,
                      thumbColor: WidgetStatePropertyAll<Color>(whiteColor),
                      onChanged: (value) {
                        setState(() {
                          onOffValye = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              if (onOffValye) ...[
                inputField(context, 'Name', TextInputType.name, nameController),

                const SizedBox(height: 15),

                inputField(
                  context,
                  'Email',
                  TextInputType.emailAddress,
                  emailController,
                ),

                const SizedBox(height: 15),
                inputField(
                  context,
                  'Phone',
                  TextInputType.phone,
                  phoneController,
                ),

                const SizedBox(height: 15),
                inputField(
                  context,
                  'Address',
                  TextInputType.name,
                  addressController,
                ),

                const SizedBox(height: 15),
                inputField(context, 'City', TextInputType.name, cityController),

                const SizedBox(height: 15),
                inputField(
                  context,
                  'Zip/Code',
                  TextInputType.phone,
                  zipController,
                ),

                const SizedBox(height: 15),
                verifiedBankField(),

                const SizedBox(height: 15),
              ],

              pendingTile(
                pandingStatus: true,
                title: "Demat Details",
                subtitle:
                    "Kindly provide your DEMAT details to enable smooth and compliant transactions.",
                onTap: () {},
              ),

              const SizedBox(height: 15),

              pendingTile(
                pandingStatus: true,
                title: "Nominee Details",
                subtitle:
                    "Add your Nominee details to keep your account protected and future-ready.",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NomineeAdd()),
                  );
                },
              ),

              const SizedBox(height: 15),

              pendingTile(
                pandingStatus: false,
                title: "Help Center",
                subtitle:
                    "Add your Nominee details to keep your account protected and future-ready.",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpCentre()),
                  );
                },
              ),
              const SizedBox(height: 15),
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
                      'Save Changes',
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
      ),
    );
  }

  Widget verifiedBankField() {
    return TextField(
      controller: bankController,
      readOnly: true,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: "Bank Details",
        labelStyle: const TextStyle(color: Colors.grey),
        floatingLabelStyle: TextStyle(color: onboardingTitleColor),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: onboardingTitleColor, width: 1.6),
        ),

        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "Verified",
                style: TextStyle(
                  color: Color(0xFF2F80ED),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 6),
              Icon(Icons.chevron_right, size: 20, color: Color(0xFF2F80ED)),
            ],
          ),
        ),
      ),
    );
  }

  Widget pendingTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool pandingStatus,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            pandingStatus
                ? Row(
                  children: [
                    Text(
                      "Pending",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFF2994A),
                      ),
                      // style: TextStyle(
                      //   color: Color(0xFFF2994A),
                      //   fontWeight: FontWeight.w600,
                      // ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 22,
                      color: Color(0xFFF2994A),
                    ),
                  ],
                )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
