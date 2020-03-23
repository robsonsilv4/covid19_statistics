import 'package:covid19_statistics/data/models/brazil_statistics.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphStats extends StatelessWidget {
  final List<BrazilStatistics> series;
  final String state;

  GraphStats(this.series, this.state);

  @override
  Widget build(BuildContext context) {
    var graphSeries = processSeries(series);

    return Container(
      height: 300,
      padding: EdgeInsets.all(12),
      child: SfCartesianChart(
        title: ChartTitle(
          text: '$state - Mensal',
          alignment: ChartAlignment.center,
          textStyle: ChartTextStyle(
            fontSize: 14,
            color: Colors.black45,
          ),
        ),
        primaryXAxis: DateTimeAxis(
          intervalType: DateTimeIntervalType.days,
          associatedAxisName: 'Dia',
          name: 'Dia',
        ),
        primaryYAxis: NumericAxis(
          isVisible: true,
          title: AxisTitle(
            text: 'Casos',
          ),
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          color: Color(0xff46B2AE),
          header: 'Casos',
        ),
        legend: Legend(
          alignment: ChartAlignment.center,
          position: LegendPosition.bottom,
          isVisible: true,
          isResponsive: true,
          legendItemBuilder: (legendText, series, point, seriesIndex) {
            return Chip(
              label: Text(legendText),
              avatar: getIcon(legendText),
              labelPadding: EdgeInsets.only(right: 3),
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
            );
          },
        ),
        series: <ChartSeries>[
          LineSeries<Data, DateTime>(
            dataSource: graphSeries,
            xValueMapper: (Data series, _) => DateTime.parse(series.datetime),
            yValueMapper: (Data series, _) => series.cases,
            name: 'Confirmados',
            markerSettings: MarkerSettings(
              isVisible: true,
              color: Color(0xffd1dded),
            ),
            color: Colors.indigo,
            isVisibleInLegend: true,
          ),
          LineSeries<Data, DateTime>(
            dataSource: graphSeries,
            xValueMapper: (Data series, _) => DateTime.parse(series.datetime),
            yValueMapper: (Data series, _) => series.deaths,
            name: 'Mortes',
            color: Colors.red,
          ),
          LineSeries<Data, DateTime>(
            dataSource: graphSeries,
            xValueMapper: (Data series, _) => DateTime.parse(series.datetime),
            yValueMapper: (Data series, _) => series.refuses,
            name: 'Descartados',
            color: Colors.green,
          )
        ],
      ),
    );
  }

  Icon getIcon(String text) {
    switch (text) {
      case 'Descartados':
        return Icon(
          Icons.local_hospital,
          color: Colors.green,
        );
        break;
      case 'Mortes':
        return Icon(
          Icons.local_hotel,
          color: Colors.red,
        );
        break;
      case 'Confirmados':
        return Icon(
          Icons.report,
          color: Colors.indigo,
        );
        break;
      default:
        return Icon(
          Icons.graphic_eq,
          color: Colors.blue,
        );
    }
  }

  List<Data> processSeries(List<BrazilStatistics> series) {
    var data = series.reversed.take(30).toList();
    List<Data> graphSeries = [];

    for (final series in data) {
      if (series.data.length > 0) {
        for (final serie in series.data) {
          if (serie.state == state) {
            graphSeries.add(serie);
          }
        }
      }
    }
    return graphSeries;
  }
}
