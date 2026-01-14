import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/constant/input_fields.dart';

class NomineeAdd extends StatefulWidget {
  const NomineeAdd({super.key});

  @override
  State<NomineeAdd> createState() => _NomineeAddState();
}

class _NomineeAddState extends State<NomineeAdd> {
  final TextEditingController nomineeNameController = TextEditingController(
    text: '',
  );
  final TextEditingController nomineeDobController = TextEditingController();
  final TextEditingController gurdianNameController = TextEditingController();
  final TextEditingController nomineeRelationController =
      TextEditingController();
  final TextEditingController contactController = TextEditingController();

  bool isEditing = false;
 

String? nomineeRelation;

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Nominee Details',
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
              const SizedBox(height: 12),

              inputField(
                context,
                'Nominee Name',
                TextInputType.name,
                nomineeNameController,
                isEditing: isEditing,
              ),

              const SizedBox(height: 15),

              inputField(
                context,
                'DOB',
                TextInputType.text,
                nomineeDobController,
                isEditing: isEditing,
              ),

              const SizedBox(height: 15),

              inputField(
                context,
                'Guardian Name',
                TextInputType.text,
                gurdianNameController,
                isEditing: isEditing,
              ),

              const SizedBox(height: 15),

          nomineeRelationDropdown(context),


              // inputField(context, 'Nominee Relation', TextInputType.name,
              //     nomineeRelationController, isEditing: isEditing),
              const SizedBox(height: 15),

              inputField(
                context,
                'Contact',
                TextInputType.phone,
                contactController,
                isEditing: isEditing,
              ),

              const SizedBox(height: 20),

                // SizedBox(
                //   width: double.infinity,
                //   height: 52,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       setState(() => isEditing = false);
                //     },
                //     child: const Text("Save"),
                //   ),
                // ),

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
            ],
          ),
        ),
      ),
    );
  }

 Widget nomineeRelationDropdown(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey),
    ),
    child: DropdownMenu<String>(
      requestFocusOnTap: true,
      enableSearch: false,
      expandedInsets: EdgeInsets.zero,
      
      hintText: "Nominee Relation",
      textStyle: Theme.of(context).textTheme.bodySmall,
      inputDecorationTheme:  InputDecorationTheme(
        suffixIconColor: onboardingTitleColor,
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.symmetric( vertical: 12),
      ),
      dropdownMenuEntries: const [
        DropdownMenuEntry(value: "Father", label: "Father"),
        DropdownMenuEntry(value: "Mother", label: "Mother"),
        DropdownMenuEntry(value: "Spouse", label: "Spouse"),
        DropdownMenuEntry(value: "Son", label: "Son"),
        DropdownMenuEntry(value: "Daughter", label: "Daughter"),
        DropdownMenuEntry(value: "Brother", label: "Brother"),
        DropdownMenuEntry(value: "Sister", label: "Sister"),
      ],
      onSelected: isEditing ? (value) => setState(() => nomineeRelation = value) : null,
    ),
  );
}

}
