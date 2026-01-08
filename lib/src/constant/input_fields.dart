import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

Widget inputField(
  BuildContext context,
  String hint,
  TextInputType keyboardType,
  TextEditingController controller, {
  bool isEditing = true,   
}) {
  return TextField(
  controller: controller,
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

}
