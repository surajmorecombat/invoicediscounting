import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/mainlayout.dart';
import 'package:invoicediscounting/src/modules/portfolio/demat/demat_details.dart';
import 'package:invoicediscounting/src/modules/profile/bank_details/bank_details.dart';
import 'package:invoicediscounting/src/modules/profile/help/help_centre.dart';

import 'package:invoicediscounting/src/modules/profile/nominee/nominee_add.dart';
import 'package:invoicediscounting/src/modules/profile/profile/profile_edit.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Profile', style: Theme.of(context).textTheme.bodyLarge),
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => VerifyEmailOtp()),
              // );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: whiteColor,
              foregroundColor: whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: onboardingTitleColor),
              ),
              elevation: 0,
              minimumSize: const Size(0, 48),
            ),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: onboardingTitleColor,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 20),
          child: Column(
            children: [
              _profileHeader(context),
              SizedBox(height: 15),

              Card(
                elevation: 0.1,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    _menuItem(
                      Icons.account_balance,
                      "Bank Details",
                      context,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BankDetails(),
                          ),
                        );
                      },
                    ),
                    _menuItem(
                      Icons.person_outline,
                      "Demat Details",
                      context,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DematDetails(),
                          ),
                        );
                      },
                    ),
                    _menuItem(
                      Icons.info_outline,
                      "Nominee Details",
                      context,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NomineeAdd()),
                        );
                      },
                    ),
                    _menuItem(
                      Icons.notifications_none,
                      "Notification",
                      context,
                      () {},
                    ),
                    _menuItem(Icons.help_outline, "Help", context, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HelpCentre()),
                      );
                    }),
                    _menuItem(Icons.info_outline, "About app", context, () {}),
                  ],
                ),
              ),

              SizedBox(height: 15),
              _supportCard(context),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: OutlinedButton(
              //     style: OutlinedButton.styleFrom(
              //       minimumSize: const Size.fromHeight(50),
              //       side: const BorderSide(color: Color(0xFF003A8F)),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //     onPressed: () {},
              //     child: const Text(
              //       "Logout",
              //       style: TextStyle(color: Color(0xFF003A8F)),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileHeader(context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 34,
                  backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
                ),
                Positioned(
                  right: -1,
                  bottom: -1,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileEdit(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 13,
                        backgroundColor: whiteColor,
                        child: const Icon(
                          Icons.edit,
                          size: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nitish Sanjay Sharma",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 4),
                Text(
                  "+91 9876543210",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 4),
                Text(
                  "niteshsharma03@gmail.com",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, context, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: blackColor),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: blackColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: blackColor),
      onTap: onTap,
    );
  }

  Widget _supportCard(context) {
    return Card(
      elevation: 0.1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage("https://i.pravatar.cc/100"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shradha Kapoor",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: blackColor,
                      fontWeight: FontWeight.w500,
                    ),

                    // style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
                    maxLines: 3,
                    "We're here to help reach out with any questions.",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Image.asset('assets/icons/supportmail.png', height: 25),
            SizedBox(width: 5),
            Image.asset('assets/icons/whatsapp.png', height: 25),
            SizedBox(width: 5),
            Image.asset('assets/icons/supportcall.png', height: 25),
            // Row(
            // IconButton(icon: const Icon(Icons.email), onPressed: () {}),
            // IconButton(icon: const Icon(Icons.phone), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}


/*
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
  bool isEditing = false;
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
              _header(context),
         
              const SizedBox(height: 15),

              if (onOffValye) ...[
                inputField(
                  isEditing: isEditing,
                  context,
                  'Name',
                  TextInputType.name,
                  nameController,
                ),

                const SizedBox(height: 15),

                inputField(
                  isEditing: isEditing,
                  context,
                  'Email',
                  TextInputType.emailAddress,
                  emailController,
                ),

                const SizedBox(height: 15),
                inputField(
                  isEditing: isEditing,
                  context,
                  'Phone',
                  TextInputType.phone,
                  phoneController,
                ),

                const SizedBox(height: 15),
                inputField(
                  isEditing: isEditing,
                  context,
                  'Address',
                  TextInputType.name,
                  addressController,
                ),

                const SizedBox(height: 15),
                inputField(context, 'City', TextInputType.name, cityController),

                const SizedBox(height: 15),
                inputField(
                  isEditing: isEditing,
                  context,
                  'Zip/Code',
                  TextInputType.phone,
                  zipController,
                ),

                const SizedBox(height: 15),
                verifiedBankField(),

                const SizedBox(height: 15),
                if (isEditing)
                  Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80),
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
              ],

              const SizedBox(height: 15),

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

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 36, backgroundColor: Colors.grey),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              "Public Profile",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            color: onboardingTitleColor,
            onPressed: () => setState(() => isEditing = !isEditing),
          ),
        ],
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
*/