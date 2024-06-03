import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/enums.dart';
import 'package:medical_examination_app/core/common/helpers.dart';
import 'package:medical_examination_app/core/common/widgets.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/care_sheet_entity.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/streatment_sheet_entity.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/providers/medical_examine_provider.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/widgets/entered_signal_table.dart';
import 'package:medical_examination_app/features/patient/presentation/pages/search_patient_page.dart';
import 'package:provider/provider.dart';

class MedicalExaminationPage extends StatefulWidget {
  const MedicalExaminationPage({super.key});

  @override
  State<MedicalExaminationPage> createState() => _MedicalExaminationPageState();
}

class _MedicalExaminationPageState extends State<MedicalExaminationPage> {
  int _index = 0;
  bool _userInfoExpanded = false;
  late PatientInfoArguments args;

  List<SignalEntity> listHeartSignals = [];
  List<SignalEntity> listBloodPressureSignals = [];
  List<SignalEntity> listTemperatureSignals = [];
  List<SignalEntity> listSP02Signals = [];
  List<SignalEntity> listRespiratorySignals = [];
  List<SignalEntity> listOxygenSignals = [];
  List<SignalEntity> listWeightSignals = [];
  List<SignalEntity> listHeightSignals = [];
  List<SignalEntity> listBloodGroupSignals = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as PatientInfoArguments;
    Provider.of<MedicalExamineProvider>(context, listen: false)
        .eitherFailureOrGetEnteredSignals(
            'all', args.patient.encounter.toString());
    Provider.of<MedicalExamineProvider>(context, listen: false)
        .eitherFailureOrGetEnteredStreatSheets(
            OET.OET_001.name, args.patient.encounter.toString());
    Provider.of<MedicalExamineProvider>(context, listen: false)
        .eitherFailureOrGetEnteredCareSheets(
            OET.OET_002.name, args.patient.encounter.toString());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Ghi nhận thông tin\nthăm khám',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              // Patient info
              _buildPatientInfo(context),
              Stepper(
                physics: const NeverScrollableScrollPhysics(),
                currentStep: _index,
                onStepCancel: () {
                  if (_index > 0) {
                    setState(() {
                      _index -= 1;
                    });
                  }
                },
                onStepContinue: () {
                  if (_index <= 1) {
                    setState(() {
                      _index += 1;
                    });
                  }
                },
                onStepTapped: (int index) {
                  setState(() {
                    _index = index;
                  });
                },
                controlsBuilder: (context, details) => Column(
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (_index > 0)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade400,
                                padding: const EdgeInsets.all(12)),
                            onPressed: details.onStepCancel,
                            child: const Text('Quay lại'),
                          ),
                        const SizedBox(width: 8),
                        if (_index < 2)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(12)),
                            onPressed: details.onStepContinue,
                            child: const Text('Tiếp theo'),
                          ),
                        // if (_index == 2)
                        //   ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //         padding: const EdgeInsets.all(12)),
                        //     onPressed: () {},
                        //     child: const Text('Hoàn tất'),
                        //   ),
                      ],
                    ),
                  ],
                ),
                steps: <Step>[
                  _buildInputSignalStep(context),
                  _buildInputStreatmentSheetStep(context),
                  _buildInputCareSheetStep(context),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Hoàn tất'),
                ),
              ),
            ],
          ),
        ));
  }

  Step _buildInputCareSheetStep(BuildContext context) {
    return Step(
      stepStyle: StepStyle(
        color: _index == 2 ? Colors.blue : Colors.grey.shade400,
      ),
      title: Text(
        'Tờ chăm sóc',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: _index == 2 ? Colors.blue : Colors.black,
            fontWeight: FontWeight.bold),
      ),
      content:
          Consumer<MedicalExamineProvider>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (value.listEnteredCareSheets.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteNames.addCareSheet,
                      arguments: PatientInfoArguments(
                          patient: args.patient, division: args.division));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add_rounded, color: Colors.blue),
                    Text('Thêm tờ chăm sóc mới',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.blue)),
                  ],
                ),
              ),
            ],
          );
        }
        if (value.failureCareSheet != null) {
          return Center(
            child: Text(value.failure!.errorMessage),
          );
        }
        return Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                  itemBuilder: (context, index) {
                    CareSheetEntity careSheet =
                        value.listEnteredCareSheets[index];
                    return SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tờ chăm sóc số ${index + 1}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(8),
                                          backgroundColor: Colors.blue),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, RouteNames.editCareSheet,
                                            arguments:
                                                ModifyMedicalSheetArguments<
                                                        CareSheetEntity>(
                                                    patientInfo: args,
                                                    medicalSheet: careSheet));
                                      },
                                      child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.edit_outlined),
                                            Text('Chỉnh sửa')
                                          ])),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(8),
                                          backgroundColor: Colors.red),
                                      onPressed: () {},
                                      child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.close_rounded),
                                            Text('Xóa')
                                          ])),
                                ],
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                  careSheet.value!.length,
                                  (index1) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${codeToItemStreatmentSheet(careSheet.value![index1].code)}:'),
                                        const SizedBox(height: 4),
                                        ListView(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: [
                                            ...List.generate(
                                                careSheet.value![index1].value
                                                    .length, (index2) {
                                              return Text(
                                                  '${index2 + 1}. ${careSheet.value![index1].value[index2]}');
                                            })
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: value.listEnteredCareSheets.length,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteNames.addCareSheet,
                        arguments: PatientInfoArguments(
                            patient: args.patient, division: args.division));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add_rounded, color: Colors.blue),
                      Text('Thêm tờ chăm sóc mới',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.blue)),
                    ],
                  ),
                ),
              ],
            ));
      }),
    );
  }

  Step _buildInputStreatmentSheetStep(BuildContext context) {
    return Step(
      stepStyle: StepStyle(
        color: _index == 1 ? Colors.blue : Colors.grey.shade400,
      ),
      title: Text(
        'Tờ điều trị',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: _index == 1 ? Colors.blue : Colors.black,
            fontWeight: FontWeight.bold),
      ),
      content:
          Consumer<MedicalExamineProvider>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (value.listEnteredStreatmentSheets.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteNames.addStreatmentSheet,
                      arguments: PatientInfoArguments(
                          patient: args.patient, division: args.division));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add_rounded, color: Colors.blue),
                    Text('Thêm tờ điều trị mới',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.blue)),
                  ],
                ),
              ),
            ],
          );
        }
        if (value.failureStreatmentSheet != null) {
          return Center(
            child: Text(value.failure!.errorMessage),
          );
        }
        return Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                  itemBuilder: (context, index) {
                    StreatmentSheetEntity streatmentSheet =
                        value.listEnteredStreatmentSheets[index];
                    return SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tờ điều trị số ${index + 1}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(8),
                                          backgroundColor: Colors.blue),
                                      onPressed: () {
                                        Navigator.pushNamed(context,
                                            RouteNames.editStreatmentSheet,
                                            arguments:
                                                ModifyMedicalSheetArguments<
                                                        StreatmentSheetEntity>(
                                                    patientInfo: args,
                                                    medicalSheet:
                                                        streatmentSheet));
                                      },
                                      child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.edit_outlined),
                                            Text('Chỉnh sửa')
                                          ])),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(8),
                                          backgroundColor: Colors.red),
                                      onPressed: () {},
                                      child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.close_rounded),
                                            Text('Xóa')
                                          ])),
                                ],
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                  streatmentSheet.value!.length,
                                  (index1) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${codeToItemStreatmentSheet(streatmentSheet.value![index1].code)}:'),
                                        const SizedBox(height: 4),
                                        ListView(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: [
                                            ...List.generate(
                                                streatmentSheet.value![index1]
                                                    .value.length, (index2) {
                                              return Text(
                                                  '${index2 + 1}. ${streatmentSheet.value![index1].value[index2]}');
                                            })
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: value.listEnteredStreatmentSheets.length,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        RouteNames.addStreatmentSheet,
                        arguments: PatientInfoArguments(
                            patient: args.patient, division: args.division));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add_rounded, color: Colors.blue),
                      Text('Thêm tờ điều trị mới',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.blue)),
                    ],
                  ),
                ),
              ],
            ));
      }),
    );
  }

  Step _buildInputSignalStep(BuildContext context) {
    return Step(
      stepStyle: StepStyle(
        color: _index == 0 ? Colors.blue : Colors.grey.shade400,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Sinh hiệu',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: _index == 0 ? Colors.blue : Colors.black,
                fontWeight: FontWeight.bold),
          ),
          if (_index == 0)
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8),
                    backgroundColor: Colors.blue),
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteNames.addSignal,
                      arguments: PatientInfoArguments(
                          patient: args.patient, division: args.division));
                },
                child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.edit_outlined), Text('Chỉnh sửa')])),
        ],
      ),
      content:
          Consumer<MedicalExamineProvider>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (value.listEnteredSignals.isEmpty) {
          // return Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     TextButton(
          //       onPressed: () {
          //         Navigator.of(context)
          //             .pushNamed(RouteNames.addStreatmentSheet);
          //       },
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           const Icon(Icons.add_rounded, color: Colors.blue),
          //           Text('Thêm sinh hiệu mới',
          //               style: Theme.of(context)
          //                   .textTheme
          //                   .bodyMedium!
          //                   .copyWith(color: Colors.blue)),
          //         ],
          //       ),
          //     ),
          //   ],
          // );
          return const Center(
            child: Text('Chưa có dữ liệu'),
          );
        }
        if (value.failure != null) {
          return Center(
            child: Text(value.failure!.errorMessage),
          );
        }
        listBloodPressureSignals = value.listEnteredSignals
            .where((element) => element.code == SignalType.SIG_01.name)
            .toList();
        listHeartSignals = value.listEnteredSignals
            .where((element) => element.code == SignalType.SIG_02.name)
            .toList();
        listTemperatureSignals = value.listEnteredSignals
            .where((element) => element.code == SignalType.SIG_03.name)
            .toList();
        listSP02Signals = value.listEnteredSignals
            .where((element) => element.code == SignalType.SIG_04.name)
            .toList();
        listRespiratorySignals = value.listEnteredSignals
            .where((element) => element.code == SignalType.SIG_05.name)
            .toList();
        listHeightSignals = value.listEnteredSignals
            .where((element) => element.code == SignalType.SIG_08.name)
            .toList();
        listWeightSignals = value.listEnteredSignals
            .where((element) => element.code == SignalType.SIG_06.name)
            .toList();
        listBloodGroupSignals = value.listEnteredSignals
            .where((element) => element.code == SignalType.SIG_10.name)
            .toList();

        return Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (listBloodPressureSignals.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LabelTextField(label: 'Huyết áp'),
                          const SizedBox(height: 4),
                          EnteredSignalTable(
                              context: context,
                              listSignals: listBloodPressureSignals),
                          const SizedBox(height: 12),
                        ],
                      ),
                    if (listHeartSignals.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LabelTextField(label: 'Mạch'),
                          const SizedBox(height: 4),
                          // Table with 2 columns: value and date
                          EnteredSignalTable(
                              context: context, listSignals: listHeartSignals),
                          const SizedBox(height: 12),
                        ],
                      ),
                    if (listTemperatureSignals.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LabelTextField(label: 'Nhiệt độ'),
                          const SizedBox(height: 4),
                          // Table with 2 columns: value and date
                          EnteredSignalTable(
                              context: context,
                              listSignals: listTemperatureSignals),
                          const SizedBox(height: 12),
                        ],
                      ),
                    if (listSP02Signals.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LabelTextField(label: 'SP02'),
                          const SizedBox(height: 4),
                          // Table with 2 columns: value and date
                          EnteredSignalTable(
                              context: context, listSignals: listSP02Signals),
                          const SizedBox(height: 12),
                        ],
                      ),
                    if (listRespiratorySignals.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LabelTextField(label: 'Nhịp thở'),
                          const SizedBox(height: 4),
                          // Table with 2 columns: value and date
                          EnteredSignalTable(
                              context: context,
                              listSignals: listRespiratorySignals),
                          const SizedBox(height: 12),
                        ],
                      ),
                    if (listWeightSignals.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LabelTextField(label: 'Cân nặng'),
                          const SizedBox(height: 4),
                          // Table with 2 columns: value and date
                          EnteredSignalTable(
                              context: context, listSignals: listWeightSignals),
                          const SizedBox(height: 12),
                        ],
                      ),
                    if (listHeightSignals.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LabelTextField(label: 'Chiều cao'),
                          const SizedBox(height: 4),
                          // Table with 2 columns: value and date
                          EnteredSignalTable(
                              context: context, listSignals: listHeightSignals),
                          const SizedBox(height: 12),
                        ],
                      ),
                    if (listBloodGroupSignals.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LabelTextField(label: 'Nhóm máu'),
                          const SizedBox(height: 4),
                          // Table with 2 columns: value and date
                          EnteredSignalTable(
                              context: context,
                              listSignals: listBloodGroupSignals),
                          const SizedBox(height: 12),
                        ],
                      ),
                  ],
                ),
                // const SizedBox(height: 16),
              ],
            ));
      }),
    );
  }

  Padding _buildPatientInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
          onExpansionChanged: (bool expanded) {
            setState(() {
              _userInfoExpanded = expanded;
            });
          },
          collapsedShape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade300, width: 1.5),
              borderRadius: BorderRadius.circular(8)),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade300, width: 1.5),
              borderRadius: BorderRadius.circular(8)),
          title: Text(
            _userInfoExpanded ? 'Thông tin bệnh nhân' : args.patient.name,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          childrenPadding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'STT: ${args.patient.encounter}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  args.patient.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Mã số: ${args.patient.subject}",
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Giới tính: ${args.patient.gender}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "Ngày sinh: ${args.patient.birthdate}",
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
            // const SizedBox(height: 8),
            // Text('Địa chỉ: ${args.patient.address}',
            //     style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text(
              'Loại bệnh án: ${args.patient.classifyName}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontStyle: FontStyle.italic),
            ),
          ]),
    );
  }
}

class ModifyMedicalSheetArguments<T> {
  final PatientInfoArguments patientInfo;
  final T medicalSheet;

  ModifyMedicalSheetArguments(
      {required this.patientInfo, required this.medicalSheet});
}
