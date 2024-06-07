// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/enums.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/errors/failure.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/providers/medical_examine_provider.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/widgets/input_blood_signal_form.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/widgets/input_signal_form.dart';
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
  PatientInfoArguments? args;
  bool isLoadingPage = true;
  bool isEdited = false;

  List<SignalEntity> listHeartRateSignals = [];
  List<SignalEntity> listBloodPressureSignals = [];
  List<SignalEntity> listTemperatureSignals = [];
  List<SignalEntity> listSP02Signals = [];
  List<SignalEntity> listRespiratoryRateSignals = [];
  List<SignalEntity> listHeightSignals = [];
  List<SignalEntity> listWeightSignals = [];
  List<SignalEntity> listBloodTypeSignals = [];
  late MedicalExamineProvider provider;
  void updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> loadSignals(final provider, int encounter, String signalType,
      Function setSignalList) async {
    final signals = await provider.eitherFailureOrGetEnteredSignals(
        signalType, encounter.toString());
    setSignalList(signals);
    // updateState();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // final encounter =
      //     ModalRoute.of(context)!.settings.arguments as PatientInfoArguments;

      await loadSignals(provider, args!.patient.encounter,
          SignalType.SIG_02.name, (signals) => listHeartRateSignals = signals);
      await loadSignals(
          provider,
          args!.patient.encounter,
          SignalType.SIG_01.name,
          (signals) => listBloodPressureSignals = signals);
      await loadSignals(
          provider,
          args!.patient.encounter,
          SignalType.SIG_03.name,
          (signals) => listTemperatureSignals = signals);
      await loadSignals(provider, args!.patient.encounter,
          SignalType.SIG_04.name, (signals) => listSP02Signals = signals);
      await loadSignals(
          provider,
          args!.patient.encounter,
          SignalType.SIG_05.name,
          (signals) => listRespiratoryRateSignals = signals);
      await loadSignals(provider, args!.patient.encounter,
          SignalType.SIG_08.name, (signals) => listHeightSignals = signals);
      await loadSignals(provider, args!.patient.encounter,
          SignalType.SIG_06.name, (signals) => listWeightSignals = signals);
      await loadSignals(provider, args!.patient.encounter,
          SignalType.SIG_10.name, (signals) => listBloodTypeSignals = signals);

      isLoadingPage = false;
      updateState();
    });

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    args = ModalRoute.of(context)!.settings.arguments as PatientInfoArguments;
    provider = Provider.of<MedicalExamineProvider>(context, listen: false);
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
      body: isLoadingPage
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PopScope(
              onPopInvoked: (didPop) {
                if (isEdited) {
                  Provider.of<MedicalExamineProvider>(context, listen: false)
                      .eitherFailureOrGetEnteredSignals(
                          'all', args!.patient.encounter.toString());
                }
                if (didPop) {
                  return;
                }
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: SingleChildScrollView(
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
                          onPressed: Provider.of<MedicalExamineProvider>(
                                      context,
                                      listen: true)
                                  .isLoading
                              ? null
                              : () {
                                  Navigator.of(context).pop();
                                },
                          child: const Text('Hoàn tất'),
                        ),
                      )
                    ],
                  ),
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
          InputBloodTypeForm(
            onSubmitted: (value) async {
              final result = await Provider.of<MedicalExamineProvider>(context,
                      listen: false)
                  .eitherFailureOrModifySignal(
                      SignalEntity(
                        status: SignalStatus.NEW,
                        code: SignalType.SIG_10.name,
                        value: "",
                        valueString: value,
                        unit: "",
                      ),
                      args?.patient.encounter ?? 0,
                      0,
                      args?.division ?? 0);

              if (result.runtimeType == Failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as Failure).errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as ResponseModel).message),
                    backgroundColor: Colors.green,
                  ),
                );
                // Refresh the list of signals
                isEdited = true;
                await loadSignals(
                    provider, args!.patient.encounter, SignalType.SIG_10.name,
                    (signals) {
                  listBloodTypeSignals = signals;
                  updateState();
                });
              }
            },
          ),
          const SizedBox(height: 16),
          SignalRow(
            encounter: args?.patient.encounter ?? 0,
            division: args?.division ?? 0,
            request: 0,
            listSignals: listBloodTypeSignals,
            onRefresh: () async {
              isEdited = true;
              await loadSignals(
                  provider, args!.patient.encounter, SignalType.SIG_10.name,
                  (signals) {
                listBloodTypeSignals = signals;
                updateState();
              });
            },
          ),
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
          InputSignalForm(
            onSubmitted: (value) async {
              final result = await Provider.of<MedicalExamineProvider>(context,
                      listen: false)
                  .eitherFailureOrModifySignal(
                      SignalEntity(
                        status: SignalStatus.NEW,
                        code: SignalType.SIG_06.name,
                        value: value,
                        valueString: "",
                        unit: Unit.KG,
                      ),
                      args?.patient.encounter ?? 0,
                      0,
                      args?.division ?? 0);

              if (result.runtimeType == Failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as Failure).errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
                return false;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as ResponseModel).message),
                    backgroundColor: Colors.green,
                  ),
                );
                // Refresh the list of signals
                isEdited = true;
                await loadSignals(
                    provider, args!.patient.encounter, SignalType.SIG_06.name,
                    (signals) {
                  listWeightSignals = signals;
                  updateState();
                });
                return true;
              }
            },
            unit: Unit.KG,
          ),
          SignalRow(
            encounter: args?.patient.encounter ?? 0,
            division: args?.division ?? 0,
            request: 0,
            listSignals: listWeightSignals,
            onRefresh: () async {
              isEdited = true;
              await loadSignals(
                  provider, args!.patient.encounter, SignalType.SIG_06.name,
                  (signals) {
                listWeightSignals = signals;
                updateState();
              });
            },
          ),
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
          InputSignalForm(
            onSubmitted: (value) async {
              final result = await Provider.of<MedicalExamineProvider>(context,
                      listen: false)
                  .eitherFailureOrModifySignal(
                      SignalEntity(
                        status: SignalStatus.NEW,
                        code: SignalType.SIG_08.name,
                        value: value,
                        valueString: "",
                        unit: Unit.CM,
                      ),
                      args?.patient.encounter ?? 0,
                      0,
                      args?.division ?? 0);

              if (result.runtimeType == Failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as Failure).errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
                return false;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as ResponseModel).message),
                    backgroundColor: Colors.green,
                  ),
                );
                // Refresh the list of signals
                isEdited = true;
                await loadSignals(
                    provider, args!.patient.encounter, SignalType.SIG_08.name,
                    (signals) {
                  listHeightSignals = signals;
                  updateState();
                });
                return true;
              }
            },
            unit: Unit.CM,
          ),
          SignalRow(
            encounter: args?.patient.encounter ?? 0,
            division: args?.division ?? 0,
            request: 0,
            listSignals: listHeightSignals,
            onRefresh: () async {
              isEdited = true;
              await loadSignals(
                  provider, args!.patient.encounter, SignalType.SIG_08.name,
                  (signals) {
                listHeightSignals = signals;
                updateState();
              });
            },
          ),
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
          InputSignalForm(
            onSubmitted: (value) async {
              final result = await Provider.of<MedicalExamineProvider>(context,
                      listen: false)
                  .eitherFailureOrModifySignal(
                      SignalEntity(
                        status: SignalStatus.NEW,
                        code: SignalType.SIG_05.name,
                        value: value,
                        valueString: "",
                        unit: Unit.timePerMinute,
                      ),
                      args?.patient.encounter ?? 0,
                      0,
                      args?.division ?? 0);

              if (result.runtimeType == Failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as Failure).errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
                return false;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as ResponseModel).message),
                    backgroundColor: Colors.green,
                  ),
                );
                // Refresh the list of signals
                isEdited = true;
                await loadSignals(
                    provider, args!.patient.encounter, SignalType.SIG_05.name,
                    (signals) {
                  listRespiratoryRateSignals = signals;
                  updateState();
                });
                return true;
              }
            },
            unit: Unit.timePerMinute,
          ),
          SignalRow(
            encounter: args?.patient.encounter ?? 0,
            division: args?.division ?? 0,
            request: 0,
            listSignals: listRespiratoryRateSignals,
            onRefresh: () async {
              isEdited = true;
              await loadSignals(
                  provider, args!.patient.encounter, SignalType.SIG_05.name,
                  (signals) {
                listRespiratoryRateSignals = signals;
                updateState();
              });
            },
          ),
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
          InputSignalForm(
            onSubmitted: (value) async {
              final result = await Provider.of<MedicalExamineProvider>(context,
                      listen: false)
                  .eitherFailureOrModifySignal(
                      SignalEntity(
                        status: SignalStatus.NEW,
                        code: SignalType.SIG_03.name,
                        value: value,
                        valueString: "",
                        unit: Unit.CELSIUS,
                      ),
                      args?.patient.encounter ?? 0,
                      0,
                      args?.division ?? 0);

              if (result.runtimeType == Failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as Failure).errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
                return false;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as ResponseModel).message),
                    backgroundColor: Colors.green,
                  ),
                );
                // Refresh the list of signals
                isEdited = true;
                await loadSignals(
                    provider, args!.patient.encounter, SignalType.SIG_03.name,
                    (signals) {
                  listTemperatureSignals = signals;
                  updateState();
                });
                return true;
              }
            },
            unit: Unit.CELSIUS,
          ),
          SignalRow(
            encounter: args?.patient.encounter ?? 0,
            division: args?.division ?? 0,
            request: 0,
            listSignals: listTemperatureSignals,
            onRefresh: () async {
              isEdited = true;
              await loadSignals(
                  provider, args!.patient.encounter, SignalType.SIG_03.name,
                  (signals) {
                listTemperatureSignals = signals;
                updateState();
              });
            },
          ),
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
          InputSignalForm(
            onSubmitted: (value) async {
              final result = await Provider.of<MedicalExamineProvider>(context,
                      listen: false)
                  .eitherFailureOrModifySignal(
                      SignalEntity(
                        status: SignalStatus.NEW,
                        code: SignalType.SIG_04.name,
                        value: value,
                        valueString: "",
                        unit: Unit.PERCENT,
                      ),
                      args?.patient.encounter ?? 0,
                      0,
                      args?.division ?? 0);

              if (result.runtimeType == Failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as Failure).errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
                return false;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as ResponseModel).message),
                    backgroundColor: Colors.green,
                  ),
                );
                // Refresh the list of signals
                isEdited = true;
                await loadSignals(
                    provider, args!.patient.encounter, SignalType.SIG_04.name,
                    (signals) {
                  listSP02Signals = signals;
                  updateState();
                });
                return true;
              }
            },
            unit: Unit.PERCENT,
          ),
          SignalRow(
            encounter: args?.patient.encounter ?? 0,
            division: args?.division ?? 0,
            request: 0,
            listSignals: listSP02Signals,
            onRefresh: () async {
              isEdited = true;
              await loadSignals(
                  provider, args!.patient.encounter, SignalType.SIG_04.name,
                  (signals) {
                listSP02Signals = signals;
                updateState();
              });
            },
          ),
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
          InputSignalForm(
            onSubmitted: (value) async {
              final result = await Provider.of<MedicalExamineProvider>(context,
                      listen: false)
                  .eitherFailureOrModifySignal(
                      SignalEntity(
                        status: SignalStatus.NEW,
                        code: SignalType.SIG_01.name,
                        value: value,
                        valueString: "",
                        unit: Unit.MMHG,
                      ),
                      args?.patient.encounter ?? 0,
                      0,
                      args?.division ?? 0);

              if (result.runtimeType == Failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as Failure).errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
                return false;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as ResponseModel).message),
                    backgroundColor: Colors.green,
                  ),
                );
                // Refresh the list of signals
                isEdited = true;
                await loadSignals(
                    provider, args!.patient.encounter, SignalType.SIG_01.name,
                    (signals) {
                  listBloodPressureSignals = signals;
                  updateState();
                });
                return true;
              }
            },
            unit: Unit.MMHG,
          ),
          SignalRow(
            encounter: args?.patient.encounter ?? 0,
            division: args?.division ?? 0,
            request: 0,
            listSignals: listBloodPressureSignals,
            onRefresh: () async {
              isEdited = true;
              await loadSignals(
                  provider, args!.patient.encounter, SignalType.SIG_01.name,
                  (signals) {
                listBloodPressureSignals = signals;
                updateState();
              });
            },
          ),
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
          InputSignalForm(
            onSubmitted: (value) async {
              final result = await Provider.of<MedicalExamineProvider>(context,
                      listen: false)
                  .eitherFailureOrModifySignal(
                      SignalEntity(
                        status: SignalStatus.NEW,
                        code: SignalType.SIG_02.name,
                        value: value,
                        valueString: "",
                        unit: Unit.timePerMinute,
                      ),
                      args?.patient.encounter ?? 0,
                      0,
                      args?.division ?? 0);

              if (result.runtimeType == Failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as Failure).errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
                return false;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((result as ResponseModel).message),
                    backgroundColor: Colors.green,
                  ),
                );
                // Refresh the list of signals
                isEdited = true;
                await loadSignals(
                    provider, args!.patient.encounter, SignalType.SIG_02.name,
                    (signals) {
                  listHeartRateSignals = signals;
                  updateState();
                });
                return true;
              }
            },
            unit: Unit.timePerMinute,
          ),
          SignalRow(
            encounter: args?.patient.encounter ?? 0,
            division: args?.division ?? 0,
            request: 0,
            listSignals: listHeartRateSignals,
            onRefresh: () async {
              isEdited = true;
              await loadSignals(
                  provider, args!.patient.encounter, SignalType.SIG_02.name,
                  (signals) {
                listHeartRateSignals = signals;
                updateState();
              });
            },
          ),
        ]);
  }
}
