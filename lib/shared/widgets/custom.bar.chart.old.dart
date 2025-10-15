import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomBarChartOld extends StatelessWidget {
  final List<BarChartGroupData> data;
  final bool showLeftTitles;
  final bool showRightTitles;
  final bool showTopTitles;
  final bool showBottomTitles;
  final bool showGridData;
  final bool showBorderData;

  final List<String>? bottomTitles;
  final List<String>? leftTitles;
  final List<String>? topTitles;
  final List<String>? rightTitles;
  const PCustomBarChartOld({
    super.key,
    required this.data,
    this.showLeftTitles = true,
    this.showBottomTitles = true,
    this.showTopTitles = false,
    this.showRightTitles = false,
    this.showGridData = true,
    this.showBorderData = false,
    this.bottomTitles,
    this.leftTitles,
    this.topTitles,
    this.rightTitles,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: _buildGridData(),
        borderData: _buildBorderData(),
        barGroups: data,
        titlesData: _buildTitlesData(),
      ),
    ).centered().all(PAppSize.s10);
  }

  FlGridData _buildGridData() {
    return FlGridData(
      show: showGridData,
      drawHorizontalLine: true,
      drawVerticalLine: false,
    );
  }

  FlBorderData _buildBorderData() {
    return FlBorderData(
      show: showBorderData,
      border: Border.all(color: Colors.black, width: 1),
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: showRightTitles,
          getTitlesWidget: (value, meta) {
            final titlesData = rightTitles ?? [];
            return Text(
              titlesData.isEmpty
                  ? value.toInt().toString()
                  : titlesData[value.toInt()],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: PAppSize.s10),
            );
          },
        ),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: showTopTitles,
          reservedSize: PAppSize.s40,
          getTitlesWidget: (value, meta) {
            final titlesData = topTitles ?? [];
            final index = value.toInt();
            final rawLabel =
                (index >= 0 && index < titlesData.length)
                    ? titlesData[index]
                    : '';

            final formattedLabel = PFormatter.formatMoneyValue(
              double.parse(rawLabel),
            );

            final barValue =
                (index >= 0 && index < data.length)
                    ? data[index].barRods.first.toY
                    : 0;

            double maxY =
                topTitles!.length
                    .toDouble(); // PHelperFunction.findMaxValue(values: topTitles ?? []);
            final offsetY = (1 - (barValue / maxY)) * 50;
            return Transform.translate(
              offset: Offset(0, offsetY),
              child: Text(
                'Pension Value \n $formattedLabel',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: PAppSize.s10),
              ),
            );
            // final titlesData = topTitles ?? [];
            // // Assuming value is the x-axis index, get your bar value manually
            // final barValue =
            //     titlesData.isEmpty
            //         ? double.parse(titlesData[value.toInt()])
            //         : getBarValue(value);

            // final offsetY = (1 - (barValue / maxY)) * 100; //
            // return Transform.translate(
            //   offset: Offset(0, offsetY),
            //   child: Text(
            //     'Pension Value \nGHS $barValue',
            //     style: TextStyle(fontSize: PAppSize.s10),
            //     textAlign: TextAlign.center,
            //   ),
            // );
            // return Text(
            //   titlesData.isEmpty
            //       ? value.toInt().toString()
            //       : titlesData[value.toInt()],
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: PAppSize.s10),
            // );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: showLeftTitles,
          interval: 1,
          getTitlesWidget: (value, meta) {
            final titlesData = leftTitles ?? [];
            return Text(
              titlesData.isEmpty
                  ? value.toInt().toString()
                  : titlesData[value.toInt()],
              style: TextStyle(fontSize: PAppSize.s10),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          // reservedSize: PAppSize.s20,
          showTitles: showBottomTitles,
          getTitlesWidget: (value, meta) {
            final months = bottomTitles ?? ['Jan', 'Feb', 'Mar', 'Apr', 'May'];
            return Text(
              months[value.toInt()],
              style: TextStyle(fontSize: PAppSize.s10),
            ).only(top: PAppSize.s10);
          },
        ),
      ),
    );
  }

  double getBarValue(double xValue) {
    final group = data.firstWhere(
      (g) => g.x == xValue,
      orElse: () => BarChartGroupData(x: 0, barRods: []),
    );
    return group.barRods.isNotEmpty ? group.barRods.first.toY : 0;
  }
}

double calculateOffset(double value, double maxY) {
  final ratio = value / maxY;
  return (1 - ratio) *
      20; // less offset for taller barstweak 20 as a multiplier to adjust the "drop"
}
