import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/mainlayout.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      backgroundColor: backgroundColor,
      ctx: 2,
      showDefaultBottom: true,
      appBar: AppBar(),
      body: Center(child: Text('portfolioww')),
    );
  }
}
