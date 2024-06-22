import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/enums.dart';
import 'package:medical_examination_app/core/common/helpers.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
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
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  // Update state when view or selection changes
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    print(args.value);
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
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                      border: TableBorder.all(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueGrey.shade100,
                          width: 1.5),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FixedColumnWidth(50), // TT
                        1: FixedColumnWidth(200), // Dịch vụ
                        2: FixedColumnWidth(100), // Số lượng
                        3: FixedColumnWidth(100), // Đơn vị
                        4: FixedColumnWidth(100), // Giá
                        5: FixedColumnWidth(200), // Bệnh nhân
                        6: FixedColumnWidth(50), // Hành động
                      },
                      children: [
                        TableRow(children: [
                          TableCell(
                            child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade200),
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
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200),
                              child: const Text('Số lượng'),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200),
                              child: const Text('Đơn vị'),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200),
                              child: const Text('Giá'),
                            ),
                          ),
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
                              child: const Text(''),
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
                        TableRow(children: [
                          TableCell(
                            child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                child: Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  message: ServiceStatus.statusToVietnamese(
                                      ServiceStatus.approved),
                                  child: Icon(
                                      ServiceStatus.statusIcon(
                                          ServiceStatus.approved),
                                      color: ServiceStatus.statusColor(
                                          ServiceStatus.approved)),
                                )),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Cơm trắng',
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                2.toString(),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'ngày',
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '${formatCurrency(125343)}đ',
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Nguyễn Văn A',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.green),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              child:
                                  ServiceStatus.planned == ServiceStatus.planned
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
                                            fillColor: true
                                                ? const WidgetStatePropertyAll(
                                                    Colors.blue)
                                                : const WidgetStatePropertyAll(
                                                    Colors.white),
                                            value: true,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                // e.isSelected = value!;
                                              });
                                            },
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                            ),
                          ),
                        ])
                        // }
                        // )
                      ])),
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
              allowViewNavigation:
                  calendarView == Calendar.custom ? true : false,
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
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
                  onChanged: (value) {},
                  // => setState(() {
                  // value = TiengViet.parse(value);
                  // renderDepartment = listDepartment
                  //     .where((element) =>
                  //         TiengViet.parse(element.display.toLowerCase())
                  //             .contains(value.toLowerCase()))
                  //     .toList();
                  // }),
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
                          contentPadding: EdgeInsets.zero,
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          title: Text('Cơm trắng'),
                          onTap: () {
                            Navigator.of(context).pop();
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
                                        RouteNames.addNutritionAssignation);
                                  },
                                  child: const Text('Chọn')),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 4);
                      },
                      itemCount: 15),
                )
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
