import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MiniBarChart extends StatelessWidget {
  const MiniBarChart();

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
  const ValueBlock({required this.label, required this.value});

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