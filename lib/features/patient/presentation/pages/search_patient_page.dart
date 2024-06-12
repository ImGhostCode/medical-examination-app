import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/category/business/entities/department_entity.dart';
import 'package:medical_examination_app/features/category/presentation/providers/category_provider.dart';
import 'package:medical_examination_app/features/patient/business/entities/in_room_patient_entity.dart';
import 'package:medical_examination_app/features/patient/presentation/providers/patient_provider.dart';
import 'package:provider/provider.dart';
import 'package:tiengviet/tiengviet.dart';

class SearchPatientPage extends StatefulWidget {
  const SearchPatientPage({super.key});

  @override
  State<SearchPatientPage> createState() => _SearchPatientPageState();
}

class _SearchPatientPageState extends State<SearchPatientPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _searchLocationController =
      TextEditingController();

  DepartmentEntity? _selectedDepartment;
  List<InRoomPatientEntity> listRenderPatient = [];

  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false)
        .eitherFailureOrGetDepartments('all', 'treatment_role');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _featchPatients() {
    Provider.of<PatientProvider>(context, listen: false)
        .eitherFailureOrGetPatientInRoom(
            _selectedDepartment!.value.toString(),
            'active',
            "2024-03-16 00:00:00",
            '2024-03-16 23:59:59',
            false,
            null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Tìm kiếm bệnh nhân'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (value.listDepartment.isEmpty) {
            return const Center(
              child: Text('Không có dữ liệu'),
            );
          }
          if (value.failure != null) {
            return Center(
              child: Text(value.failure!.errorMessage),
            );
          }

          _selectedDepartment = value.listDepartment.first;
          _locationController.text = _selectedDepartment!.display;

          if (_selectedDepartment != null) {
            _featchPatients();
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
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
                        _showLocationModal(
                          context,
                          value.listDepartment,
                        );
                      },
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    _showLocationModal(
                      context,
                      value.listDepartment,
                    );
                  },
                ),
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
                if (_selectedDepartment != null)
                  Consumer<PatientProvider>(
                      builder: (context, patientProvider, child) {
                    if (patientProvider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (patientProvider.listPatientInRoom.isEmpty) {
                      return const Center(
                        child: Text('Không có dữ liệu'),
                      );
                    }
                    if (patientProvider.failure != null) {
                      return Center(
                        child: Text(patientProvider.failure!.errorMessage),
                      );
                    }

                    listRenderPatient = patientProvider.listRenderPatientInRoom;

                    return Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'STT: ${listRenderPatient[index].encounter}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            listRenderPatient[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          Text(
                                            "Mã số: ${listRenderPatient[index].subject}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Giới tính: ${listRenderPatient[index].gender}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Text(
                                            "Ngày sinh: ${listRenderPatient[index].birthdate}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          )
                                        ],
                                      ),
                                      if (listRenderPatient[index]
                                              .classifyName !=
                                          '')
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 8),
                                            Text(
                                              'Loại bệnh án: ${listRenderPatient[index].classifyName}',
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontStyle:
                                                          FontStyle.italic),
                                            ),
                                          ],
                                        ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                  RouteNames.medialExamine,
                                                  arguments: PatientInfoArguments(
                                                      patient:
                                                          listRenderPatient[
                                                              index],
                                                      division:
                                                          _selectedDepartment!
                                                              .value),
                                                );
                                              },
                                              child: const Text('Thăm khám')),
                                        ],
                                      )
                                    ]));
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 16);
                          },
                          itemCount: listRenderPatient.length),
                    );
                  })
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> _showLocationModal(
    BuildContext context,
    List<DepartmentEntity> listDepartment,
  ) {
    List<DepartmentEntity> renderDepartment = listDepartment;
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
                    controller: _searchLocationController,
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
                          _searchLocationController.clear();
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
                              Navigator.of(context).pop();
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _selectedDepartment ==
                                              renderDepartment[index]
                                          ? Colors.grey.shade400
                                          : Colors.blue,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _selectedDepartment =
                                            renderDepartment[index];
                                        _locationController.text =
                                            _selectedDepartment!.display;
                                        if (_selectedDepartment != null) {
                                          Provider.of<PatientProvider>(context,
                                                  listen: false)
                                              .isLoading = true;
                                          _featchPatients();
                                        }
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(_selectedDepartment ==
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
}

class PatientInfoArguments {
  final InRoomPatientEntity patient;
  final int division;

  PatientInfoArguments({required this.patient, required this.division});
}
