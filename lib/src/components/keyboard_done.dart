import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

Widget styledDoneButton(FocusNode node) {
  return Padding(
    padding: const EdgeInsets.only(right: 12),
    child: GestureDetector(
      onTap: () => node.unfocus(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: onboardingTitleColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
            color: Colors.black..withValues(alpha: .12),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Text(
          "Done",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
