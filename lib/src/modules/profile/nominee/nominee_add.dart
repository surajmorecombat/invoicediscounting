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
  DateTime? selectedDate;
  final TextEditingController dateController = TextEditingController();

  String? nomineeRelation;

  Future<void> _selectDOB(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: onboardingTitleColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: onboardingTitleColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text =
            '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Nominee Details',
          style: Theme.of(context).textTheme.headlineMedium,
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
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 16),
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

              // inputField(d
              //   context,
              //   'DOB',
              //   TextInputType.text,
              //   nomineeDobController,
              //   isEditing: isEditing,
              // ),
              buildDateInput(context, isEditing: isEditing),

              // const SizedBox(height: 15),
              inputField(
                context,
                'Guardian Name',
                TextInputType.text,
                gurdianNameController,
                isEditing: isEditing,
              ),

              const SizedBox(height: 15),

              nomineeRelationDropdown(context, isEditing: isEditing),

              // inputField(context, 'Nominee Relation', TextInputType.name,
              //     nomineeRelationController, isEditing: isEditing),
              // const SizedBox(height: 15),
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

  Widget buildDateInput(context, {bool isEditing = false}) {
    return TextField(
      cursorColor: onboardingTitleColor,
      readOnly: true,
      controller: dateController,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: isEditing ? blackColor : Colors.grey,
      ),
      decoration: InputDecoration(
        hintText: 'DD-MM-YYYY',
        hintStyle: Theme.of(context).textTheme.bodySmall,
        suffixIcon: Icon(
          Icons.calendar_today,
          size: 20,
          color: onboardingTitleColor,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        labelStyle: const TextStyle(color: Colors.grey),

        floatingLabelStyle: TextStyle(color: onboardingTitleColor),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: onboardingTitleColor, width: 1.6),
        ),
      ),
      onTap: () {
        _selectDOB(context);
        FocusScope.of(context).unfocus();
      },
    );
  }

  Widget nomineeRelationDropdown(
    BuildContext context, {
    bool isEditing = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownMenu<String>(
        requestFocusOnTap: false,
        enableSearch: false,
        expandedInsets: EdgeInsets.zero,

        hintText: "Nominee Relation",
        textStyle: Theme.of(context).textTheme.bodySmall,
        inputDecorationTheme: InputDecorationTheme(
          suffixIconColor: onboardingTitleColor,
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
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
        onSelected:
            isEditing
                ? (value) => setState(() => nomineeRelation = value)
                : null,
      ),
    );
  }
}
