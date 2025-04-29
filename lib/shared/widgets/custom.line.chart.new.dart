import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';

class PCustomLineChartNew extends StatefulWidget {
  final List<PerformanceModel> data;
  const PCustomLineChartNew({super.key, required this.data});

  @override
  State<PCustomLineChartNew> createState() => _PCustomLineChartNewState();
}

class _PCustomLineChartNewState extends State<PCustomLineChartNew> {
  var anchorSpots = <FlSpot>[];
  var benchmarkSpots = <FlSpot>[];
  var sortedData = <PerformanceModel>[];

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        sortedData =
            widget.data..sort((a, b) => a.year!.compareTo(b.year ?? 0));
        anchorSpots =
            sortedData
                .map(
                  (e) => FlSpot(
                    e.year!.toDouble(),
                    double.parse(e.performance.toString().replaceAll('%', '')),
                  ),
                )
                .toList();
        benchmarkSpots =
            sortedData
                .map(
                  (e) => FlSpot(
                    e.year!.toDouble(),
                    double.parse(e.benchmark.toString().replaceAll('%', '')),
                  ),
                )
                .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // var anchorSpots = <FlSpot>[];
    // var benchmarkSpots = <FlSpot>[];
    // var sortedData = <PerformanceModel>[];

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   sortedData = widget.data..sort((a, b) => a.year!.compareTo(b.year ?? 0));
    //   anchorSpots =
    //       sortedData
    //           .map(
    //             (e) => FlSpot(
    //               e.year!.toDouble(),
    //               double.parse(e.performance.toString().replaceAll('%', '')),
    //             ),
    //           )
    //           .toList();
    //   benchmarkSpots =
    //       sortedData
    //           .map(
    //             (e) => FlSpot(
    //               e.year!.toDouble(),
    //               double.parse(e.benchmark.toString().replaceAll('%', '')),
    //             ),
    //           )
    //           .toList();
    // });

    // sort data by year
    // final sortedData = data..sort((a, b) => a.year!.compareTo(b.year ?? 0));

    // final anchorSpots =
    //     sortedData
    //         .map(
    //           (e) => FlSpot(
    //             e.year!.toDouble(),
    //             double.parse(e.performance.toString().replaceAll('%', '')),
    //           ),
    //         )
    //         .toList();

    // final benchmarkSpots =
    //     sortedData
    //         .map(
    //           (e) => FlSpot(
    //             e.year!.toDouble(),
    //             double.parse(e.benchmark.toString().replaceAll('%', '')),
    //           ),
    //         )
    //         .toList();
    return LineChart(
      LineChartData(
        minY: 0,
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
            final actualYears =
                widget.data.map((e) => e.year?.toDouble()).toList();
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
          interval: benchmarkInterval,
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

  double get benchmarkInterval {
    // final benchmarkStrings = ["14.08%", "14.69%", "35.4%", "29.36", "28.04%"];
    final benchmarks =
        widget.data.map((s) {
          return double.tryParse(s.benchmark!.replaceAll('%', '')) ?? 0;
        }).toList();
    double maxValue = benchmarks.reduce((a, b) => a > b ? a : b);

    // Determine a nice dynamic interval
    double interval = maxValue / 5;

    // Round interval to nearest 5 for nicer ticks
    return (interval / 5).ceil() * 5;
  }
}
