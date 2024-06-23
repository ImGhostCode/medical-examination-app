import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/enums.dart';
import 'package:medical_examination_app/core/common/helpers.dart';
import 'package:medical_examination_app/core/common/widgets.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/errors/failure.dart';
import 'package:medical_examination_app/features/category/presentation/providers/category_provider.dart';
import 'package:medical_examination_app/features/nutrition/business/entities/nutrition_entity.dart';
import 'package:medical_examination_app/features/nutrition/business/entities/nutrition_order_entity.dart';
import 'package:medical_examination_app/features/nutrition/presentation/providers/nutrition_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AssignNutritionPage extends StatefulWidget {
  const AssignNutritionPage({super.key});

  @override
  State<AssignNutritionPage> createState() => _AssignNutritionPageState();
}

enum Calendar { day, month, year, custom }

class _AssignNutritionPageState extends State<AssignNutritionPage> {
  final TextEditingController _dateController = TextEditingController();
  Calendar calendarView = Calendar.day;
  DateTime selectedMonth = DateTime.now();
  DateTime selectedDay = DateTime.now();
  int selectedYear = DateTime.now().year;
  PickerDateRange selectedRange = PickerDateRange(
      DateTime.now(), DateTime.now().add(const Duration(days: 30)));
  late DateTime startDate;
  late DateTime endDate;
  late final int selectedDepartment;
  final List<NutritionOrderEntity> selectedNutritionOrders = [];

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedDay = args.value;
      // if (args.value is DateTime) {
      // if (calendarView == Calendar.month) {
      //   selectedMonth = args.value;
      // }
      // selectedYear = args.value.year;
      // } else if (args.value is PickerDateRange) {
      //   selectedRange = args.value;
      // }
    });
  }

  @override
  void initState() {
    // DateTime today = DateTime.now();
    // startDate = DateTime(today.year, today.month, today.day, 0, 0, 0);
    // endDate = DateTime(today.year, today.month, today.day, 23, 59, 59);
    startDate = DateTime(2024, 5, 23, 0, 0, 0);
    endDate = DateTime(2024, 7, 25, 23, 59, 59);

    selectedDepartment = Provider.of<CategoryProvider>(context, listen: false)
        .selectedDepartment!
        .value;
    loadNutritionOrders(context, selectedDepartment, startDate, endDate);
    Provider.of<NutritionProvider>(context, listen: false)
        .eitherFailureOrGetNutritions();
    super.initState();
  }

  Future<void> onSubmit(BuildContext context, String action) async {
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
      // update status of nutritionOrders
      for (var item in Provider.of<NutritionProvider>(context, listen: false)
          .nutritionOrders) {
        if (item.isSelected) {
          item.isSelected = false;
          if (action == ServiceStatus.approved) {
            item.status = ServiceStatus.approved;
          } else if (action == ServiceStatus.cancel ||
              action == ServiceStatus.revoke) {
            item.status = ServiceStatus.cancel;
          }
        }
      }
      selectedNutritionOrders.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    _dateController.text =
        '${selectedDay.day}/${selectedDay.month}/${selectedDay.year}';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Chỉ định dinh dưỡng',
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.zero),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Hoàn tất'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                style: Theme.of(context).textTheme.bodyMedium,
                controller: TextEditingController(text: 'Khoa cấp tính Nam'),
                decoration: const InputDecoration(
                  hintText: 'Chọn phòng khám',
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    size: 30,
                  ),
                ),
                enabled: false,
                canRequestFocus: false,
                ignorePointers: true,
                readOnly: true,
              ),
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
              const SizedBox(height: 8),
              Text('Các dinh dưỡng đã chỉ định',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // if (e.status != ServiceStatus.approved)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(8),
                        backgroundColor: Colors.green),
                    onPressed: () async {
                      showConfirmDialog(context,
                          'Bạn có chắc chắn muốn duyệt chỉ định này không?',
                          (context, text) async {
                        await onSubmit(context, ServiceStatus.approved);
                      }, false, '');
                    },
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.assignment_turned_in_outlined,
                          color: Colors.white),
                      SizedBox(
                        width: 4,
                      ),
                      Text('Duyệt')
                    ]),
                  ),
                  // if (e.status != ServiceStatus.approved)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(8),
                        backgroundColor: Colors.red),
                    onPressed: () async {
                      showConfirmDialog(context,
                          'Bạn có chắc chắn muốn huỷ chỉ định này không?',
                          (context, text) async {
                        await onSubmit(context, ServiceStatus.cancel);
                      }, false, '');
                    },
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.cancel_outlined, color: Colors.white),
                      SizedBox(
                        width: 4,
                      ),
                      Text('Hủy')
                    ]),
                  ),

                  // if (e.status == ServiceStatus.approved)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(8),
                        backgroundColor: Colors.red),
                    onPressed: () async {
                      showConfirmDialog(context,
                          'Bạn có chắc chắn muốn huỷ duyệt chỉ định này không?',
                          (context, text) async {
                        await onSubmit(context, ServiceStatus.revoke);
                      }, false, '');
                    },
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.cancel_outlined, color: Colors.white),
                      SizedBox(
                        width: 4,
                      ),
                      Text('Huỷ duyệt')
                    ]),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Consumer<NutritionProvider>(builder: (context, value, child) {
                if (value.isLoading) {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    child: const CircularProgressIndicator(),
                  );
                }
                if (value.nutritionOrders.isEmpty) {
                  return const Center(
                    child: Text('Không có dữ liệu'),
                  );
                }
                if (value.failure != null) {
                  return Center(
                    child: Text(value.failure!.errorMessage),
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
                          0: FixedColumnWidth(50), // Checkbox
                          1: FixedColumnWidth(50), // TT
                          2: FixedColumnWidth(200), // Dịch vụ
                          // 2: FixedColumnWidth(100), // Số lượng
                          // 3: FixedColumnWidth(100), // Đơn vị
                          // 4: FixedColumnWidth(100), // Giá
                          3: FixedColumnWidth(200), // Bệnh nhân
                          4: FixedColumnWidth(200), // Creators
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
                                  child: const Text('TT')),
                            ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade200),
                                child: const Text(
                                  'Dịch vụ',
                                ),
                              ),
                            ),
                            // TableCell(
                            //   child: Container(
                            //     alignment: Alignment.center,
                            //     padding: const EdgeInsets.all(8),
                            //     decoration:
                            //         BoxDecoration(color: Colors.grey.shade200),
                            //     child: const Text('Số lượng'),
                            //   ),
                            // ),
                            // TableCell(
                            //   child: Container(
                            //     alignment: Alignment.center,
                            //     padding: const EdgeInsets.all(8),
                            //     decoration:
                            //         BoxDecoration(color: Colors.grey.shade200),
                            //     child: const Text('Đơn vị'),
                            //   ),
                            // ),
                            // TableCell(
                            //   child: Container(
                            //     alignment: Alignment.center,
                            //     padding: const EdgeInsets.all(8),
                            //     decoration:
                            //         BoxDecoration(color: Colors.grey.shade200),
                            //     child: const Text('Giá'),
                            //   ),
                            // ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade200),
                                child: const Text('Bênh nhân'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade200),
                                child: const Text('Creators'),
                              ),
                            ),
                          ]),
                          // ...groupByReportCode[item.headerValue]!
                          //     .asMap()
                          //     .entries
                          //     .map((e) {
                          //   return

                          // ...item.expandedValue.map((e) {
                          //   return
                          ...value.nutritionOrders.map((e) {
                            return TableRow(children: [
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  child: e.status != ServiceStatus.cancel
                                      ? Transform.scale(
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
                                                : const WidgetStatePropertyAll(
                                                    Colors.white),
                                            value: e.isSelected,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                e.isSelected = value!;
                                                if (value) {
                                                  selectedNutritionOrders
                                                      .add(e);
                                                } else {
                                                  selectedNutritionOrders
                                                      .remove(e);
                                                }
                                              });
                                            },
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(8),
                                    child: Tooltip(
                                      triggerMode: TooltipTriggerMode.tap,
                                      message: ServiceStatus.statusToVietnamese(
                                          e.status),
                                      child: Icon(
                                          ServiceStatus.statusIcon(e.status),
                                          color: ServiceStatus.statusColor(
                                              e.status)),
                                    )),
                              ),
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    '${e.service} - SL: ${e.quantity} - Đơn vị: ${e.unit}',
                                  ),
                                ),
                              ),
                              // TableCell(
                              //   child: Container(
                              //     alignment: Alignment.center,
                              //     padding: const EdgeInsets.all(8),
                              //     child: Text(
                              //       e.quantity.toString(),
                              //     ),
                              //   ),
                              // ),
                              // TableCell(
                              //   child: Container(
                              //     alignment: Alignment.center,
                              //     padding: const EdgeInsets.all(8),
                              //     child: Text(
                              //       e.unit,
                              //     ),
                              //   ),
                              // ),
                              // TableCell(
                              //   child: Container(
                              //     alignment: Alignment.center,
                              //     padding: const EdgeInsets.all(8),
                              //     child: Text(
                              //       '${formatCurrency(e.)}đ',
                              //     ),
                              //   ),
                              // ),
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    e.name,
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
                                    e.creators,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              )
                            ]);
                          })
                          // }
                          // )
                        ]));
              }),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  showChooseNutritionModal(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add_rounded, color: Colors.blue),
                    Text('Thêm chỉ định dinh dưỡng',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.blue)),
                  ],
                ),
              ),
              const SizedBox(height: 100),
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
              view: getSelectionMode(calendarView),
              selectionMode: calendarView == Calendar.custom
                  ? DateRangePickerSelectionMode.range
                  : DateRangePickerSelectionMode.single,
              monthViewSettings: const DateRangePickerMonthViewSettings(
                  firstDayOfWeek: 1), // Monday as start of week
              initialSelectedDate: calendarView == Calendar.custom
                  ? selectedRange.startDate
                  : selectedDay,
              initialSelectedRange:
                  calendarView == Calendar.custom ? selectedRange : null,
              onSelectionChanged: _onSelectionChanged,
              allowViewNavigation: calendarView == Calendar.custom ||
                      calendarView == Calendar.day
                  ? true
                  : false,
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
                  // Assign appropriately based on view
                  if (calendarView == Calendar.custom) {
                    startDate = DateTime(selectedYear, selectedMonth.month, 1);
                    endDate =
                        DateTime(selectedYear, selectedMonth.month + 1, 0);
                  } else if (calendarView == Calendar.month) {
                    startDate = selectedMonth;
                    endDate = DateTime(
                        selectedMonth.year, selectedMonth.month + 1, 0);
                  } else if (calendarView == Calendar.day) {
                    startDate = DateTime(selectedDay.year, selectedDay.month,
                        selectedDay.day, 0, 0, 0);
                    endDate = DateTime(selectedDay.year, selectedDay.month,
                        selectedDay.day, 23, 59, 59);
                  } else {
                    startDate = DateTime(selectedYear, 1, 1);
                    endDate = DateTime(selectedYear, 12, 31); // End of the year
                  }
                });
                Provider.of<NutritionProvider>(context, listen: false)
                    .eitherFailureOrGetNutritionOrders(
                        ServiceStatus.all,
                        selectedDepartment,
                        formatDateParam(startDate),
                        formatDateParam(endDate));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void loadNutritionOrders(BuildContext context, int selectedDepartment,
    DateTime startDate, DateTime endDate) {
  Provider.of<NutritionProvider>(context, listen: false)
      .eitherFailureOrGetNutritionOrders(ServiceStatus.all, 'all',
          formatDateParam(startDate), formatDateParam(endDate));
}

