import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notification_task/Charts/pie_chart_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FusionChart extends StatefulWidget {
  const FusionChart({super.key});

  @override
  State<FusionChart> createState() => _FusionChartState();
}

class _FusionChartState extends State<FusionChart> {
  late TooltipBehavior tooltipBehavior;
  late ZoomPanBehavior zoomBehavior;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tooltipBehavior = TooltipBehavior(enable: true);
    zoomBehavior = ZoomPanBehavior(
        // enableSelectionZooming: true,

        maximumZoomLevel: 200,
        enableDoubleTapZooming: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Syncfusion Chart"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: SfCartesianChart(
                title: ChartTitle(text: "Half yearly sales analysis"),
                legend: Legend(isVisible: true),
                tooltipBehavior: tooltipBehavior,
                primaryXAxis: CategoryAxis(),
                // primaryYAxis: CategoryAxis(),
                backgroundColor: Colors.lightGreenAccent,
                borderWidth: 5,
                borderColor: Colors.teal,
                enableSideBySideSeriesPlacement: true,
                enableAxisAnimation: true,
                zoomPanBehavior: zoomBehavior,
                onZooming: (zoomingArgs) {
                  // print(zoomingArgs.currentZoomPosition);
                },
                // onZoomStart: (zoomingArgs) =>
                // print(zoomingArgs.currentZoomPosition),

                crosshairBehavior:
                    CrosshairBehavior(shouldAlwaysShow: true, enable: true),
                series: [
                  BubbleSeries(
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
                      }),
                  ColumnSeries(
                      selectionBehavior: SelectionBehavior(enable: true),
                      dataSource: [
                        SalesData('Jan', 35),
                        SalesData('Feb', 28),
                        SalesData('Mar', 34),
                        SalesData('Apr', 32),
                        SalesData('May', 40)
                      ],
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      xValueMapper: (sale, index) {
                        return sale.year;
                      },
                      yValueMapper: (sale, index) {
                        return sale.sales;
                      }),
                  ColumnSeries(
                      selectionBehavior: SelectionBehavior(enable: true),
                      dataSource: [
                        SalesData('Jan', 10),
                        SalesData('Feb', 20),
                        SalesData('Mar', 15),
                        SalesData('Apr', 8),
                        SalesData('May', 25)
                      ],
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      xValueMapper: (sale, index) {
                        return sale.year;
                      },
                      yValueMapper: (sale, index) {
                        return sale.sales;
                      }),
                  ColumnSeries(
                      selectionBehavior: SelectionBehavior(enable: true),
                      dataSource: [
                        SalesData('Jan', 20),
                        SalesData('Feb', 10),
                        SalesData('Mar', 8),
                        SalesData('Apr', 22),
                        SalesData('May', 35)
                      ],
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      xValueMapper: (sale, index) {
                        return sale.year;
                      },
                      yValueMapper: (sale, index) {
                        return sale.sales;
                      }),
                  LineSeries(
                      dataSource: [
                        SalesData('Jan', 35),
                        SalesData('Feb', 28),
                        SalesData('Mar', 34),
                        SalesData('Apr', 32),
                        SalesData('May', 40)
                      ],
                      xValueMapper: (sale, index) {
                        return sale.year;
                      },
                      yValueMapper: (sale, index) {
                        return sale.sales;
                      })
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PieChartView()));
              },
              child: const Text('Next'))
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
