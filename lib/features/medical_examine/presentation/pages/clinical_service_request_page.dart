import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/widgets.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/core/services/stt_service.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/providers/medical_examine_provider.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/widgets/dialog_record.dart';
import 'package:medical_examination_app/features/patient/presentation/pages/search_patient_page.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:alphabet_list_view/alphabet_list_view.dart';

class ClinicalServiceRequestPage extends StatefulWidget {
  const ClinicalServiceRequestPage({super.key});

  @override
  State<ClinicalServiceRequestPage> createState() =>
      _ClinicalServiceRequestPageState();
}

const List<String> list = <String>[
  '01. CHĂM SÓC',
  '02. CT SCANNER',
  '03. ĐIỆN NÃO',
  '04. ĐIỆN TIM'
];

class _ClinicalServiceRequestPageState
    extends State<ClinicalServiceRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  late PatientInfoArguments args;
  final SpeechToText _speechToText = STTService.speechToText;
  final bool _speechEnabled = STTService.speechEnabled;
  final LocaleName selectedLocale = STTService.getLocale('vi_VN');
  bool isCreated = false;

  @override
  void initState() {
    // Provider.of<CategoryProvider>(context, listen: false)
    //     .eitherFailureOrGetSubclicServices('subclinic');
    super.initState();
  }

  // void saveData(VoidCallback callback) async {
  //   if (_formKey.currentState!.validate()) {
  //     final result =
  //         await Provider.of<MedicalExamineProvider>(context, listen: false)
  //             .eitherFailureOrCreCareSheet(
  //                 CareSheetEntity(
  //                     type: OET.OET_002.name,
  //                     encounter: args.patient.encounter,
  //                     subject: args.patient.subject,
  //                     doctor: Provider.of<AuthProvider>(context, listen: false)
  //                         .userEntity!
  //                         .id,
  //                     value: [
  //                       CareSheetItemEntity(
  //                           code: VST.VST_0005.name,
  //                           value: [_deseaseProgressController.text]),
  //                       CareSheetItemEntity(
  //                           code: VST.VST_0006.name,
  //                           value: [_careOrderController.text]),
  //                     ]),
  //                 args.division);

  //     if (result.runtimeType == Failure) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text((result as Failure).errorMessage),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     } else {
  //       isCreated = true;
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text((result as ResponseModel).message),
  //           backgroundColor: Colors.green,
  //         ),
  //       );
  //       callback();
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as PatientInfoArguments;
    return PopScope(
      onPopInvoked: (didPop) {
        if (isCreated) {
          // Provider.of<MedicalExamineProvider>(context, listen: false)
          //     .eitherFailureOrGetEnteredCareSheets(
          //         OET.OET_002.name, args.patient.encounter.toString());
        }
        if (didPop) {
          return;
        }
        if (context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Chỉ định dịch vụ',
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Tổng cộng: '),
                    Text(
                      '100.000đ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          side: BorderSide(
                              color: Colors.grey.shade300, width: 1.5),
                        ),
                        onPressed: Provider.of<MedicalExamineProvider>(context,
                                    listen: true)
                                .isLoading
                            ? null
                            : () async {
                                // saveData(() {
                                //   _deseaseProgressController.clear();
                                //   _careOrderController.clear();
                                // });
                              },
                        child: const Text('Lưu'),
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
                                // saveData(() {
                                //   Provider.of<MedicalExamineProvider>(context,
                                //           listen: false)
                                //       .eitherFailureOrGetEnteredCareSheets(
                                //           OET.OET_002.name,
                                //           args.patient.encounter.toString());
                                //   Navigator.of(context).pop();
                                // });
                              },
                        child: const Text('Ban hành'),
                      ),
                    ),
                  ],
                ),
              ],
            )),
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
                      const LabelTextField(label: 'Ghi chú/ Mô tả lâm sàng'),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _textEditingController,
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
                                _textEditingController.text += value.toString();
                              }
                            });
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
                      const LabelTextField(label: 'Các dịch vụ'),
                      const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  '${index + 1}. Điện tim thường')),
                                          const SizedBox(width: 8),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.close_rounded,
                                                color: Colors.red,
                                              ))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Transform.scale(
                                                scale: 1.4,
                                                child: Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3)),
                                                  side: BorderSide(
                                                      color:
                                                          Colors.grey.shade600,
                                                      width: 1.5),
                                                  checkColor: Colors.white,
                                                  value: false,
                                                  onChanged: (value) {},
                                                ),
                                              ),
                                              const Text('Dịch vụ')
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Transform.scale(
                                                scale: 1.4,
                                                child: Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3)),
                                                  side: BorderSide(
                                                      color:
                                                          Colors.grey.shade600,
                                                      width: 1.5),
                                                  checkColor: Colors.white,
                                                  value: false,
                                                  onChanged: (value) {},
                                                ),
                                              ),
                                              const Text('Tự túc')
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Transform.scale(
                                                scale: 1.4,
                                                child: Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3)),
                                                  side: BorderSide(
                                                      color:
                                                          Colors.grey.shade600,
                                                      width: 1.5),
                                                  checkColor: Colors.white,
                                                  value: true,
                                                  onChanged: (value) {},
                                                ),
                                              ),
                                              const Text('Cấp cứu')
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Price
                                          RichText(
                                            text: TextSpan(
                                              text: 'Giá: ',
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '100.000đ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                              ],
                                            ),
                                          ),
                                          // Edit Quantity
                                          const SizedBox(width: 8),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                // padding: const EdgeInsets.symmetric(
                                                //     horizontal: 8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade300),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(
                                                          Icons.remove_rounded,
                                                          color: Colors.blue,
                                                        )),
                                                    const Text('1'),
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(
                                                          Icons.add_rounded,
                                                          color: Colors.blue,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'lần',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontStyle:
                                                            FontStyle.italic),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 8);
                              },
                              itemCount: 5),
                          TextButton(
                            onPressed: () {
                              _showAddSerivceModal(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.add_rounded,
                                    color: Colors.blue),
                                Text('Thêm dịch vụ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.blue)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const LabelTextField(label: 'ICD Bệnh nhân'),
                      const SizedBox(height: 5),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Text(
                                        '${index + 1}. A00.0 - Bệnh tả do Vibrio cholerae 01, typ sinh học cholerae')),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      color: Colors.red,
                                    ))
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8);
                          },
                          itemCount: 3),
                      TextButton(
                        onPressed: () {
                          showAddDiagnosticModal(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.add_rounded, color: Colors.blue),
                            Text('Thêm chuẩn đoán',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.blue)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showAddDiagnosticModal(BuildContext context) {
    final List<AlphabetListViewItemGroup> tech = [
      AlphabetListViewItemGroup(
        tag: 'B',
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text(
                      'Bệnh tả do Vibrio cholerae 01, typ sinh học cholerae')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                onPressed: () {},
                child: const Text('Thêm'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text(
                      'Bệnh tả do Vibrio cholerae 01, typ sinh học eltor')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                onPressed: () {},
                child: const Text('Thêm'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text('Bệnh tả, không đặc hiệu')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                onPressed: () {},
                child: const Text('Thêm'),
              ),
            ],
          ),
        ],
      ),
    ];

    final AlphabetListViewOptions options = AlphabetListViewOptions(
      listOptions: ListOptions(
        listHeaderBuilder: (context, symbol) => Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            symbol,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      scrollbarOptions: ScrollbarOptions(
          decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      )),
      overlayOptions: const OverlayOptions(
        showOverlay: false,
      ),
    );

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        // isDismissible: false,
        enableDrag: false,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Thêm chuẩn đoán',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    hintText: 'Nhập tên chuẩn đoán',
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {},
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: AlphabetListView(
                    items: tech,
                    options: options,
                  ),
                )
              ],
            ),
          );
        });
  }

  Future<dynamic> _showAddSerivceModal(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    String dropdownValue = list.first;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('Thêm dịch vụ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  DropdownMenu<String>(
                    width: MediaQuery.of(context).size.width - 32,
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    initialSelection: list.first,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    leadingIcon: const Icon(Icons.category_outlined),
                    dropdownMenuEntries:
                        list.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: searchController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      hintText: 'Nhập tên dịch vụ',
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                    '${index + 1}. Bảng nghiệm kê nhân cách hướng nội hướng ngoại (EPI)'),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                  ),
                                  onPressed: () {},
                                  child: const Text('Thêm'))
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 8);
                        },
                        itemCount: 10),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
