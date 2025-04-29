import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomLineChart extends StatelessWidget {
  final List<FlSpot> data;
  final List<String> xLabels;
  final double interval;
  const PCustomLineChart({
    super.key,
    required this.data,
    required this.interval,
    required this.xLabels,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        // minX: 0,
        // maxX: 5,
        gridData: _buildGridData(),
        borderData: _buildBorderData(),
        lineBarsData: [_buildLineChartBarData()],
        titlesData: _buildTitlesData(),
      ),
    ).centered();
  }

  FlGridData _buildGridData() {
    return FlGridData(
      show: true, // show line
      drawHorizontalLine: false,
      drawVerticalLine: false,
    );
  }

  FlBorderData _buildBorderData() {
    return FlBorderData(
      show: false, // show line
      border: Border.all(color: Colors.black, width: 1),
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      show: true, // show line
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: interval,
          reservedSize: PAppSize.s30,
          getTitlesWidget: (value, meta) {
            return Text(
              PFormatter.formatMoneyValue(value),
              style: TextStyle(
                fontSize: PAppSize.s10,
                color: PAppColor.transparentColor,
              ),
            );
          },
        ),
      ),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          // reservedSize: 50,
          minIncluded: true,
          maxIncluded: true,
          interval: interval,
          reservedSize: PAppSize.s30,
          getTitlesWidget: (value, meta) {
            return Text(
              PFormatter.formatMoneyValue(value),
              style: TextStyle(fontSize: PAppSize.s9),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          // minIncluded: false,
          // maxIncluded: false,
          interval: 1, // Adjust as needed
          reservedSize: PAppSize.s30,
          getTitlesWidget: (value, meta) {
            int index = value.toInt();
            if (index < 0 || index >= xLabels.length) {
              return const SizedBox.shrink();
            }
            return Text(
              xLabels[index],
              style: TextStyle(fontSize: PAppSize.s9),
            ).only(top: PAppSize.s14);
          },
        ),
      ),
    );
  }

  LineChartBarData _buildLineChartBarData() {
    return LineChartBarData(
      spots: data,
      color: PAppColor.primary,
      barWidth: 2,
      isCurved: true,
      belowBarData: BarAreaData(
        show: true,
        spotsLine: BarAreaSpotsLine(
          show: false,
          flLineStyle: FlLine(
            color: PAppColor.primary,
            strokeWidth: 1,
            dashArray: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
          ),
        ),
        color: PAppColor.primary.withOpacityExt(PAppSize.s0_2),
        // gradient: LinearGradient(
        //   begin: Alignment.bottomCenter,
        //   end: Alignment.topCenter,
        //   colors: [Colors.lightGreenAccent, PAppColor.primary],
        // ),
      ),
    );
  }
}
