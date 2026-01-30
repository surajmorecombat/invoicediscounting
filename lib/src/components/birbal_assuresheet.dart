

import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

class BirbalAssuresheet extends StatelessWidget {
  const BirbalAssuresheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      maxChildSize: 0.75,
      minChildSize: 0.55,
      builder: (_, controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/app-icon.png', height: 30),
              const SizedBox(height: 10),
              Image.asset('assets/images/app-name.png', height: 25),

              const SizedBox(height: 10),

              Text(
                'Overview',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(color: blackColor),
              ),
              const SizedBox(height: 15),
                        
              // Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FBF6),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: const [
                    _AssuredRow(
                      text:
                          'Earn attractive returns with enhanced capital protection.',
                    ),
                    Divider(height: 32),
                  
                    _AssuredRow(
                      text:
                          'Your principal and returns are protected through insurance coverage.',
                    ),
                    Divider(height: 32),
                    _AssuredRow(
                      text:
                          'In the event of buyer default, losses are reimbursed by the insurer.',
                    ),
                  ],
                ),
              ),
                        
              const SizedBox(height: 15),
                        
              // T&C Button
              SizedBox(
                width: double.infinity,
                height: 48,
                        
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: onboardingTitleColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: Icon(Icons.link, size: 15, color: whiteColor),
                  label: Text(
                    'Details Terms & Conditions',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
                        
          
            ],
          ),
        );
      },
    );
  }
}

class _AssuredRow extends StatelessWidget {
  final String text;
  const _AssuredRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // // Image.asset('assets/icons/ampli-plus.png', height: 18),
        // const SizedBox(width: 10),
        Expanded(
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
