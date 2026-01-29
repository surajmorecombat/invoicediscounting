import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/activity/trainsation_all.dart';


class WalletButton extends StatelessWidget {
  const WalletButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TrainsationAll()),
        );
      },
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: onboardingTitleColor),
          ),
          child: Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                size: 20,
                color: onboardingTitleColor,
              ),
              const SizedBox(width: 6),
              Text(
                '₹1,00,000',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
