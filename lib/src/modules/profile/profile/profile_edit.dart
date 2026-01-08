import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/constant/input_fields.dart';
import 'package:invoicediscounting/src/mainlayout.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileEdit> {
  final TextEditingController nameController = TextEditingController(
    text: 'Nitish Sanjay Sharma',
  );
  final TextEditingController emailController = TextEditingController(
    text: 'niteshsharma03@gmail.com',
  );
  final TextEditingController phoneController = TextEditingController(
    text: '+91 9876543210',
  );
  final TextEditingController addressController = TextEditingController(
    text: 'nashik',
  );

  bool onOffValye = true;
  bool isEditing = false;
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
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
            child: Icon(Icons.edit, color: blackColor, size: 20),
            //  Text(
            //   isEditing ? 'Cancel' : 'Edit',
            //   style: TextStyle(
            //     color: onboardingTitleColor,
            //     fontWeight: FontWeight.w600,
            //     fontSize: 16,
            //   ),
            // ),
          ),
        ],
      ),
  
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
                // if (isEditing)
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed:
                          isEditing
                              ? () {
                                setState(() {
                                  isEditing = false;
                                });
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: onboardingTitleColor,
                        foregroundColor: whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                        minimumSize: const Size(0, 48),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isEditing ? whiteColor : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.only(left: 80, right: 80),
                //   child: SizedBox(
                //     width: double.infinity,

                //     child: ElevatedButton(
                //       onPressed:
                // isEditing
                //     ? () {
                //       setState(() {
                //         isEditing = false;
                //       });
                //     }
                //     : null,
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: onboardingTitleColor,
                //         foregroundColor: whiteColor,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8),
                //         ),
                //         elevation: 0,
                //         minimumSize: const Size(0, 48),
                //       ),
                //       child: const Text(
                //         'Update',
                //         style: TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.w600,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Stack(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
        ),
        Positioned(
          right: -1,
          bottom: -1,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileEdit()),
                );
              },
              child: CircleAvatar(
                radius: 13,
                backgroundColor: whiteColor,
                child: const Icon(Icons.edit, size: 12, color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );

    //  CircleAvatar(radius: 50, backgroundColor: Colors.grey);
  }

  // Widget verifiedBankField() {
  //   return TextField(
  //     controller: bankController,
  //     readOnly: true,
  //     style: Theme.of(context).textTheme.bodyLarge,
  //     decoration: InputDecoration(
  //       labelText: "Bank Details",
  //       labelStyle: const TextStyle(color: Colors.grey),
  //       floatingLabelStyle: TextStyle(color: onboardingTitleColor),

  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: BorderSide(color: Colors.grey.shade300),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: BorderSide(color: onboardingTitleColor, width: 1.6),
  //       ),

  //       suffixIcon: Padding(
  //         padding: const EdgeInsets.only(right: 12),
  //         child: Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: const [
  //             Text(
  //               "Verified",
  //               style: TextStyle(
  //                 color: Color(0xFF2F80ED),
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //             SizedBox(width: 6),
  //             Icon(Icons.chevron_right, size: 20, color: Color(0xFF2F80ED)),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
