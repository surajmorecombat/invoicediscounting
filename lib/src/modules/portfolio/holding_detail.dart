import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

class HoldingDetail extends StatelessWidget {
  const HoldingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF003A8F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              //   Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => PaymentDoneSuccess()),
              // );
            },
            child: Text('Sell', style: Theme.of(context).textTheme.labelLarge),
          ),
        ),
      ),
    );
  }
}
