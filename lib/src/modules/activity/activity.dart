import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/mainlayout.dart';

class Activity extends StatelessWidget{
  const Activity({super.key});

  @override
  Widget build(BuildContext context){
    return MainLayout(
      backgroundColor: backgroundColor,
           ctx: 1,
      showDefaultBottom: true,
      appBar: AppBar(),body: Center(child: Text('activity'),),);
  }
}