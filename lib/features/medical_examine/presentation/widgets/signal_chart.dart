import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SignalChart extends StatelessWidget {
  final String singalName;
  final List<SignalEntity> listSignals;
  const SignalChart(
      {super.key, required this.listSignals, required this.singalName});
  // final List<SalesData> chartData = [
  //   SalesData(DateTime(2010), 35),
  //   SalesData(DateTime(2011), 28),
  //   SalesData(DateTime(2012), 34),
  //   SalesData(DateTime(2013), 32),
  //   SalesData(DateTime(2014), 40)
  // ];;
  @override
  Widget build(BuildContext context) {
    final List<SingalData> chartData = listSignals
        .map((e) => SingalData(
            DateTime.parse('${e.authored!.substring(0, 19)}z'),
            double.parse(e.valueString!)))
        .toList();
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        child: SfCartesianChart(
            primaryXAxis: DateTimeAxis(
              labelRotation: 45,
              dateFormat: DateFormat('yyyy/MM/dd HH:mm:ss'),
              isVisible: false,
              // isVisible: listSignals.isNotEmpty,
              // labelFormat: '{value}h',
            ),
            onMarkerRender: (markerArgs) {
              markerArgs.markerHeight = 5;
              markerArgs.markerWidth = 5;
              markerArgs.color = Colors.white;
            },

            // legend: const Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(
                enable: true, activationMode: ActivationMode.singleTap),
            series: <CartesianSeries>[
              // Renders line chart
              LineSeries<SingalData, DateTime>(
                  markerSettings: const MarkerSettings(isVisible: true),
                  dataLabelMapper: (datum, index) {
                    return '${datum.value.toInt()}';
                  },
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  dataSource: chartData,
                  name: singalName,
                  xValueMapper: (SingalData value, _) => value.time,
                  yValueMapper: (SingalData value, _) => value.value),
            ]));
  }
}

class SingalData {
  SingalData(this.time, this.value);
  final DateTime time;
  final double value;
}
