import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notification_task/Charts/fusion_chart.dart';
import 'package:notification_task/Charts/spark_chart_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PyramidChart extends StatefulWidget {
  const PyramidChart({super.key});

  @override
  State<PyramidChart> createState() => _PyramidChartState();
}

class _PyramidChartState extends State<PyramidChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pyramid"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: SfPyramidChart(
                backgroundColor: Colors.grey,
                enableMultiSelection: true,
                title: ChartTitle(text: "Pyramid Chart"),
                legend: Legend(isVisible: true),
                series: PyramidSeries<SalesData, String>(
                    selectionBehavior: SelectionBehavior(enable: true),
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 10)),
                    dataSource: [
                      SalesData('Jan', 35),
                      SalesData('Feb', 28),
                      SalesData('Mar', 34),
                      SalesData('Apr', 32),
                      SalesData('May', 40)
                    ],
                    xValueMapper: (sale, _) => sale.year,
                    yValueMapper: (sale, _) => sale.sales),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: SfFunnelChart(
                backgroundColor: Colors.blueGrey,
                title: ChartTitle(
                    text: "Funnel Chart",
                    textStyle: const TextStyle(color: Colors.white)),
                legend: Legend(
                    isVisible: true,
                    textStyle: const TextStyle(color: Colors.white)),
                series: FunnelSeries(
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(color: Colors.white)),
                    dataSource: [
                      SalesData('Jan', 35),
                      SalesData('Feb', 28),
                      SalesData('Mar', 34),
                      SalesData('Apr', 32),
                      SalesData('May', 40)
                    ],
                    xValueMapper: (sale, _) => sale.year,
                    yValueMapper: (sale, _) => sale.sales),
              )),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => SparkChartView()));
              },
              child: const Text('Next'))
        ],
      ),
    );
  }
}
