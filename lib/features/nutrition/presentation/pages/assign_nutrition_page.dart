import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/helpers.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/errors/failure.dart';
import 'package:medical_examination_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:medical_examination_app/features/category/business/entities/department_entity.dart';
import 'package:medical_examination_app/features/category/presentation/providers/category_provider.dart';
import 'package:medical_examination_app/features/nutrition/business/entities/nutrition_entity.dart';
import 'package:medical_examination_app/features/nutrition/presentation/providers/nutrition_provider.dart';
import 'package:medical_examination_app/features/patient/business/entities/in_room_patient_entity.dart';
import 'package:medical_examination_app/features/patient/presentation/providers/patient_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AssignNutritionPage extends StatefulWidget {
  const AssignNutritionPage({super.key});

  @override
  State<AssignNutritionPage> createState() => _AssignNutritionPageState();
}

class _AssignNutritionPageState extends State<AssignNutritionPage> {
  final TextEditingController _searchController = TextEditingController();
  List<InRoomPatientEntity> listRenderPatient = [];
  final List<InRoomPatientEntity> selectedPatients = [];
  // late AddNutriAssignationArguments args;
  DateTime planDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  NutritionEntity? selectedNutrition;
  late DepartmentEntity selectedDepartment;
  int numOfDays = 1;