Future<dynamic> showChooseNutritionModal(
  BuildContext context,
  // List<DepartmentEntity> listDepartment,
  // Function callback,
) {
  // List<DepartmentEntity> renderDepartment = listDepartment;
  final TextEditingController searchNutritionController =
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
                  'Chọn dinh dưỡng',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: searchNutritionController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  onChanged: (value) {
                    setState(() => {});
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    hintText: 'Nhập tên để tìm kiếm',
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchNutritionController.clear();
                        setState(() => {});
                      },
                    ),
                  ),
                ),
                Consumer<NutritionProvider>(builder: (context, value, child) {
                  if (value.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (value.nutritions.isEmpty) {
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

                  List<NutritionEntity> renderNutritions = value.nutritions
                      .where((element) => normalizeText(element.display)
                          .contains(
                              normalizeText(searchNutritionController.text)))
                      .toList();

                  return Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            titleTextStyle:
                                Theme.of(context).textTheme.bodyMedium,
                            title: Text(renderNutritions[index].display),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed(
                                  RouteNames.addNutritionAssignation,
                                  arguments: AddNutriAssignationArguments(
                                      nutrition: renderNutritions[index]));
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushNamed(
                                          RouteNames.addNutritionAssignation,
                                          arguments:
                                              AddNutriAssignationArguments(
                                                  nutrition:
                                                      renderNutritions[index]));
                                    },
                                    child: const Text('Chọn')),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 4);
                        },
                        itemCount: renderNutritions.length),
                  );
                })
              ],
            ),
          );
        });
      });
}

DateRangePickerView getSelectionMode(Calendar selectedView) {
  switch (selectedView) {
    case Calendar.month:
      return DateRangePickerView.year;
    case Calendar.year:
      return DateRangePickerView.decade;
    case Calendar.custom:
      return DateRangePickerView.month;
    default:
      return DateRangePickerView.month;
  }
}

class AddNutriAssignationArguments {
  NutritionEntity nutrition;
  AddNutriAssignationArguments({required this.nutrition});
}
