import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/helpers.dart';
import 'package:medical_examination_app/core/common/widgets.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/errors/failure.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';
import 'package:medical_examination_app/core/services/stt_service.dart';
import 'package:medical_examination_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:medical_examination_app/features/category/business/entities/icd_entity.dart';
import 'package:medical_examination_app/features/category/business/entities/subclinic_service_entity.dart';
import 'package:medical_examination_app/features/category/business/entities/sublin_serv_group_entity.dart';
import 'package:medical_examination_app/features/category/presentation/providers/category_provider.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/pages/medical_examination_page.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/providers/medical_examine_provider.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/widgets/dialog_record.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/widgets/option_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:tiengviet/tiengviet.dart';

class ClinicalServiceRequestPage extends StatefulWidget {
  const ClinicalServiceRequestPage({super.key});

  @override
  State<ClinicalServiceRequestPage> createState() =>
      _ClinicalServiceRequestPageState();
}

class _ClinicalServiceRequestPageState
    extends State<ClinicalServiceRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  late SubclinicSerDesignationArguments args;
  final SpeechToText _speechToText = STTService.speechToText;
  final bool _speechEnabled = STTService.speechEnabled;
  final LocaleName selectedLocale = STTService.getLocale('vi_VN');
  bool isCreated = false;
  Timer? _timer;

  List<SubclinicServiceEntity> selectedSubclinicServices = [];
  List<ICDEntity> selectedICDs = [];

  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false)
        .eitherFailureOrGetSubclicServiceGroups('subclinic_group');
    Provider.of<CategoryProvider>(context, listen: false)
        .eitherFailureOrGetSubclicServices('subclinic');
    Provider.of<CategoryProvider>(context, listen: false)
        .eitherFailureOrGetICD('icd');
    super.initState();
  }

  void saveData(bool isPublish, VoidCallback callback) async {
    if (_formKey.currentState!.validate()) {
      List<ServiceParams> services = selectedSubclinicServices
          .map((e) => ServiceParams(
              code: e.id.toString(),
              quantity: e.quantity!,
              type: 'fee',
              isCard:
                  args.patientInfo.healthInsuranceCard != null ? 'on' : 'off',
              emergency: false,
              option: [],
              start: ''))
          .toList();
      String text = selectedICDs.map((e) => e.display).join('/');
      List<String> value = selectedICDs.map((e) => e.code).toList();
      List<NewIcds> newIcds =
          selectedICDs.map((e) => NewIcds(code: e.code, type: 'SU')).toList();
      ReasonParams reason = ReasonParams(
          reason: Reason(text: text, value: value), newIcds: newIcds);

      int rate = args.patientInfo.healthInsuranceCard != null
          ? args.patientInfo.healthInsuranceCard!.rate
          : 0;

      final result = await Provider.of<MedicalExamineProvider>(context,
              listen: false)
          .eitherFailureOrDesignSubcliService(
              'new',
              Provider.of<AuthProvider>(context, listen: false).userEntity!.id,
              services,
              args.patientInfo.encounter,
              args.patientInfo.subject,
              reason,
              args.division,
              _textEditingController.text,
              rate,
              isPublish);

      if (result.runtimeType == Failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text((result as Failure).errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        isCreated = true;
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
    args = ModalRoute.of(context)!.settings.arguments
        as SubclinicSerDesignationArguments;
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
        bottomNavigationBar: _buildBottomNavbar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDescriptionInput(context),
                const SizedBox(height: 8),
                _buildSubclinicService(context),
                const SizedBox(height: 8),
                _buildICD(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildICD(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelTextField(label: 'ICD Bệnh nhân'),
        const SizedBox(height: 5),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                title: Text(
                  '${index + 1}. ${selectedICDs[index].code} - ${selectedICDs[index].display}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: IconButton(
                    onPressed: () {
                      selectedICDs.removeAt(index);
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.red,
                    )),
              );
            },
            itemCount: selectedICDs.length),
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
    );
  }

  Column _buildSubclinicService(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelTextField(label: 'Các dịch vụ'),
        const SizedBox(height: 5),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                                '${index + 1}. ${selectedSubclinicServices[index].display}')),
                        const SizedBox(width: 8),
                        IconButton(
                            onPressed: () {
                              selectedSubclinicServices.removeAt(index);
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.close_rounded,
                              color: Colors.red,
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OptionCheckbox(
                            title: 'Dịch vụ',
                            value: selectedSubclinicServices[index].dv!,
                            onPressed: (value) {
                              setState(() {
                                selectedSubclinicServices[index].dv = value!;
                              });
                            }),
                        OptionCheckbox(
                            title: 'Tự túc',
                            value: selectedSubclinicServices[index].tt!,
                            onPressed: (value) {
                              setState(() {
                                selectedSubclinicServices[index].tt = value!;
                              });
                            }),
                        OptionCheckbox(
                            title: 'Cấp cứu',
                            value: selectedSubclinicServices[index].cc!,
                            onPressed: (value) {
                              setState(() {
                                selectedSubclinicServices[index].cc = value!;
                              });
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price
                        RichText(
                          text: TextSpan(
                            text: 'Giá: ',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      '${formatCurrency(selectedSubclinicServices[index].price!)}đ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold)),
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
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: selectedSubclinicServices[
                                                  index]
                                              .editQuantity!
                                          ? () {
                                              if (selectedSubclinicServices[
                                                          index]
                                                      .quantity! >
                                                  1) {
                                                selectedSubclinicServices[index]
                                                        .quantity =
                                                    selectedSubclinicServices[
                                                                index]
                                                            .quantity! -
                                                        1;
                                                setState(() {});
                                              }
                                            }
                                          : null,
                                      icon: Icon(
                                        Icons.remove_rounded,
                                        color: selectedSubclinicServices[index]
                                                .editQuantity!
                                            ? Colors.blue
                                            : Colors.grey,
                                      )),
                                  Text(
                                      '${selectedSubclinicServices[index].quantity}'),
                                  IconButton(
                                      onPressed: selectedSubclinicServices[
                                                  index]
                                              .editQuantity!
                                          ? () {
                                              selectedSubclinicServices[index]
                                                      .quantity =
                                                  selectedSubclinicServices[
                                                              index]
                                                          .quantity! +
                                                      1;
                                              setState(() {});
                                            }
                                          : null,
                                      icon: Icon(
                                        Icons.add_rounded,
                                        color: selectedSubclinicServices[index]
                                                .editQuantity!
                                            ? Colors.blue
                                            : Colors.grey,
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
                                  .copyWith(fontStyle: FontStyle.italic),
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
            itemCount: selectedSubclinicServices.length),
        TextButton(
          onPressed: () {
            _showAddSerivceModal(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.add_rounded, color: Colors.blue),
              Text('Thêm dịch vụ',
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

  Form _buildDescriptionInput(BuildContext context) {
    return Form(
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
                _speechEnabled ? Icons.mic_rounded : Icons.mic_off_rounded,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: () {
                dialogRecordBuilder(context, _speechToText, selectedLocale)
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
        ],
      ),
    );
  }

  Container _buildBottomNavbar(BuildContext context) {
    int total = selectedSubclinicServices.fold(
        0,
        (previousValue, element) =>
            previousValue + element.price! * element.quantity!);
    return Container(
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
                  '${formatCurrency(total)}đ',
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
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                    onPressed: Provider.of<MedicalExamineProvider>(context,
                                listen: true)
                            .isLoading
                        ? null
                        : () async {
                            saveData(false, () {
                              Navigator.of(context).pop();
                            });
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
                            saveData(true, () {
                              Navigator.of(context).pop();
                            });
                          },
                    child: const Text('Ban hành'),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Future<dynamic> showAddDiagnosticModal(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    final AlphabetListViewOptions options = AlphabetListViewOptions(
      listOptions: ListOptions(
        listHeaderBuilder: (context, symbol) => Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(4),
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
          // forcePosition: AlphabetScrollbarPosition.left,
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
          return StatefulBuilder(builder: (context, setState) {
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
                    controller: searchController,
                    onChanged: (value) {
                      // Debounce search
                      _timer?.cancel();
                      _timer = Timer(const Duration(milliseconds: 500), () {
                        setState(() => {});
                      });
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      hintText: 'Nhập tên hoặc mã ICD',
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Consumer<CategoryProvider>(builder: (context, value, child) {
                    if (value.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (value.listICD.isEmpty) {
                      return const Center(
                        child: Text('Chưa có dữ liệu'),
                      );
                    }
                    if (value.failure != null) {
                      return Center(
                        child: Text(value.failure!.errorMessage),
                      );
                    }

                    List<ICDEntity> listICD = value.listICD;

                    Map<String, List<ICDEntity>> mapICD = {};

                    listICD.forEach((entity) {
                      String startLetter = entity.code[0];

                      if (!selectedICDs.contains(entity) &&
                          (TiengViet.parse(entity.display)
                                  .toLowerCase()
                                  .contains(
                                      TiengViet.parse(searchController.text)
                                          .toLowerCase()) ||
                              entity.code.contains(searchController.text))) {
                        mapICD.putIfAbsent(startLetter, () => []).add(entity);
                      }
                    });

                    List<AlphabetListViewItemGroup> groups =
                        mapICD.entries.map((entry) {
                      return AlphabetListViewItemGroup(
                        tag: entry.key,
                        children: entry.value
                            .map(
                              (e) => Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Text('${e.code} - ${e.display}')),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                    ),
                                    onPressed: () {
                                      selectedICDs.add(e);
                                      setState(() {});
                                    },
                                    child: const Text('Thêm'),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      );
                    }).toList();

                    print('object');

                    return Expanded(
                      child: AlphabetListView(
                        items: groups,
                        options: options,
                      ),
                    );
                  })
                ],
              ),
            );
          });
        });
  }

  Future<dynamic> _showAddSerivceModal(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    String? selectedSubclinicGroup;
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
                  Consumer<CategoryProvider>(builder: (context, value, child) {
                    List<SublicServGroupEntity> listSubclinicServiceGroups =
                        value.listSubclinicServiceGroups;

                    return DropdownMenu<String>(
                      width: MediaQuery.of(context).size.width - 32,
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      hintText: "Nhóm dịch vụ",
                      // initialSelection: listSubclinicServiceGroups.first.code,
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          selectedSubclinicGroup = value!;
                        });
                      },
                      leadingIcon: const Icon(Icons.category_outlined),
                      menuHeight: MediaQuery.of(context).size.height * 0.5,
                      dropdownMenuEntries: listSubclinicServiceGroups
                          .map<DropdownMenuEntry<String>>(
                              (SublicServGroupEntity value) {
                        return DropdownMenuEntry<String>(
                            value: value.code, label: value.display);
                      }).toList(),
                    );
                  }),
                  const SizedBox(height: 8),
                  TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() => {});
                    },
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
                          setState(() {
                            searchController.clear();
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Consumer<CategoryProvider>(builder: (context, value, child) {
                    if (value.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (value.listSubclinicServices.isEmpty) {
                      return const Center(
                        child: Text('Chưa có dữ liệu'),
                      );
                    }
                    if (value.failure != null) {
                      return Center(
                        child: Text(value.failure!.errorMessage),
                      );
                    }

                    // Method to normalize text for comparison
                    String normalizeText(String text) {
                      return TiengViet.parse(text.toLowerCase());
                    }

                    // Method to check if a SubclinicServiceEntity matches the search criteria
                    bool matchesCriteria(
                        SubclinicServiceEntity e,
                        String? selectedSubclinicGroup,
                        TextEditingController searchController) {
                      String searchText = normalizeText(searchController.text);
                      if (selectedSubclinicGroup == null) {
                        return normalizeText(e.display!).contains(searchText);
                      } else {
                        return e.groupId.toString() == selectedSubclinicGroup &&
                            normalizeText(e.display!).contains(searchText);
                      }
                    }

                    // Usage in the list filtering
                    List<SubclinicServiceEntity> listSubclinicServices =
                        value.listSubclinicServices;

                    listSubclinicServices = listSubclinicServices
                        .where((e) => !selectedSubclinicServices.contains(e))
                        .toList();

                    listSubclinicServices = listSubclinicServices
                        .where((e) => matchesCriteria(
                            e, selectedSubclinicGroup, searchController))
                        .toList();

                    return Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // return Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Flexible(
                            //       child: Text(
                            //           '${index + 1}. ${listSubclinicServices[index].display}'),
                            //     ),
                            //     ElevatedButton(
                            //         style: ElevatedButton.styleFrom(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 16, vertical: 8),
                            //         ),
                            //         onPressed: () {
                            //           selectedSubclinicServices
                            //               .add(listSubclinicServices[index]);
                            //           setState(() {});
                            //         },
                            //         child: const Text('Thêm'))
                            //   ],
                            // );
                            return ListTile(
                              title: Text(
                                  '${index + 1}. ${listSubclinicServices[index].display}'),
                              subtitle: Text(
                                '${formatCurrency(listSubclinicServices[index].price!)}đ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.blue),
                              ),
                              trailing: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                  ),
                                  onPressed: () {
                                    selectedSubclinicServices
                                        .add(listSubclinicServices[index]);
                                    setState(() {});
                                  },
                                  child: const Text('Thêm')),
                            );
                          },
                          itemCount: listSubclinicServices.length),
                    );
                  })
                ],
              ),
            );
          },
        );
      },
    );
  }
}
