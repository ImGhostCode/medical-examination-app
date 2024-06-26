import 'package:flutter/material.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/pages/medical_examination_page.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/widgets/signal_chart.dart';

class SignalStatisticsPage extends StatelessWidget {
  const SignalStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SignalStatisticsArguments;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Biểu đồ tín hiệu'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Huyết áp',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SignalChart(
                  singalName: 'Huyết áp',
                  listSignals: args.listBloodPressureSignals,
                ),
                const SizedBox(height: 8),
                Text(
                  'Mạch',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SignalChart(
                  singalName: 'Mạch',
                  listSignals: args.listHeartSignals,
                ),
                const SizedBox(height: 8),
                Text(
                  'Nhiệt độ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SignalChart(
                  singalName: 'Nhiệt độ',
                  listSignals: args.listTemperatureSignals,
                ),
                const SizedBox(height: 8),
                Text(
                  'SPO2',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SignalChart(
                  singalName: 'SPO2',
                  listSignals: args.listSP02Signals,
                ),
                const SizedBox(height: 8),
                Text(
                  'Nhịp thở',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SignalChart(
                  singalName: 'Nhịp thở',
                  listSignals: args.listRespiratorySignals,
                ),
                const SizedBox(height: 8),
                Text(
                  'Cân nặng',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SignalChart(
                  singalName: 'Cân nặng',
                  listSignals: args.listWeightSignals,
                ),
                const SizedBox(height: 8),
                Text(
                  'Chiều cao',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SignalChart(
                  singalName: 'Chiều cao',
                  listSignals: args.listHeightSignals,
                ),
              ],
            ),
          ),
        ));
  }
}
