import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/shimmer/profile_shimmer.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

import 'package:invoicediscounting/src/modules/portfolio/demat/demat_details.dart';
import 'package:invoicediscounting/src/modules/profile/bank_details/bank_details.dart';
import 'package:invoicediscounting/src/modules/profile/help/help_centre.dart';

import 'package:invoicediscounting/src/modules/profile/nominee/nominee_add.dart';
import 'package:invoicediscounting/src/modules/profile/profile/profile_edit.dart';
import 'package:invoicediscounting/src/modules/signUp/login_with.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginWith()),
              );
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
      body:isLoading?ProfileShimmer(): SingleChildScrollView(
        child:
        
         Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
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
                 
            
             
                ],
              ),
            ),
             _supportCard(context),
          ],
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
    return Container(
  width: double.infinity,
        // padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage("https://i.pravatar.cc/100"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Relationship Manager', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: blackColor,
                      fontWeight: FontWeight.w500,
                    ),),
                  SizedBox(height: 5,),
                  Text(
                    "Shradha Singh",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
