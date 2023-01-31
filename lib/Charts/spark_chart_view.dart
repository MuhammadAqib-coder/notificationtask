import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SparkChartView extends StatefulWidget {
  const SparkChartView({super.key});

  @override
  State<SparkChartView> createState() => _SparkChartViewState();
}

class _SparkChartViewState extends State<SparkChartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spark Chart'),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            child: SfSparkAreaChart(
              data: [18, 50, -10, 30, 14, 28, -19, 10],
              labelStyle: const TextStyle(color: Colors.red),
              labelDisplayMode: SparkChartLabelDisplayMode.all,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            child: SfSparkBarChart(
              data: [18, 50, -10, 30, 14, 28, -19, 10],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            child: SfSparkLineChart(
              plotBand: SparkChartPlotBand(start: 15, end: 25),
              trackball: const SparkChartTrackball(
                activationMode: SparkChartActivationMode.tap,
              ),
              data: [18, 50, -10, 30, 14, 28, -19, 10],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            child: SfSparkWinLossChart(
              data: const [18, 50, -8, 30, 14, 28, -10],
            ),
          )
        ],
      ),
    );
  }
}
