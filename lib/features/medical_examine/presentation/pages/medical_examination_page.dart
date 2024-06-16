import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_examination_app/core/common/enums.dart';
import 'package:medical_examination_app/core/common/helpers.dart';
import 'package:medical_examination_app/core/common/widgets.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/errors/failure.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/care_sheet_entity.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/streatment_sheet_entity.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/providers/medical_examine_provider.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/widgets/entered_signal_table.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_entity.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_service_entity.dart';
import 'package:medical_examination_app/features/patient/presentation/pages/search_patient_page.dart';
import 'package:medical_examination_app/features/patient/presentation/providers/patient_provider.dart';
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
  bool isExpandedPubSer = false;
  Map<String, List<PatientServiceEntity>>? groupByReportCode;
  List<Item>? data;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PatientProvider>(context, listen: false)
          .eitherFailureOrGetPatientInfo('all', args.patient.encounter);
      Provider.of<MedicalExamineProvider>(context, listen: false)
          .eitherFailureOrGetEnteredSignals(
              'all', args.patient.encounter.toString());
      Provider.of<MedicalExamineProvider>(context, listen: false)
          .eitherFailureOrGetEnteredStreatSheets(
              OET.OET_001.name, args.patient.encounter.toString());
      ;
      Provider.of<PatientProvider>(context, listen: false)
          .eitherFailureOrGetPatientServices('all', args.patient.encounter);

      Provider.of<MedicalExamineProvider>(context, listen: false)
          .eitherFailureOrGetEnteredCareSheets(
              OET.OET_002.name, args.patient.encounter.toString());
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as PatientInfoArguments;
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
                  if (_index <= 2) {
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
                                backgroundColor: Colors.grey,
                                padding: const EdgeInsets.all(12)),
                            onPressed: details.onStepCancel,
                            child: const Text('Quay lại'),
                          ),
                        const SizedBox(width: 8),
                        if (_index < 3)
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
                margin: EdgeInsets.zero,
                steps: <Step>[
                  _buildInputSignalStep(context),
                  _buildInputStreatmentSheetStep(context),
                  _buildSubclinicSerDesignationStep(context),
                  _buildInputCareSheetStep(context),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
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
        color: _index == 3 ? Colors.blue : Colors.grey.shade400,
      ),
      title: Text(
        'Tờ chăm sóc',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: _index == 3 ? Colors.blue : Colors.black,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('Các lần ghi nhận',
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .bodyMedium!
                  //         .copyWith(fontWeight: FontWeight.bold)),
                  // const SizedBox(height: 8),
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
                        Text('Ghi nhận thông tin',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.blue)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        if (value.failureCareSheet != null) {
          return Center(
            child: Text(value.failureCareSheet!.errorMessage),
          );
        }
        return Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Các lần ghi nhận',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
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
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  careSheet.status == OETTYPE.draft.name
                                      ? const Tooltip(
                                          triggerMode: TooltipTriggerMode.tap,
                                          message: "Bản nháp",
                                          child: Icon(FontAwesomeIcons.file,
                                              color: Colors.amber),
                                        )
                                      : const Tooltip(
                                          triggerMode: TooltipTriggerMode.tap,
                                          message: "Đã ban hành",
                                          child: Icon(Icons.verified_outlined,
                                              color: Colors.green),
                                        ),
                                  const SizedBox(width: 4),
                                  Text('Lần ${index + 1}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                children: [
                                  if (careSheet.status == OETTYPE.draft.name)
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
                                  if (careSheet.status == OETTYPE.draft.name)
                                    const SizedBox(width: 8),
                                  if (careSheet.status == OETTYPE.draft.name)
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(8),
                                            backgroundColor: Colors.green),
                                        onPressed: () async {
                                          await showConfirmDialog(
                                            context,
                                            'Bạn có chắc chắn muốn ban hành tờ chăm sóc này không?',
                                            (BuildContext contextInner) async {
                                              final result = await Provider.of<
                                                          MedicalExamineProvider>(
                                                      context,
                                                      listen: false)
                                                  .eitherFailureOrPublishSheet(
                                                      careSheet.encounter!,
                                                      careSheet.id!,
                                                      OETTYPE.publish.name,
                                                      args.patient.encounter);

                                              if (result.runtimeType ==
                                                  Failure) {
                                                ScaffoldMessenger.of(
                                                        contextInner)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        (result as Failure)
                                                            .errorMessage),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(
                                                        contextInner)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text((result
                                                            as ResponseModel)
                                                        .message),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                                Provider.of<MedicalExamineProvider>(
                                                        contextInner,
                                                        listen: false)
                                                    .eitherFailureOrGetEnteredCareSheets(
                                                        OET.OET_002.name,
                                                        args.patient.encounter
                                                            .toString());
                                              }
                                            },
                                          );
                                        },
                                        child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.verified_outlined),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text('Ban hành')
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
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1.5),
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
                                          '${codeToItemStreatmentSheet(careSheet.value![index1].code)}:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
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
                                                  '- ${careSheet.value![index1].value[index2]}');
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
                      Text('Ghi nhận thông tin',
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('Các lần ghi nhận',
              //     style: Theme.of(context)
              //         .textTheme
              //         .bodyMedium!
              //         .copyWith(fontWeight: FontWeight.bold)),
              // const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                        Text('Ghi nhận thông tin',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.blue)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        if (value.failureStreatmentSheet != null) {
          return Center(
            child: Text(value.failureStreatmentSheet!.errorMessage),
          );
        }
        return Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('Các lần ghi nhận',
                //     style: Theme.of(context)
                //         .textTheme
                //         .bodyMedium!
                //         .copyWith(fontWeight: FontWeight.bold)),
                // const SizedBox(height: 8),
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
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  streatmentSheet.status == OETTYPE.draft.name
                                      ? const Tooltip(
                                          triggerMode: TooltipTriggerMode.tap,
                                          message: "Bản nháp",
                                          child: Icon(FontAwesomeIcons.file,
                                              color: Colors.amber),
                                        )
                                      : const Tooltip(
                                          triggerMode: TooltipTriggerMode.tap,
                                          message: "Đã ban hành",
                                          child: Icon(Icons.verified_outlined,
                                              color: Colors.green),
                                        ),
                                  const SizedBox(width: 4),
                                  Text('Lần ${index + 1}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                children: [
                                  if (streatmentSheet.status ==
                                      OETTYPE.draft.name)
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
                                  if (streatmentSheet.status ==
                                      OETTYPE.draft.name)
                                    const SizedBox(width: 8),
                                  if (streatmentSheet.status ==
                                      OETTYPE.draft.name)
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(8),
                                            backgroundColor: Colors.green),
                                        onPressed: () async {
                                          await showConfirmDialog(
                                            context,
                                            'Bạn có chắc chắn muốn ban hành tờ điều trị này không?',
                                            (BuildContext contextInner) async {
                                              final result = await Provider.of<
                                                          MedicalExamineProvider>(
                                                      context,
                                                      listen: false)
                                                  .eitherFailureOrPublishSheet(
                                                      streatmentSheet
                                                          .encounter!,
                                                      streatmentSheet.id!,
                                                      OETTYPE.publish.name,
                                                      args.patient.encounter);

                                              if (result.runtimeType ==
                                                  Failure) {
                                                ScaffoldMessenger.of(
                                                        contextInner)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        (result as Failure)
                                                            .errorMessage),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(
                                                        contextInner)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text((result
                                                            as ResponseModel)
                                                        .message),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                                Provider.of<MedicalExamineProvider>(
                                                        contextInner,
                                                        listen: false)
                                                    .eitherFailureOrGetEnteredStreatSheets(
                                                        OET.OET_001.name,
                                                        args.patient.encounter
                                                            .toString());
                                              }
                                            },
                                          );
                                        },
                                        child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.verified_outlined),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text('Ban hành')
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
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1.5),
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
                                          '${codeToItemStreatmentSheet(streatmentSheet.value![index1].code)}:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
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
                                                  '- ${streatmentSheet.value![index1].value[index2]}');
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
                      Text('Ghi nhận thông tin',
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
            Consumer<PatientProvider>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (value.patientInfo == null) {
                  return const Center(
                    child: Text('Không có dữ liệu'),
                  );
                }
                if (value.failure != null) {
                  return Center(
                    child: Text(value.failure!.errorMessage),
                  );
                }
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Số HSBA: ${value.patientInfo!.encounter}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            value.patientInfo!.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "MSBN: ${value.patientInfo!.subject}",
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
                            "Ngày sinh: ${value.patientInfo!.birthdate}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                      // const SizedBox(height: 8),
                      // Text('Địa chỉ: ${value.patientInfo!.address}',
                      //     style: Theme.of(context).textTheme.bodyMedium),
                      if (args.patient.classifyName != '')
                        const SizedBox(height: 8),
                      if (args.patient.classifyName != '')
                        Text(
                          'Loại bệnh án: ${args.patient.classifyName}',
                        ),

                      const SizedBox(height: 8),
                      Text(
                        'BHYT: ${value.patientInfo!.healthInsuranceCard != null ? "Có sử dụng" : "Không sử dụng"}',
                      ),
                    ]);
              },
            )
          ]),
    );
  }

  Step _buildSubclinicSerDesignationStep(BuildContext context) {
    return Step(
        stepStyle: StepStyle(
          color: _index == 2 ? Colors.blue : Colors.grey.shade400,
        ),
        title: Text(
          'Chỉ định dịch vụ',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: _index == 2 ? Colors.blue : Colors.black,
              fontWeight: FontWeight.bold),
        ),
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<PatientProvider>(builder: (context, value, child) {
                if (value.isLoadingServices) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (value.listPatientServices.isEmpty) {
                  return const Center(
                    child: Text('Không có dữ liệu'),
                  );
                }
                if (value.failure != null) {
                  return Center(
                    child: Text(value.failure!.errorMessage),
                  );
                }

                List<PatientServiceEntity> listPatientServices =
                    value.listPatientServices;

                // Group services by Report code
                if (groupByReportCode == null) {
                  groupByReportCode = {};
                  listPatientServices.forEach((element) {
                    if (groupByReportCode!.containsKey(element.reportCode)) {
                      groupByReportCode![element.reportCode]!
                          .add(element); // Add to existing list
                    } else {
                      groupByReportCode![element.reportCode] = [
                        element
                      ]; // Create a new list
                    }
                  });

                  data = groupByReportCode!.keys
                      .map((e) => Item(
                          headerValue: codeToReport(e),
                          expandedValue: groupByReportCode![e]!,
                          isExpanded: false))
                      .toList();
                }
                if (data == null || data!.isEmpty) {
                  return const Center(
                    child: Text('Không có dữ liệu'),
                  );
                }
                return ExpansionPanelList(
                  expandedHeaderPadding: EdgeInsets.zero,
                  dividerColor: Colors.white,
                  elevation: 0,
                  materialGapSize: 0,
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      data![index].isExpanded = isExpanded;
                    });
                  },
                  children: data!.map<ExpansionPanel>((Item item) {
                    return ExpansionPanel(
                      backgroundColor: Colors.white,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                          title: Text(
                            item.headerValue,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      },
                      body: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Table(
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey,
                                  width: 1.5),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: const {
                                0: FixedColumnWidth(50),
                                1: FixedColumnWidth(200),
                                2: FixedColumnWidth(100),
                                3: FixedColumnWidth(100),
                                4: FixedColumnWidth(100),
                                5: FixedColumnWidth(200),
                                6: FixedColumnWidth(150),
                              },
                              children: [
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200),
                                        child: const Text('TT')),
                                  ),
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200),
                                      child: const Text(
                                        'Dịch vụ',
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200),
                                      child: const Text('Số lượng'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200),
                                      child: const Text('Đơn vị'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200),
                                      child: const Text('Giá'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200),
                                      child: const Text('Kết quả'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200),
                                      child: const Text('Hành động'),
                                    ),
                                  ),
                                ]),
                                // ...groupByReportCode[item.headerValue]!
                                //     .asMap()
                                //     .entries
                                //     .map((e) {
                                //   return

                                ...item.expandedValue.map((e) {
                                  return TableRow(children: [
                                    TableCell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        child:
                                            e.status == ServiceStatus.plan.name
                                                ? const Tooltip(
                                                    triggerMode:
                                                        TooltipTriggerMode.tap,
                                                    message: "Bản nháp",
                                                    child: Icon(
                                                        FontAwesomeIcons.file,
                                                        color: Colors.amber),
                                                  )
                                                : const Tooltip(
                                                    triggerMode:
                                                        TooltipTriggerMode.tap,
                                                    message: "Đã ban hành",
                                                    child: Icon(
                                                        Icons.verified_outlined,
                                                        color: Colors.green),
                                                  ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          e.service,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          e.quantity.toString(),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          e.unit,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          '${formatCurrency(e.price)}đ',
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          e.result ?? '',
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        child: e.status ==
                                                ServiceStatus.plan.name
                                            ? ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    backgroundColor:
                                                        Colors.green),
                                                onPressed: () {},
                                                child: const Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(Icons
                                                          .verified_outlined),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text('Ban hành')
                                                    ]),
                                              )
                                            : const SizedBox.shrink(),
                                      ),
                                    ),
                                  ]);
                                })
                              ])),
                      isExpanded: item.isExpanded,
                    );
                  }).toList(),
                );
              }),
              TextButton(
                onPressed: Provider.of<PatientProvider>(context, listen: true)
                            .patientInfo ==
                        null
                    ? null
                    : () {
                        PatientEntity patientInfo =
                            Provider.of<PatientProvider>(context, listen: false)
                                .patientInfo!;

                        Navigator.of(context).pushNamed(
                            RouteNames.requestClinicalService,
                            arguments: SubclinicSerDesignationArguments(
                                patientInfo: patientInfo,
                                division: args.division));
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add_rounded, color: Colors.blue),
                    Text('Chỉ định dịch vụ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.blue)),
                  ],
                ),
              ),
            ]));
  }
}

class ModifyMedicalSheetArguments<T> {
  final PatientInfoArguments patientInfo;
  final T medicalSheet;

  ModifyMedicalSheetArguments(
      {required this.patientInfo, required this.medicalSheet});
}

class SubclinicSerDesignationArguments {
  final PatientEntity patientInfo;
  final int division;

  SubclinicSerDesignationArguments(
      {required this.patientInfo, required this.division});
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = true,
  });

  List<PatientServiceEntity> expandedValue;
  String headerValue;
  bool isExpanded;
}

// List<Item> generateItems(int numberOfItems) {
//   return List<Item>.generate(numberOfItems, (int index) {
//     return Item(
//       headerValue: 'Panel $index',
//       expandedValue: 'This is item number $index',
//     );
//   });
// }
