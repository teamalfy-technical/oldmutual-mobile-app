import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomLineChart extends StatelessWidget {
  final List<FlSpot> data;
  const PCustomLineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
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
          interval: 500,
          reservedSize: PAppSize.s10,
          getTitlesWidget: (value, meta) {
            return Text(
              PFormatter.formatMoneyValue(value.toInt().toString()),
              style: TextStyle(
                fontSize: PAppSize.s10,
                color: PAppColor.transparentColor,
              ),
            );
          },
        ),
      ),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

      // bottomTitles: AxisTitles(
      //   sideTitles: SideTitles(
      //     showTitles: true,
      //     interval: 500, // Adjust as needed
      //     reservedSize: 40,
      //   ),
      // ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          // reservedSize: 50,
          minIncluded: false,
          maxIncluded: false,
          interval: 500,
          reservedSize: 30,
          getTitlesWidget: (value, meta) {
            return Text(
              // 'GHS ${value.toInt()}',
              PFormatter.formatMoneyValue(value.toInt().toString()),
              style: TextStyle(fontSize: PAppSize.s10),
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
          // reservedSize: 50,
          getTitlesWidget: (value, meta) {
            final months = [
              {'index': 0, 'month': 'Jan'},
              {'index': 1, 'month': 'Feb'},
              {'index': 2, 'month': 'Mar'},
              {'index': 3, 'month': 'Apr'},
              {'index': 4, 'month': 'May'},
              {'index': 5, 'month': 'Jun'},
              {'index': 6, 'month': 'Jul'},
              {'index': 7, 'month': 'Aug'},
              {'index': 8, 'month': 'Sep'},
              {'index': 9, 'month': 'Oct'},
              {'index': 10, 'month': 'Nov'},
              {'index': 11, 'month': 'Dec'},
              // {'index': 12, 'month': 'Dec'},
            ];
            // return Text('Day ${value.toInt()}');
            return Text(
              '${months[value.toInt() - 1]['month']}',
              style: TextStyle(fontSize: PAppSize.s10),
            );
            // return Text('${value.toInt()}');
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
      isCurved: false,
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
