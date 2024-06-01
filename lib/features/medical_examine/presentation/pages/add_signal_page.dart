// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/enums.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/providers/medical_examine_provider.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/widgets/signal_row.dart';
import 'package:medical_examination_app/features/patient/presentation/pages/search_patient_page.dart';
import 'package:provider/provider.dart';

class AddSignalPage extends StatefulWidget {
  const AddSignalPage({super.key});

  @override
  State<AddSignalPage> createState() => _AddSignalPageState();
}

class _AddSignalPageState extends State<AddSignalPage> {
  bool _heartRateExpanded = true;
  bool _bloodPressureExpanded = true;
  bool _temperatureExpanded = true;
  bool _sp02Expanded = true;
  bool _respiratoryRateExpanded = true;
  bool _heightExpanded = true;
  bool _weightExpanded = true;
  bool _bloodTypeExpanded = true;
  late PatientInfoArguments args;

  // final _formKey = GlobalKey<FormState>();
  final _heartRateFormKey = GlobalKey<FormState>();
  final _bloolPressureFormKey = GlobalKey<FormState>();
  final _temperatureFormKey = GlobalKey<FormState>();
  final _sp02FormKey = GlobalKey<FormState>();
  final _respiratoryRateFormKey = GlobalKey<FormState>();
  final _heightFormKey = GlobalKey<FormState>();
  final _weightFormKey = GlobalKey<FormState>();
  final _bloodTypeFormKey = GlobalKey<FormState>();
  String _bloodType = bloodTypes[0];

  List<SignalEntity> listHeartRateSignals = [];
  List<SignalEntity> listBloodPressureSignals = [];
  List<SignalEntity> listTemperatureSignals = [];
  List<SignalEntity> listSP02Signals = [];
  List<SignalEntity> listRespiratoryRateSignals = [];
  List<SignalEntity> listHeightSignals = [];
  List<SignalEntity> listWeightSignals = [];
  List<SignalEntity> listBloodTypeSignals = [];