  @override
  void initState() {
    selectedDepartment = Provider.of<CategoryProvider>(context, listen: false)
        .selectedDepartment!;
    Provider.of<PatientProvider>(context, listen: false)
        .eitherFailureOrGetPatientInRoom(
            selectedDepartment.value.toString(),
            'active',
            "2024-03-16 00:00:00",
            '2024-03-16 23:59:59',
            false,
            null);
    Provider.of<NutritionProvider>(context, listen: false)
        .eitherFailureOrGetNutritions();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void saveData(bool isPublish, VoidCallback callback) async {
    if (selectedPatients.isNotEmpty) {
      int doctor =
          Provider.of<AuthProvider>(context, listen: false).userEntity!.id;
      final result =
          await Provider.of<NutritionProvider>(context, listen: false)
              .eitherFailureOrAssignNutrition(
                  doctor,
                  selectedNutrition!.code,
                  selectedPatients,
                  isPublish,
                  planDate.toString().substring(0, 10),
                  selectedNutrition!.quantity!);

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

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    selectedDate = args.value;
  }

  @override
  Widget build(BuildContext context) {
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
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, RouteNames.nutritionAssignationHistory);
              },
              child: Text(
                'Lịch sử',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.blue),
              ))
        ],
      ),
      bottomSheet: _buildBottomNavbar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                style: Theme.of(context).textTheme.bodyMedium,
                controller:
                    TextEditingController(text: selectedDepartment.display),
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
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Plan Date
                  Text(
                      'Ngày dự kiến: ${planDate.day}/${planDate.month}/${planDate.year}',
                      style: Theme.of(context).textTheme.bodyMedium),
                  // const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      _dialogPickerBuilder(context);
                    },
                    icon: const Icon(Icons.calendar_today_rounded),
                    color: Colors.blue,
                  )
                ],
              ),
              // const SizedBox(height: 8),'
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Số ngày',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(width: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        // padding: const EdgeInsets.symmetric(
                        //     horizontal: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (numOfDays > 1) {
                                    numOfDays = numOfDays - 1;
                                    setState(() {});
                                  }
                                },
                                icon: Icon(
                                  Icons.remove_rounded,
                                  color:
                                      numOfDays > 1 ? Colors.blue : Colors.grey,
                                )),
                            Text(numOfDays.toString(),
                                style: Theme.of(context).textTheme.bodyMedium),
                            IconButton(
                                onPressed: () {
                                  numOfDays = numOfDays + 1;
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.add_rounded,
                                  color: Colors.blue,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Dinh dưỡng',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              selectedNutrition == null
                  ? TextButton(
                      onPressed: () {
                        showChooseNutritionModal(
                          context,
                          (nutrition) {
                            setState(() {
                              selectedNutrition = nutrition;
                            });
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add_rounded, color: Colors.blue),
                          Text('Chọn dinh dưỡng',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.blue)),
                        ],
                      ),
                    )
                  : ListTile(
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(color: Colors.grey.shade300, width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: const EdgeInsets.only(left: 16),
                      title: Text(selectedNutrition!.display,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                      subtitle: RichText(
                        text: TextSpan(
                          text: 'Giá: ',
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    '${formatCurrency(selectedNutrition!.price)}đ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showChooseNutritionModal(context, (nutrition) {
                            setState(() {
                              selectedNutrition = nutrition;
                            });
                          });
                        },
                        icon: const Icon(
                          Icons.swap_horiz_rounded,
                          size: 28,
                          color: Colors.blue,
                        ),
                      )),
              const SizedBox(height: 8),
              Text('Danh sách bệnh nhân',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.only(bottom: 16, top: 8),
                color: Colors.white,
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    Provider.of<PatientProvider>(context, listen: false)
                        .searchPatientInRoom(value);
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    hintText: 'Nhập tên hoặc mã số bệnh nhân',
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        Provider.of<PatientProvider>(context, listen: false)
                            .searchPatientInRoom('');
                      },
                    ),
                  ),
                ),
              ),
              if (Provider.of<CategoryProvider>(context, listen: false)
                      .selectedDepartment !=
                  null)
                Consumer<PatientProvider>(
                    builder: (context, patientProvider, child) {
                  if (patientProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (patientProvider.failure != null) {
                    return Center(
                      child: Text(patientProvider.failure!.errorMessage),
                    );
                  }
                  if (patientProvider.listPatientInRoom.isEmpty) {
                    return const Center(
                      child: Text('Không có dữ liệu'),
                    );
                  }

                  listRenderPatient = patientProvider.listRenderPatientInRoom;

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
                          1: FixedColumnWidth(100), // Số HSBA
                          2: FixedColumnWidth(100), // Mã BN
                          3: FixedColumnWidth(200), // Tên BN
                          4: FixedColumnWidth(100), // Năm sinh

                          // 5: FixedColumnWidth(100), // Giường
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

                            // TableCell(
                            //   child: Container(
                            //     alignment: Alignment.center,
                            //     padding: const EdgeInsets.all(8),
                            //     decoration:
                            //         BoxDecoration(color: Colors.grey.shade200),
                            //     child: const Text('Giường'),
                            //   ),
                            // ),
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
                          ...listRenderPatient.map((e) {
                            return TableRow(
                                decoration: BoxDecoration(
                                    color: e.isSelected
                                        ? Colors.blue.shade50
                                        : Colors.white),
                                children: [
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      // padding: const EdgeInsets.all(4),
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
                                                selectedPatients.add(e);
                                              } else {
                                                selectedPatients.remove(e);
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
                                        e.encounter.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
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
                                        e.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        e.birthdate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ),
                                ]);
                          })
                          // }
                          // )
                        ]),
                  );
                }),
              const SizedBox(height: 150),
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
              initialSelectedDate: planDate,

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
                  planDate = selectedDate;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Container _buildBottomNavbar(BuildContext context) {
    int total =
        selectedNutrition == null ? 0 : selectedNutrition!.price * numOfDays;
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
                    onPressed:
                        Provider.of<NutritionProvider>(context, listen: true)
                                    .isLoading ||
                                selectedPatients.isEmpty
                            ? null
                            : () async {
                                saveData(false, () {
                                  planDate = DateTime.now();
                                  numOfDays = 1;
                                  selectedNutrition = null;
                                  selectedPatients.clear();
                                  listRenderPatient.forEach((element) {
                                    element.isSelected = false;
                                  });
                                  setState(() {});
                                  // Navigator.of(context).pop();
                                });
                              },
                    child: const Text('Lưu'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        Provider.of<NutritionProvider>(context, listen: true)
                                    .isLoading ||
                                selectedPatients.isEmpty
                            ? null
                            : () async {
                                saveData(true, () {
                                  planDate = DateTime.now();
                                  numOfDays = 1;
                                  selectedNutrition = null;
                                  selectedPatients.clear();
                                  listRenderPatient.forEach((element) {
                                    element.isSelected = false;
                                  });
                                  setState(() {});
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

  Future<dynamic> showChooseNutritionModal(
    BuildContext context,
    Function(NutritionEntity nutrition) callback,
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
                    // if (value.failure != null) {
                    //   return Center(
                    //     child: Text(value.failure!.errorMessage),
                    //   );
                    // }

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
                                callback(renderNutritions[index]);
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
                                        callback(renderNutritions[index]);
                                        Navigator.of(context).pop();
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
}
