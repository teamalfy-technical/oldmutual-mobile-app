import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';

List data = [
  {"month": "2025-04", "main_current_value": 0, "monthly_change": 0},
  {
    "month": "2025-05",
    "main_current_value": 33086.12,
    "monthly_change": 33086.12,
  },
  {"month": "2025-06", "main_current_value": 33186.12, "monthly_change": 100},
];

class PCustomLineChart extends StatelessWidget {
  final List<FlSpot> data;
  final List<Contribution> data2;
  final List<String> xLabels;
  final double interval;
  const PCustomLineChart({
    super.key,
    required this.data,
    required this.interval,
    required this.xLabels,
    required this.data2,
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
        lineTouchData: _buildLineTouchData(),
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

  LineTouchData _buildLineTouchData() {
    return LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        // tooltipBgColor: Colors.black87,
        tooltipRoundedRadius: PAppSize.s8,
        // maxContentWidth: 500,
        tooltipPadding: const EdgeInsets.all(PAppSize.s8),
        fitInsideHorizontally: true,
        // fitInsideVertically: true,
        tooltipMargin: PAppSize.s16,

        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((touchedSpot) {
            final index = touchedSpot.x.toInt();
            final entry = data2[index];

            final label = PFormatter.formatCurrency(
              amount: entry.mainCurrentValue ?? 0,
              // symbol: '₵',
            );
            return LineTooltipItem(
              '$label\n',
              textAlign: TextAlign.start,
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text:
                      entry.monthlyChange!.isNegative
                          ? '-${PFormatter.formatCurrency(amount: entry.monthlyChange ?? 0)}'
                          : '+${PFormatter.formatCurrency(amount: entry.monthlyChange ?? 0)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
              ],
            );
          }).toList();
        },
      ),
      touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
        // Optional: handle tap behavior or logging here
      },
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      show: true, // show line
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: interval,
          // reservedSize: PAppSize.s30,
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

  LineChartBarData _buildLineChartBarData2() {
    return LineChartBarData(
      spots: data,
      color: PAppColor.blackColor,
      barWidth: 2,
      isCurved: true,
      belowBarData: BarAreaData(
        show: true,
        spotsLine: BarAreaSpotsLine(
          show: false,
          flLineStyle: FlLine(
            color: PAppColor.blackColor,
            strokeWidth: 1,
            dashArray: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
          ),
        ),
        color: PAppColor.blackColor.withOpacityExt(PAppSize.s0_2),
        // gradient: LinearGradient(
        //   begin: Alignment.bottomCenter,
        //   end: Alignment.topCenter,
        //   colors: [Colors.lightGreenAccent, PAppColor.primary],
        // ),
      ),
    );
  }
}