  @override
  void didChangeDependencies() async {
    args = ModalRoute.of(context)!.settings.arguments as PatientInfoArguments;
    final provider =
        Provider.of<MedicalExamineProvider>(context, listen: false);
    final encounter =
        ModalRoute.of(context)!.settings.arguments as PatientInfoArguments;

    void updateState() {
      if (mounted) {
        setState(() {});
      }
    }

    Future<void> loadSignals(String signalType, Function setSignalList) async {
      final signals = await provider.eitherFailureOrGetEnteredSignals(
          signalType, encounter.patient.encounter.toString());
      setSignalList(signals);
      updateState();
    }

    loadSignals(
        SignalType.SIG_02.name, (signals) => listHeartRateSignals = signals);
    loadSignals(SignalType.SIG_01.name,
        (signals) => listBloodPressureSignals = signals);
    loadSignals(
        SignalType.SIG_03.name, (signals) => listTemperatureSignals = signals);
    loadSignals(SignalType.SIG_04.name, (signals) => listSP02Signals = signals);
    loadSignals(SignalType.SIG_05.name,
        (signals) => listRespiratoryRateSignals = signals);
    loadSignals(
        SignalType.SIG_08.name, (signals) => listHeightSignals = signals);
    loadSignals(
        SignalType.SIG_06.name, (signals) => listWeightSignals = signals);
    loadSignals(
        SignalType.SIG_10.name, (signals) => listBloodTypeSignals = signals);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Sinh hiệu',
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeartRate(context),
              const SizedBox(height: 16),
              _buildBloodPressure(context),
              const SizedBox(height: 16),
              _buildSP02(context),
              const SizedBox(height: 16),
              _buildTemperature(context),
              const SizedBox(height: 16),
              _buildRespiratory(context),
              const SizedBox(height: 16),
              _buildHeight(context),
              const SizedBox(height: 16),
              _buildWeight(context),
              const SizedBox(height: 16),
              _buildBloodType(context),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Hoàn tất'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ExpansionTile _buildBloodType(BuildContext context) {
    return ExpansionTile(
        onExpansionChanged: (bool expanded) {
          setState(() {
            _bloodTypeExpanded = expanded;
          });
        },
        initiallyExpanded: _bloodTypeExpanded,
        collapsedShape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        title: Text(
          'Nhóm máu',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16),
        children: [
          Form(
            key: _bloodTypeFormKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      value: _bloodType,
                      validator: (value) {
                        if (value == null) {
                          return 'Vui lòng chọn nhóm máu';
                        }
                        return null;
                      },
                      items: bloodTypes
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _bloodType = value.toString();
                        });
                      }),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_weightFormKey.currentState!.validate()) {}
                      },
                      child: const Text('Lưu')),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          SignalRow(
              encounter: args.patient.encounter,
              division: args.division,
              request: 0,
              listSignals: listBloodTypeSignals),
        ]);
  }

  ExpansionTile _buildWeight(BuildContext context) {
    return ExpansionTile(
        onExpansionChanged: (bool expanded) {
          setState(() {
            _weightExpanded = expanded;
          });
        },
        initiallyExpanded: _weightExpanded,
        collapsedShape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        title: Text(
          'Cân nặng',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16),
        children: [
          Form(
            key: _weightFormKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      helperText: 'Đơn vị: Kg',
                      helperStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền vào chỗ trống';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_weightFormKey.currentState!.validate()) {}
                      },
                      child: const Text('Lưu')),
                )
              ],
            ),
          ),
          SignalRow(
              encounter: args.patient.encounter,
              division: args.division,
              request: 0,
              listSignals: listWeightSignals),
        ]);
  }

  ExpansionTile _buildHeight(BuildContext context) {
    return ExpansionTile(
        onExpansionChanged: (bool expanded) {
          setState(() {
            _heightExpanded = expanded;
          });
        },
        initiallyExpanded: _heightExpanded,
        collapsedShape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        title: Text(
          'Chiều cao',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16),
        children: [
          Form(
            key: _heightFormKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      helperText: 'Đơn vị: cm',
                      helperStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền vào chỗ trống';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_heightFormKey.currentState!.validate()) {}
                      },
                      child: const Text('Lưu')),
                )
              ],
            ),
          ),
          SignalRow(
              encounter: args.patient.encounter,
              division: args.division,
              request: 0,
              listSignals: listHeightSignals),
        ]);
  }

  ExpansionTile _buildRespiratory(BuildContext context) {
    return ExpansionTile(
        onExpansionChanged: (bool expanded) {
          setState(() {
            _respiratoryRateExpanded = expanded;
          });
        },
        initiallyExpanded: _respiratoryRateExpanded,
        collapsedShape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        title: Text(
          'Nhịp thở',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16),
        children: [
          Form(
            key: _respiratoryRateFormKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      helperText: 'Đơn vị: lần/phút',
                      helperStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền vào chỗ trống';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_respiratoryRateFormKey.currentState!.validate()) {}
                      },
                      child: const Text('Lưu')),
                )
              ],
            ),
          ),
          SignalRow(
              encounter: args.patient.encounter,
              division: args.division,
              request: 0,
              listSignals: listRespiratoryRateSignals),
        ]);
  }

  ExpansionTile _buildTemperature(BuildContext context) {
    return ExpansionTile(
        onExpansionChanged: (bool expanded) {
          setState(() {
            _temperatureExpanded = expanded;
          });
        },
        initiallyExpanded: _temperatureExpanded,
        collapsedShape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        title: Text(
          'Nhiệt độ',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16),
        children: [
          Form(
            key: _temperatureFormKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      helperText: 'Đơn vị: độ C',
                      helperStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền vào chỗ trống';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_temperatureFormKey.currentState!.validate()) {}
                      },
                      child: const Text('Lưu')),
                )
              ],
            ),
          ),
          SignalRow(
              encounter: args.patient.encounter,
              division: args.division,
              request: 0,
              listSignals: listTemperatureSignals),
        ]);
  }

  ExpansionTile _buildSP02(BuildContext context) {
    return ExpansionTile(
        onExpansionChanged: (bool expanded) {
          setState(() {
            _sp02Expanded = expanded;
          });
        },
        initiallyExpanded: _sp02Expanded,
        collapsedShape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        title: Text(
          'SPO2',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16),
        children: [
          Form(
            key: _sp02FormKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      helperText: 'Đơn vị: %',
                      helperStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền vào chỗ trống';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_sp02FormKey.currentState!.validate()) {}
                      },
                      child: const Text('Lưu')),
                )
              ],
            ),
          ),
          SignalRow(
              encounter: args.patient.encounter,
              division: args.division,
              request: 0,
              listSignals: listSP02Signals),
        ]);
  }

  ExpansionTile _buildBloodPressure(BuildContext context) {
    return ExpansionTile(
        onExpansionChanged: (bool expanded) {
          setState(() {
            _bloodPressureExpanded = expanded;
          });
        },
        initiallyExpanded: _bloodPressureExpanded,
        collapsedShape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        title: Text(
          'Huyết áp',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16),
        children: [
          Form(
            key: _bloolPressureFormKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      helperText: 'Đơn vị: mmHg',
                      helperStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền vào chỗ trống';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_bloolPressureFormKey.currentState!.validate()) {}
                      },
                      child: const Text('Lưu')),
                )
              ],
            ),
          ),
          SignalRow(
              encounter: args.patient.encounter,
              division: args.division,
              request: 0,
              listSignals: listBloodPressureSignals),
        ]);
  }

  ExpansionTile _buildHeartRate(BuildContext context) {
    return ExpansionTile(
        onExpansionChanged: (bool expanded) {
          setState(() {
            _heartRateExpanded = expanded;
          });
        },
        initiallyExpanded: _heartRateExpanded,
        collapsedShape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        title: Text(
          'Mạch',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16),
        children: [
          Form(
            key: _heartRateFormKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      helperText: 'Đơn vị: lần/phút',
                      helperStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền vào chỗ trống';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_heartRateFormKey.currentState!.validate()) {}
                      },
                      child: const Text('Lưu')),
                )
              ],
            ),
          ),
          SignalRow(
              encounter: args.patient.encounter,
              division: args.division,
              request: 0,
              listSignals: listHeartRateSignals),
        ]);
  }
}
