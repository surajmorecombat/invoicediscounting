import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/constant/input_fields.dart';

class DematDetails extends StatefulWidget {
  const DematDetails({super.key});

  @override
  State<DematDetails> createState() => _DematDetailsState();
}

class _DematDetailsState extends State<DematDetails> {
  final TextEditingController dpIdController = TextEditingController(
    text: '98765400',
  );
  final TextEditingController clientIdController = TextEditingController(
    text: '1122007',
  );
  final TextEditingController depositoryNameController = TextEditingController(
    text: 'Zerodha',
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
        title: Text(
          'Demat Details',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
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
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),

              if (onOffValye) ...[
                inputField(
                  isEditing: isEditing,
                  context,
                  'DP ID',
                  TextInputType.number,
                  dpIdController,
                ),

                const SizedBox(height: 15),

                inputField(
                  isEditing: isEditing,
                  context,
                  'Client ID',
                  TextInputType.number,
                  clientIdController,
                ),

                const SizedBox(height: 15),
                inputField(
                  isEditing: isEditing,
                  context,
                  'Depositoy Name',
                  TextInputType.text,
                  depositoryNameController,
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
                        'Save',
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
}
