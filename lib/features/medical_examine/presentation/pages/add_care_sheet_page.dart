import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/enums.dart';
import 'package:medical_examination_app/core/common/widgets.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/errors/failure.dart';
import 'package:medical_examination_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/care_sheet_entity.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/providers/medical_examine_provider.dart';
import 'package:medical_examination_app/features/patient/presentation/pages/search_patient_page.dart';
import 'package:provider/provider.dart';

class AddCareSheetPage extends StatefulWidget {
  const AddCareSheetPage({super.key});

  @override
  State<AddCareSheetPage> createState() => _AddCareSheetPageState();
}

class _AddCareSheetPageState extends State<AddCareSheetPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _deseaseProgressController =
      TextEditingController();
  final TextEditingController _careOrderController = TextEditingController();

  late PatientInfoArguments args;

  @override
  void initState() {
    // Provider.of<CategoryProvider>(context, listen: false)
    //     .eitherFailureOrGetSubclicServices('subclinic');
    super.initState();
  }

  void saveData(VoidCallback callback) async {
    if (_formKey.currentState!.validate()) {
      final result =
          await Provider.of<MedicalExamineProvider>(context, listen: false)
              .eitherFailureOrCreCareSheet(
                  CareSheetEntity(
                      type: OET.OET_002.name,
                      encounter: args.patient.encounter,
                      subject: args.patient.subject,
                      doctor: Provider.of<AuthProvider>(context, listen: false)
                          .userEntity!
                          .id,
                      value: [
                        CareSheetItemEntity(
                            code: VST.VST_0005.name,
                            value: [_deseaseProgressController.text]),
                        CareSheetItemEntity(
                            code: VST.VST_0006.name,
                            value: [_careOrderController.text]),
                      ]),
                  args.division);

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
    args = ModalRoute.of(context)!.settings.arguments as PatientInfoArguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Tờ chăm sóc',
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
                    const LabelTextField(label: 'Theo dõi diễn biến'),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _deseaseProgressController,
                      maxLines: 5,
                      decoration: InputDecoration(
                          // hintText: 'Nhập diễn biến bệnh',
                          suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.mic,
                          color: Colors.blue,
                          size: 30,
                        ),
                        onPressed: () {
                          // Add your microphone button functionality here
                        },
                      )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng điền vào chỗ trống';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    const LabelTextField(label: 'Y lệnh chăm sóc'),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _careOrderController,
                      maxLines: 5,
                      decoration: InputDecoration(
                          // hintText: 'Nhập diễn biến bệnh',
                          suffixIcon: IconButton(
                        alignment: Alignment.bottomRight,
                        icon: const Icon(
                          Icons.mic,
                          color: Colors.blue,
                          size: 30,
                        ),
                        onPressed: () {
                          // Add your microphone button functionality here
                        },
                      )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng điền vào chỗ trống';
                        }
                        return null;
                      },
                    ),
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
                      onPressed: Provider.of<MedicalExamineProvider>(context,
                                  listen: true)
                              .isLoading
                          ? null
                          : () async {
                              saveData(() {
                                _deseaseProgressController.clear();
                                _careOrderController.clear();
                              });
                            },
                      child: const Text('Tiếp tục nhập'),
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
                                Navigator.of(context).pop();
                              });
                            },
                      child: const Text('Hoàn tất'),
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
