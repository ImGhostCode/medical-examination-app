import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/enums.dart';
import 'package:medical_examination_app/core/common/widgets.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/errors/failure.dart';
import 'package:medical_examination_app/features/category/business/entities/department_entity.dart';
import 'package:medical_examination_app/features/category/presentation/providers/category_provider.dart';
import 'package:medical_examination_app/features/nutrition/business/entities/nutrition_entity.dart';
import 'package:medical_examination_app/features/nutrition/business/entities/nutrition_order_entity.dart';
import 'package:medical_examination_app/features/nutrition/presentation/providers/nutrition_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tiengviet/tiengviet.dart';

class NutritionAssignationHistoryPage extends StatefulWidget {
  const NutritionAssignationHistoryPage({super.key});

  @override
  State<NutritionAssignationHistoryPage> createState() =>
      _NutritionAssignationHistoryPageState();
}

class _NutritionAssignationHistoryPageState
    extends State<NutritionAssignationHistoryPage> {
  final TextEditingController _dateController = TextEditingController();
  DateTime date = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DepartmentEntity? _selectedDepartment;
  final List<NutritionOrderEntity> selectedNutritionOrders = [];
  final TextEditingController _locationController = TextEditingController();

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedDate = args.value;
    });
  }

  Future<void> onCancelNutritionOrder(
      BuildContext context, String action) async {
    final result = await Provider.of<NutritionProvider>(context, listen: false)
        .eitherFailureOrModifyNutritionOrder(action, selectedNutritionOrders);

    if (result.runtimeType == Failure || result.runtimeType == ServerFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('${(result as Failure).errorMessage} (${(result).hints})'),
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

      // Remove selected nutrition orders from provider
      Provider.of<NutritionProvider>(context, listen: false)
          .orderedNutritions
          .removeWhere((element) => selectedNutritionOrders.contains(element));

      selectedNutritionOrders.clear();
      setState(() {});
      // loadOrderedNutritions(context, _selectedDepartment!.value.toString(),
      //     date.toString().substring(0, 10), "nutrition_order_detail");
    }
  }

  @override
  void initState() {
    _selectedDepartment = Provider.of<CategoryProvider>(context, listen: false)
        .selectedDepartment!;
    loadOrderedNutritions(context, _selectedDepartment!.value.toString(),
        date.toString().substring(0, 10), "nutrition_order_detail");
    Provider.of<NutritionProvider>(context, listen: false)
        .eitherFailureOrGetNutritions();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _dateController.text = '${date.day}/${date.month}/${date.year}';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Danh sách đã chỉ định',
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      // bottomSheet: Container(
      //   decoration: const BoxDecoration(
      //       color: Colors.white, borderRadius: BorderRadius.zero),
      //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      //   width: MediaQuery.of(context).size.width,
      //   child: ElevatedButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     child: const Text('Hoàn tất'),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<CategoryProvider>(builder: (context, value, child) {
                if (value.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (value.failure != null) {
                  return Center(
                    child: Text(value.failure!.errorMessage),
                  );
                }
                if (value.listDepartment.isEmpty) {
                  return const Center(
                    child: Text('Không có dữ liệu'),
                  );
                }
                // if (value.selectedDepartment != null) {
                //   _selectedDepartment = value.selectedDepartment;
                // } else {
                _selectedDepartment ??= value.listDepartment.first;
                // }
                _locationController.text = _selectedDepartment?.display ?? '';

                return TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: _locationController,
                  decoration: InputDecoration(
                    hintText: 'Chọn phòng khám',
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      size: 30,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                      onPressed: () {
                        showLocationModal(
                          context,
                          value.listDepartment,
                          _selectedDepartment,
                          (department) {
                            setState(() {
                              _selectedDepartment = department;
                              _locationController.text =
                                  _selectedDepartment!.display;
                            });
                            loadOrderedNutritions(
                                context,
                                _selectedDepartment!.value.toString(),
                                date.toString().substring(0, 10),
                                "nutrition_order_detail");
                          },
                        );
                      },
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    showLocationModal(
                      context,
                      value.listDepartment,
                      _selectedDepartment,
                      (department) {
                        setState(() {
                          // value.selectedDepartment = department;d
                          _selectedDepartment = department;
                          _locationController.text =
                              _selectedDepartment!.display;
                        });
                        loadOrderedNutritions(
                            context,
                            _selectedDepartment!.value.toString(),
                            date.toString().substring(0, 10),
                            "nutrition_order_detail");
                      },
                    );
                  },
                );
              }),
              const SizedBox(height: 8),
              TextField(
                controller: _dateController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(
                  hintText: 'Chọn ngày chỉ định',
                  suffixIcon: Icon(
                    Icons.calendar_today_outlined,
                  ),
                ),
                onTap: () {
                  _dialogPickerBuilder(context);
                },
                readOnly: true,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text('Các dinh dưỡng đã chỉ định',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),

                  // Cancel button
                  selectedNutritionOrders.isNotEmpty
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(8),
                              backgroundColor: Colors.red),
                          onPressed: Provider.of<NutritionProvider>(context,
                                      listen: true)
                                  .isLoading
                              ? null
                              : () async {
                                  showConfirmDialog(context,
                                      'Bạn có chắc chắn muốn huỷ chỉ định này không?',
                                      (innerContext, text) async {
                                    onCancelNutritionOrder(
                                        context, ServiceStatus.cancel);
                                  }, false, '');
                                },
                          child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.cancel_outlined,
                                    color: Colors.white),
                                SizedBox(
                                  width: 4,
                                ),
                                Text('Hủy chỉ định')
                              ]),
                        )
                      : const SizedBox.shrink()
                ],
              ),
              // const SizedBox(height: 10),
              const SizedBox(height: 10),
              Consumer<NutritionProvider>(builder: (context, value, child) {
                if (value.isLoading) {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    child: const CircularProgressIndicator(),
                  );
                }
                if (value.failure != null) {
                  return Center(
                    child: Text(value.failure!.errorMessage),
                  );
                }
                if (value.orderedNutritions.isEmpty) {
                  return const Center(
                    child: Text('Không có dữ liệu'),
                  );
                }

                return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                        border: TableBorder.all(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blueGrey.shade100,
                            width: 1.5),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const {
                          0: FixedColumnWidth(50), // checkbox
                          1: FixedColumnWidth(200), // Dịch vụ
                          2: FixedColumnWidth(100), // Số HSBA
                          3: FixedColumnWidth(100), // Mã BN
                          4: FixedColumnWidth(200), // Tên BN
                          5: FixedColumnWidth(100), // Ngày sinh
                          6: FixedColumnWidth(100), // Giới tính
                          7: FixedColumnWidth(100), // Giường
                        },
                        children: [
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200),
                                  child: const Text('')),
                            ),
                            TableCell(
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200),
                                  child: const Text('Dịch vụ')),
                            ),
                            TableCell(
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200),
                                  child: const Text('Số HSBA')),
                            ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade200),
                                child: const Text(
                                  'Mã BN',
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade200),
                                child: const Text('Tên BN'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade200),
                                child: const Text('Năm sinh'),
                              ),
                            ),

                            TableCell(
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade200),
                                child: const Text('Giới tính'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade200),
                                child: const Text('Giường'),
                              ),
                            ),
                            // TableCell(
                            //   child: Container(
                            //     alignment: Alignment.center,
                            //     padding: const EdgeInsets.all(8),
                            //     decoration:
                            //         BoxDecoration(color: Colors.grey.shade200),
                            //     child: const Text('Vị trí'),
                            //   ),
                            // ),
                          ]),
                          // ...groupByReportCode[item.headerValue]!
                          //     .asMap()
                          //     .entries
                          //     .map((e) {
                          //   return

                          // ...item.expandedValue.map((e) {
                          //   return
                          ...value.orderedNutritions.map((e) {
                            return TableRow(children: [
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  child: Transform.scale(
                                    scale: 1.4,
                                    child: Checkbox(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      side: BorderSide(
                                          color: Colors.grey.shade600,
                                          width: 1.5),
                                      checkColor: Colors.white,
                                      fillColor: e.isSelected
                                          ? const WidgetStatePropertyAll(
                                              Colors.blue)
                                          : null,
                                      value: e.isSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          e.isSelected = value!;
                                          if (value) {
                                            selectedNutritionOrders.add(e);
                                          } else {
                                            selectedNutritionOrders.remove(e);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    e.nutrition!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    e.encounter.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    e.subject.toString(),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    e.name!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    e.birthdate!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    e.genderName!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    e.location!.isNotEmpty
                                        ? e.location!.first.display!
                                        : '',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ]);
                          })
                          // }
                          // )
                        ]));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _dialogPickerBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.white,
          title: Text(
            'Chọn thời gian',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width - 100,
            child: SfDateRangePicker(
              headerStyle: const DateRangePickerHeaderStyle(
                  backgroundColor: Colors.white),
              backgroundColor: Colors.white,
              todayHighlightColor: Colors.blue,
              selectionColor: Colors.blue,
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.single,
              monthViewSettings: const DateRangePickerMonthViewSettings(
                  firstDayOfWeek: 1), // Monday as start of week
              initialSelectedDate: date,
              onSelectionChanged: _onSelectionChanged,
              allowViewNavigation: true,
              // initialSelectedDates: [DateTime.now()],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade400,
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Trở về'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Đồng ý'),
              onPressed: () {
                setState(() {
                  date = selectedDate;
                });
                loadOrderedNutritions(
                    context,
                    _selectedDepartment!.value.toString(),
                    date.toString().substring(0, 10),
                    "nutrition_order_detail");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void loadOrderedNutritions(BuildContext context, String selectedDepartment,
    String date, String status) {
  Provider.of<NutritionProvider>(context, listen: false)
      .eitherFailureOrOrderedNutritions(selectedDepartment, date, status);
}

Future<dynamic> showLocationModal(
  BuildContext context,
  List<DepartmentEntity> listDepartment,
  DepartmentEntity? selectedDepartment,
  Function callback,
) {
  List<DepartmentEntity> renderDepartment = listDepartment;
  final TextEditingController searchLocationController =
      TextEditingController();
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Chọn phòng khám',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: searchLocationController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  onChanged: (value) => setState(() {
                    value = TiengViet.parse(value);
                    renderDepartment = listDepartment
                        .where((element) =>
                            TiengViet.parse(element.display.toLowerCase())
                                .contains(value.toLowerCase()))
                        .toList();
                  }),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    hintText: 'Nhập tên phòng khám',
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchLocationController.clear();
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return ListTile(
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          title: Text(renderDepartment[index].display),
                          onTap: () {
                            callback(renderDepartment[index]);
                            Navigator.of(context).pop();
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selectedDepartment!.code ==
                                            renderDepartment[index].code
                                        ? Colors.grey.shade400
                                        : Colors.blue,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                  ),
                                  onPressed: () {
                                    callback(renderDepartment[index]);

                                    Navigator.of(context).pop();
                                  },
                                  child: Text(selectedDepartment ==
                                          renderDepartment[index]
                                      ? 'Đã chọn'
                                      : 'Chọn')),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 4);
                      },
                      itemCount: renderDepartment.length),
                )
              ],
            ),
          );
        });
      });
}

class AddNutriAssignationArguments {
  NutritionEntity nutrition;
  AddNutriAssignationArguments({required this.nutrition});
}
