import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/components/keyboard_done.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

Widget inputField(
  BuildContext context,
  String hint,
  TextInputType keyboardType,
  TextEditingController controller, {
  bool isEditing = true,
  FocusNode? focusNode,
}) {
  final bool isNumeric =
      keyboardType == TextInputType.number ||
      keyboardType == TextInputType.phone;

  final textField = TextField(
     cursorColor: onboardingTitleColor,
    controller: controller,
    focusNode: focusNode,

    keyboardType: keyboardType,
    readOnly: !isEditing,
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: isEditing ? blackColor : Colors.grey,
    ),
    decoration: InputDecoration(
      labelText: hint,

      labelStyle: const TextStyle(color: Colors.grey),
      floatingLabelStyle: TextStyle(color: onboardingTitleColor),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: isEditing ? Colors.grey : Colors.grey.shade300,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: onboardingTitleColor, width: 1.6),
      ),
    ),
  );
  return Padding(
    padding: const EdgeInsets.only(top: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isNumeric && focusNode != null)
          SizedBox(
            height: 48,
            child: KeyboardActions(
              config: KeyboardActionsConfig(
                keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
                actions: [
                  KeyboardActionsItem(
                    focusNode: focusNode,
                    toolbarButtons: [(node) => styledDoneButton(node)],
                  ),
                ],
              ),
              child: textField,
            ),
          )
        else
          textField,
      ],
    ),
  );

  //   TextField(
  // controller: controller,
  //  focusNode: focusNode,

  // keyboardType: keyboardType,
  // readOnly: !isEditing,
  // style: Theme.of(context).textTheme.bodyMedium?.copyWith(
  //       color: isEditing ? blackColor : Colors.grey,
  //     ),
  //   decoration: InputDecoration(
  //     labelText: hint,

  //     labelStyle: const TextStyle(color: Colors.grey),
  //     floatingLabelStyle: TextStyle(color: onboardingTitleColor),

  //     enabledBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8),
  //       borderSide: BorderSide(
  //         color: isEditing ? Colors.grey : Colors.grey.shade300,
  //       ),
  //     ),

  //     focusedBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8),
  //       borderSide: BorderSide(color: onboardingTitleColor, width: 1.6),
  //     ),
  //   ),
  // );
}
