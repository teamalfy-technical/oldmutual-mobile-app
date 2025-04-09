import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';

class PCustomLineChartNew extends StatelessWidget {
  final List<PerformanceModel> data;
  const PCustomLineChartNew({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final anchorSpots =
        data
            .map(
              (e) => FlSpot(
                e.year!.toDouble(),
                double.parse(e.anchor.toString().replaceAll('%', '')),
              ),
            )
            .toList();

    final benchmarkSpots =
        data
            .map(
              (e) => FlSpot(
                e.year!.toDouble(),
                double.parse(e.benchmark.toString().replaceAll('%', '')),
              ),
            )
            .toList();
    return LineChart(
      LineChartData(
        gridData: _buildGridData(),
        borderData: _buildBorderData(),
        lineBarsData: [
          _buildLineChartBarData1(anchorSpots),
          _buildLineChartBarData2(benchmarkSpots),
        ],
        titlesData: _buildTitlesData(),
      ),
    ).centered().all(PAppSize.s10);
  }

  FlGridData _buildGridData() {
    return FlGridData(
      show: false, // show line
      drawHorizontalLine: false,
      drawVerticalLine: false,
    );
  }

  FlBorderData _buildBorderData() {
    return FlBorderData(
      show: true, // show line
      border: Border(
        bottom: BorderSide(color: PAppColor.blackColor, width: PAppSize.s1),
      ),
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, _) {
            // Show only actual years from your data
            final actualYears = data.map((e) => e.year?.toDouble()).toList();
            if (actualYears.contains(value)) {
              return Text(
                value.toInt().toString(),
                style: TextStyle(
                  fontSize: PAppSize.s10,
                  fontWeight: FontWeight.w500,
                  color: PAppColor.text700,
                ),
              );
            }
            return const SizedBox.shrink(); // Don't show duplicate or auto ticks
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 10,
          reservedSize: PAppSize.s50,
          getTitlesWidget:
              (value, _) => Text(
                '${value.toStringAsFixed(2)}%',
                style: TextStyle(
                  fontSize: PAppSize.s10,
                  fontWeight: FontWeight.w500,
                  color: PAppColor.text700,
                ),
              ),
        ),
      ),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  LineChartBarData _buildLineChartBarData1(anchorSpots) {
    return LineChartBarData(
      spots: anchorSpots,
      color: PAppColor.primary,
      barWidth: PAppSize.s3,
      isCurved: false,
    );
  }

  LineChartBarData _buildLineChartBarData2(benchmarkSpots) {
    return LineChartBarData(
      spots: benchmarkSpots,
      color: PAppColor.orangeColor,
      barWidth: PAppSize.s3,
      isCurved: false,
    );
  }
}
