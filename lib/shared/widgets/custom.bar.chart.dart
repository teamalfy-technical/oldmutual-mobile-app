import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';

class PCustomBarChart extends StatelessWidget {
  final List<FundCompositionModel> data;
  const PCustomBarChart({super.key, required this.data});

  String getAssetName(String name) {
    switch (name) {
      case 'CORP DEBT':
        return 'CD';
      case 'EQUITIES':
        return 'EQ';
      case 'LOCAL GOV':
        return 'LG';
      default:
        return name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxY = data
        .map((e) => double.tryParse(e.percentage ?? "0") ?? 0)
        .reduce((a, b) => a > b ? a : b);

    final minY = data
        .map((e) => double.tryParse(e.percentage ?? "0") ?? 0)
        .reduce((a, b) => a < b ? a : b);

    final colors = [
      Color(0xFF1A43E5),
      PAppColor.primary,
      Color(0xFF005466),
      Color(0xFF306E2B),
      Color(0xFF33001C),
      PAppColor.orangeColor,
      PAppColor.yellowColor,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PAppSize.s16),
      child: RotatedBox(
        quarterTurns: 1,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceBetween,
            maxY: maxY + 10,
            minY: -0.05, //minY,
            borderData: FlBorderData(
              show: true,
              border: Border(
                bottom: BorderSide(
                  color: PHelperFunction.isDarkMode(context)
                      ? PAppColor.whiteColor
                      : PAppColor.blackColor,
                  width: PAppSize.s1,
                ),
                right: BorderSide(
                  color: PHelperFunction.isDarkMode(context)
                      ? PAppColor.whiteColor
                      : PAppColor.blackColor,
                  width: PAppSize.s1,
                ),
              ),
            ),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  minIncluded: false,
                  reservedSize: PAppSize.s30,
                  interval: PAppSize.s20,
                  getTitlesWidget: (value, meta) {
                    return Transform.rotate(
                      angle: -1.5708, // -90 degrees in radians
                      child: Text(
                        value.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: PAppSize.s10,
                          fontWeight: FontWeight.w500,
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.whiteColor
                              : PAppColor.blackColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  // reservedSize: 50,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < data.length) {
                      final percentage =
                          double.tryParse(data[index].percentage ?? '0') ?? 0.0;

                      // Calculate the offset for the top title based on the bar height
                      final barHeight = percentage;

                      // Ensure the title is placed above the bar
                      final yOffset =
                          (1 - (barHeight / maxY)) *
                          (PDeviceUtil.getDeviceWidth(context) * 0.6);

                      return Transform.translate(
                        offset: Offset(
                          4,
                          yOffset,
                        ), // move label closer to the top of bar
                        child: Transform.rotate(
                          angle: -1.5708, // rotate back from chart rotation
                          child: Text(
                            '${percentage.toStringAsFixed(2)}%',
                            style: TextStyle(
                              fontSize: PAppSize.s10,
                              fontWeight: FontWeight.w500,
                              color: PHelperFunction.isDarkMode(context)
                                  ? PAppColor.whiteColor
                                  : PAppColor.blackColor,
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  // reservedSize: PAppSize.s20,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < data.length) {
                      return Transform.translate(
                        offset: Offset(4, 16), //
                        // offset: Offset(18, 16), //
                        child: Transform.rotate(
                          alignment: Alignment.center,
                          angle: -1.5708, // -90 degrees in radians
                          child: Text(
                            getAssetName(data[index].asset ?? ''),
                            style: TextStyle(
                              fontSize: PAppSize.s10,
                              fontWeight: FontWeight.w500,
                              color: PHelperFunction.isDarkMode(context)
                                  ? PAppColor.whiteColor
                                  : PAppColor.blackColor,
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            barGroups: data.asMap().entries.map((entry) {
              final index = entry.key;
              final data = entry.value;
              final percentage = double.tryParse(data.percentage ?? "0") ?? 0.0;

              final color = colors[index % colors.length];

              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: percentage,
                    color: color,
                    width: PAppSize.s34,
                    borderRadius: BorderRadius.zero,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
