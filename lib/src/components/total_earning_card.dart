import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';




  Widget totalEarningCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Total Earning',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Spacer(),
              MiniBarChart(),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            '₹1,02045.25',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
            // style: TextStyle(
            //   color: Colors.green,
            //   fontSize: 28,
            //   fontWeight: FontWeight.bold,
            // ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              ValueBlock(label: 'Total Invested', value: '₹1,00,000/-'),
              ValueBlock(label: 'Total Returns', value: '₹2045.25'),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade300),

          const SizedBox(height: 10),

          Row(
            children: [
              Text('Returns', style: Theme.of(context).textTheme.bodyMedium),
              Spacer(),
              Text(
                '+12.6%',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
class MiniBarChart extends StatelessWidget {
  const MiniBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 45,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          barGroups: [
            makeGroup(0, 4),
            makeGroup(1, 7),
            makeGroup(2, 6),
            makeGroup(3, 8),
            makeGroup(4, 5),
            makeGroup(5, 7),
            makeGroup(6, 6),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 6,
          borderRadius: BorderRadius.circular(4),
          gradient: const LinearGradient(
            colors: [Color(0xff3cd070), Color(0xff0ca45c)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ],
    );
  }
}

class ValueBlock extends StatelessWidget {
  final String label, value;
  const ValueBlock({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium,),
        const SizedBox(height: 4),
        Text(
          value,
         style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}