import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomLineChartNew extends StatelessWidget {
  final List<FlSpot> data;
  const PCustomLineChartNew({super.key, required this.data});

  List<FlSpot> shiftSpots(List<FlSpot> spots, double shift) {
    return spots.map((spot) => FlSpot(spot.x + shift, spot.y)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: _buildGridData(),
        borderData: _buildBorderData(),
        lineBarsData: [_buildLineChartBarData(), _buildLineChartBarDat2()],
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
      // border: Border.all(color: Colors.black, width: 1),
      border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      show: true, // show line
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          // reservedSize: 16,
          minIncluded: false,
          maxIncluded: true,
          interval: 1,
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          minIncluded: false,
          maxIncluded: false,
          // interval: 1,
          getTitlesWidget: (value, meta) {
            // final months = [
            //   {'index': 1, 'month': 'Jan'},
            //   {'index': 2, 'month': 'Feb'},
            //   {'index': 3, 'month': 'Mar'},
            //   {'index': 4, 'month': 'Apr'},
            // ];
            // // return Text('Day ${value.toInt()}');
            // return Text('${months[value.toInt() - 1]['month']}');

            return Text('20${value.toInt()}');
          },
        ),
      ),
    );
  }

  LineChartBarData _buildLineChartBarDat2() {
    List<FlSpot> line2 = shiftSpots(data, 0.2); // Shift second line slightly
    return LineChartBarData(
      // spots: line2,
      spots: [
        FlSpot(19, 4.5),
        FlSpot(20, 7.5),
        FlSpot(21, 5.2),
        FlSpot(22, 8.5),
        FlSpot(23, 9.5),
        // FlSpot(24, 6.5),
      ],
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
        color: PAppColor.transparentColor,
        // gradient: LinearGradient(
        //   begin: Alignment.bottomCenter,
        //   end: Alignment.topCenter,
        //   colors: [Colors.lightGreenAccent, PAppColor.primary],
        // ),
      ),
    );
  }

  LineChartBarData _buildLineChartBarData() {
    return LineChartBarData(
      spots: data,
      color: PAppColor.orangeColor,
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
        color: PAppColor.transparentColor,
        // gradient: LinearGradient(
        //   begin: Alignment.bottomCenter,
        //   end: Alignment.topCenter,
        //   colors: [Colors.lightGreenAccent, PAppColor.primary],
        // ),
      ),
    );
  }
}
