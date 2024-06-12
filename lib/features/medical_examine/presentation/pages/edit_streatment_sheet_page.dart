import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/enums.dart';
import 'package:medical_examination_app/core/common/widgets.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/errors/failure.dart';
import 'package:medical_examination_app/core/services/stt_service.dart';
import 'package:medical_examination_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/streatment_sheet_entity.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/pages/medical_examination_page.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/providers/medical_examine_provider.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/widgets/dialog_record.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

class EditStreatmentSheetPage extends StatefulWidget {
  const EditStreatmentSheetPage({super.key});

  @override
  State<EditStreatmentSheetPage> createState() =>
      _EditStreatmentSheetPageState();
}

class _EditStreatmentSheetPageState extends State<EditStreatmentSheetPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _deseaseProgressController =
      TextEditingController();
  final TextEditingController _serviceIndicationController =
      TextEditingController();
  final TextEditingController _drugIndicationController =
      TextEditingController();
  late ModifyMedicalSheetArguments args;
  final SpeechToText _speechToText = STTService.speechToText;
  final bool _speechEnabled = STTService.speechEnabled;
  final LocaleName selectedLocale = STTService.getLocale('vi_VN');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments
          as ModifyMedicalSheetArguments;
      _deseaseProgressController.text = args.medicalSheet.value!
          .firstWhere((element) => element.code == VST.VST_0001.name)
          .value
          .first;
      _serviceIndicationController.text = args.medicalSheet.value!
          .firstWhere((element) => element.code == VST.VST_0002.name)
          .value
          .first;
      _drugIndicationController.text = args.medicalSheet.value!
          .firstWhere((element) => element.code == VST.VST_0003.name)
          .value
          .first;
    });
    super.initState();
  }

  void saveData(VoidCallback callback) async {
    if (_formKey.currentState!.validate()) {
      final result =
          await Provider.of<MedicalExamineProvider>(context, listen: false)
              .eitherFailureOrEditStreatmentSheet(
                  StreatmentSheetEntity(
                      id: args.medicalSheet.id,
                      type: OET.OET_001.name,
                      encounter: args.patientInfo.patient.encounter,
                      subject: args.patientInfo.patient.subject,
                      doctor: Provider.of<AuthProvider>(context, listen: false)
                          .userEntity!
                          .id,
                      value: [
                        StreatmentSheetItemEntity(
                            code: VST.VST_0001.name,
                            value: [_deseaseProgressController.text]),
                        StreatmentSheetItemEntity(
                            code: VST.VST_0002.name,
                            value: [_serviceIndicationController.text]),
                        StreatmentSheetItemEntity(
                            code: VST.VST_0003.name,
                            value: [_drugIndicationController.text]),
                      ]),
                  args.patientInfo.division);

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
        callback();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Chỉnh sửa tờ điều trị',
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
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTextField(label: 'Diễn biến bệnh'),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _deseaseProgressController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        // hintText: 'Nhập diễn biến bệnh',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _speechEnabled
                                ? Icons.mic_rounded
                                : Icons.mic_off_rounded,
                            color: Colors.blue,
                            size: 30,
                          ),
                          onPressed: () {
                            dialogRecordBuilder(
                                    context, _speechToText, selectedLocale)
                                .then((value) {
                              if (value != null) {
                                _deseaseProgressController.text +=
                                    value.toString();
                              }
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng điền vào chỗ trống';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    const LabelTextField(label: 'Chỉ định dịch vụ'),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _serviceIndicationController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        // hintText: 'Nhập diễn biến bệnh',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _speechEnabled
                                ? Icons.mic_rounded
                                : Icons.mic_off_rounded,
                            color: Colors.blue,
                            size: 30,
                          ),
                          onPressed: () {
                            dialogRecordBuilder(
                                    context, _speechToText, selectedLocale)
                                .then((value) {
                              if (value != null) {
                                _serviceIndicationController.text +=
                                    value.toString();
                              }
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng điền vào chỗ trống';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    const LabelTextField(label: 'Chỉ định thuốc'),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _drugIndicationController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        // hintText: 'Nhập diễn biến bệnh',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _speechEnabled
                                ? Icons.mic_rounded
                                : Icons.mic_off_rounded,
                            color: Colors.blue,
                            size: 30,
                          ),
                          onPressed: () {
                            dialogRecordBuilder(
                                    context, _speechToText, selectedLocale)
                                .then((value) {
                              if (value != null) {
                                _drugIndicationController.text +=
                                    value.toString();
                              }
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng điền vào chỗ trống';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side:
                            BorderSide(color: Colors.grey.shade300, width: 1.5),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Hủy bỏ'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: Provider.of<MedicalExamineProvider>(context,
                                  listen: true)
                              .isLoading
                          ? null
                          : () async {
                              saveData(() {
                                Provider.of<MedicalExamineProvider>(context,
                                        listen: false)
                                    .eitherFailureOrGetEnteredStreatSheets(
                                        OET.OET_001.name,
                                        args.patientInfo.patient.encounter
                                            .toString());
                                Navigator.of(context).pop();
                              });
                            },
                      child: const Text('Lưu thay đổi'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
