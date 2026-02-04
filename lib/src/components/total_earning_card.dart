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
    child: Center(
      child: PortfolioRadialChart(invested: 100000, returns: 20500),
    ),
    /*
      Column(
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
      */
  );
}

enum PortfolioSegment { total, invested, returns }

class PortfolioRadialChart extends StatefulWidget {
  final double invested;
  final double returns;

  const PortfolioRadialChart({
    super.key,
    required this.invested,
    required this.returns,
  });

  @override
  State<PortfolioRadialChart> createState() => _PortfolioRadialChartState();
}

class _PortfolioRadialChartState extends State<PortfolioRadialChart> {
  PortfolioSegment selected = PortfolioSegment.total;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        final box = context.findRenderObject() as RenderBox;
        final local = box.globalToLocal(details.globalPosition);
        _handleTap(local, box.size);
      },
      child: SizedBox(
        height: 220,
        width: 220,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: const Size(220, 220),
              painter: _SingleRingPainter(
                invested: widget.invested,
                returns: widget.returns,
                selected: selected,
              ),
            ),
            _CenterInfo(
              selected: selected,
              invested: widget.invested,
              returns: widget.returns,
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(Offset point, Size size) {
    final center = size.center(Offset.zero);
    final vector = point - center;
    final distance = vector.distance;

    final outerRadius = size.width / 2;
    final innerRadius = outerRadius - 30;

    if (distance < innerRadius) {
      setState(() => selected = PortfolioSegment.total);
      return;
    }

    if (distance > outerRadius) return;

    final angle = vector.direction;
    final normalizedAngle = angle < -1.5708 ? angle + 2 * 3.1416 : angle;

    final percent = (normalizedAngle + 1.5708) / (2 * 3.1416);

    final total = widget.invested + widget.returns;
    final investedRatio = widget.invested / total;

    setState(() {
      if (percent <= investedRatio) {
        selected = PortfolioSegment.invested;
      } else {
        selected = PortfolioSegment.returns;
      }
    });
  }
}

class _SingleRingPainter extends CustomPainter {
  final double invested;
  final double returns;
  final PortfolioSegment selected;

  _SingleRingPainter({
    required this.invested,
    required this.returns,
    required this.selected,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double ringThickness = 28.0; // 🔥 increase this

    const double strokeWidth = ringThickness;
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - strokeWidth / 2;
    const startAngle = -3.1416 / 2;

    final total = invested + returns;
    final investedSweep = invested / total * 2 * 3.1416;
    final returnsSweep = returns / total * 2 * 3.1416;

    final basePaint =
        Paint()
          ..color = Colors.grey.shade200
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    final investedPaint =
        Paint()
          ..color = onboardingTitleColor
          ..style = PaintingStyle.stroke
          ..strokeWidth =
              selected == PortfolioSegment.invested
                  ? strokeWidth + 6
                  : strokeWidth
          ..strokeCap = StrokeCap.round;

    final returnsPaint =
        Paint()
          ..shader = SweepGradient(
            colors: [Colors.greenAccent, Colors.green.shade700],
          ).createShader(Rect.fromCircle(center: center, radius: radius))
          ..style = PaintingStyle.stroke
          ..strokeWidth =
              selected == PortfolioSegment.returns
                  ? strokeWidth + 6
                  : strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      2 * 3.1416,
      false,
      basePaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      investedSweep,
      false,
      investedPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle + investedSweep,
      returnsSweep,
      false,
      returnsPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _SingleRingPainter oldDelegate) => true;
}

class _CenterInfo extends StatelessWidget {
  final PortfolioSegment selected;
  final double invested;
  final double returns;

  const _CenterInfo({

    required this.selected,
    required this.invested,
    required this.returns,
  });

  @override
  Widget build(BuildContext context) {
    String title;
    String value;
    Color valueColor;
    Widget? extra;

    final returnsPercent = (returns / invested) * 100;

    switch (selected) {
      case PortfolioSegment.invested:
        title = "Invested";
        value = "₹${invested.toStringAsFixed(0)}";
        valueColor = Colors.blueAccent;
        break;

      case PortfolioSegment.returns:
        title = "Returns";
        value = "+₹${returns.toStringAsFixed(0)}";
        valueColor = Colors.green.shade700;
        extra = Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            "↑ ${returnsPercent.toStringAsFixed(2)}%",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.green.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
        break;

      default:
        title = "Total Amount";
        value = "₹${(invested + returns).toStringAsFixed(0)}";
        valueColor = Colors.black87;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (extra != null) extra,
      ],
    );
  }
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
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
