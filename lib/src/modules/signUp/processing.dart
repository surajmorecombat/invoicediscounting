import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/invest/invest.dart';
import 'package:lottie/lottie.dart';

class VerificationProcessing extends StatefulWidget {
  const VerificationProcessing({super.key});

  @override
  State<VerificationProcessing> createState() => _VerificationProcessingState();
}

class _VerificationProcessingState extends State<VerificationProcessing> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Invest()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 24),
              child: Card(
                elevation: 5,
               margin: const EdgeInsets.only(bottom: 16),
                          
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/lottie/hourglass.json',
                        width: 150,
                        height: 150,
                      ),
                      // Image.asset(
                      //   'assets/images/hourglass.png',
                      //   width: 80,
                      //   height: 150,
                      // ),
                      Text(
                        'Verification in progress…',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(height: 10),
                          
                      Text(
                        '''We're reviewing your details. This usually takes 2-3 business days.''',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            _supportCard(context),
            
          ],
        ),
      ),
    );
  }


  //   Widget _menuItem(IconData icon, String title, context, VoidCallback onTap) {
  //   return ListTile(
  //     leading: Icon(icon, color: blackColor),
  //     title: Text(
  //       title,
  //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
  //         color: blackColor,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //     trailing: Icon(Icons.chevron_right, color: blackColor),
  //     onTap: onTap,
  //   );
  // }

  Widget _supportCard(context) {
    return Container(
  width: double.infinity,
        // padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage("https://i.pravatar.cc/100"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Relationship Manager', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: blackColor,
                      fontWeight: FontWeight.w500,
                    ),),
                  SizedBox(height: 5,),
                  Text(
                    "Shradha Singh",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: blackColor,
                      fontWeight: FontWeight.w500,
                    ),

                    // style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
                    maxLines: 3,
                    "We're here to help reach out with any questions.",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Image.asset('assets/icons/supportmail.png', height: 25),
            SizedBox(width: 5),
            Image.asset('assets/icons/whatsapp.png', height: 25),
            SizedBox(width: 5),
            Image.asset('assets/icons/supportcall.png', height: 25),
            // Row(
            // IconButton(icon: const Icon(Icons.email), onPressed: () {}),
            // IconButton(icon: const Icon(Icons.phone), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
