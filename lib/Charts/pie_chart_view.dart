import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notification_task/Charts/pyramid_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'fusion_chart.dart';

class PieChartView extends StatefulWidget {
  const PieChartView({super.key});

  @override
  State<PieChartView> createState() => _PieChartViewState();
}

class _PieChartViewState extends State<PieChartView> {
  late TooltipBehavior tooltipBehavior;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pie chart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: SfCircularChart(
                enableMultiSelection: true,
                selectionGesture: ActivationMode.doubleTap,
                // annotations: [
                //   CircularChartAnnotation(
                //       angle: 0, radius: "50%", widget: const Text('Pie'))
                // ],
                tooltipBehavior: tooltipBehavior,
                // onDataLabelRender: (label) {
                //   print(label.text);
                // },
                onSelectionChanged: (selectedArgs) {
                  print(selectedArgs.seriesIndex);
                },

                title: ChartTitle(text: "Pie chart"),
                legend: Legend(isVisible: true),
                series: [
                  PieSeries(
                      enableTooltip: true,
                      dataLabelMapper: (data, index) {
                        return "${data.sales}%";
                      },
                      selectionBehavior: SelectionBehavior(enable: true),
                      // enableTooltip: true,
                      legendIconType: LegendIconType.pentagon,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        color: Colors.white,
                      ),
                      dataSource: [
                        SalesData('Jan', 35),
                        SalesData('Feb', 28),
                        SalesData('Mar', 34),
                        SalesData('Apr', 32),
                        SalesData('May', 40)
                      ],
                      xValueMapper: (sale, _) => sale.year,
                      yValueMapper: (sale, _) => sale.sales)
                ],
              ),
            ),
          ),
          Expanded(
              child: SfCircularChart(
            title: ChartTitle(text: "RadialBar Chart"),
            legend: Legend(isVisible: true),
            series: [
              RadialBarSeries(
                  cornerStyle: CornerStyle.bothCurve,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  maximumValue: 50,
                  // legendIconType: LegendIconType.circle,
                  selectionBehavior: SelectionBehavior(enable: true),
                  enableTooltip: true,
                  dataSource: [
                    SalesData('Jan', 35),
                    SalesData('Feb', 28),
                    SalesData('Mar', 34),
                    SalesData('Apr', 32),
                    SalesData('May', 40)
                  ],
                  xValueMapper: (sale, _) {
                    return sale.year;
                  },
                  yValueMapper: (sale, _) {
                    return sale.sales;
                  })
            ],
          )),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PyramidChart()));
              },
              child: const Text("next"))
        ],
      ),
    );
  }
}
