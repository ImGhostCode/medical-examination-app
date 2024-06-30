import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/enums.dart';
import 'package:medical_examination_app/core/common/helpers.dart';
import 'package:medical_examination_app/core/common/widgets.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/errors/failure.dart';
import 'package:medical_examination_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:medical_examination_app/features/category/presentation/providers/category_provider.dart';
import 'package:medical_examination_app/features/patient/business/entities/in_room_patient_entity.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_entity.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_service_entity.dart';
import 'package:medical_examination_app/features/patient/presentation/providers/patient_provider.dart';
import 'package:medical_examination_app/features/patient/presentation/widgets/patient_info_container.dart';
import 'package:provider/provider.dart';
import 'package:tiengviet/tiengviet.dart';

class AssignServicePage extends StatefulWidget {
  const AssignServicePage({super.key});

  @override
  State<AssignServicePage> createState() => _AssignServicePageState();
}

class _AssignServicePageState extends State<AssignServicePage> {
  late InRoomPatientEntity selectedPatient;
  final List<EnumSubclinicService> listEnumSubclinicService =
      enumSubclinicServices;

  late List<SubclinicExpansionItem> subclinicExpansionItems;
  @override
  void initState() {
    listEnumSubclinicService.sort((a, b) =>
        TiengViet.parse(a.display).compareTo(TiengViet.parse(b.display)));
    listEnumSubclinicService.insert(
      0,
      EnumSubclinicService(code: 'FEE_000', display: 'Chưa phân loại'),
    );
    listEnumSubclinicService.insert(
      listEnumSubclinicService.length,
      EnumSubclinicService(code: 'FEE_011', display: 'Khác'),
    );
    subclinicExpansionItems = listEnumSubclinicService
        .map((e) =>
            SubclinicExpansionItem(headerValue: e.display, isExpanded: false))
        .toList();
    selectedPatient = Provider.of<PatientProvider>(context, listen: false)
        .selectedPatientInRoom!;
    Provider.of<PatientProvider>(context, listen: false)
        .eitherFailureOrGetPatientServices('all', selectedPatient.encounter);
    super.initState();
  }

  // Future<

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Dịch vụ cận lâm sàng',
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
              PatientInfoContainer(
                patient: Provider.of<PatientProvider>(context, listen: false)
                    .selectedPatientInRoom!,
                onPatientChange: () {
                  Navigator.of(context).pushNamed(
                    RouteNames.assignService,
                  );
                },
              ),
              const SizedBox(height: 8),
              Text('Các dịch vụ đã chỉ định',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ExpansionPanelList(
                      expandedHeaderPadding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                      ),
                      dividerColor: Colors.white,
                      elevation: 0,
                      materialGapSize: 0,
                      expansionCallback: (int index, bool isExpanded) async {
                        if (isExpanded &&
                            subclinicExpansionItems[index].expandedValue ==
                                null) {
                          subclinicExpansionItems[index].isLoading = true;
                          loadDataForSubclinic(
                                  listEnumSubclinicService[index].code)
                              .then((loadedData) {
                            setState(() {
                              subclinicExpansionItems[index].isLoading = false;
                              if (loadedData is Failure ||
                                  loadedData is ServerFailure) {
                                subclinicExpansionItems[index].error =
                                    (loadedData as Failure).errorMessage;
                              } else {
                                subclinicExpansionItems[index].expandedValue =
                                    loadedData as ResponseModel<
                                        List<PatientServiceEntity>>;
                              }
                            });
                          });
                        }
                        setState(() {
                          subclinicExpansionItems[index].isExpanded =
                              isExpanded;
                        });
                      },
                      children: subclinicExpansionItems
                          .map<ExpansionPanel>((SubclinicExpansionItem item) {
                        return ExpansionPanel(
                          backgroundColor: Colors.white,
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                              title: Text(
                                item.headerValue,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              trailing: item.expandedValue != null
                                  ? (item.expandedValue!.data
                                          .where((e) => e.isSelected == true)
                                          .isNotEmpty
                                      ? ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.all(8),
                                              backgroundColor: Colors.green),
                                          onPressed: () async {
                                            await showConfirmDialog(context,
                                                'Bạn có chắc chắn muốn ban hành dịch vụ này không?',
                                                (BuildContext contextInner,
                                                    String text) async {
                                              if (Provider.of<PatientProvider>(
                                                      context,
                                                      listen: false)
                                                  .isLoading) return;
                                              List<PatientServiceEntity>
                                                  selectedServices = item
                                                      .expandedValue!.data
                                                      .where((e) =>
                                                          e.isSelected == true)
                                                      .toList();
                                              final result = await Provider.of<
                                                          PatientProvider>(
                                                      context,
                                                      listen: false)
                                                  .eitherFailureOrPublishPatientService(
                                                      ServiceStatus.publish,
                                                      selectedPatient.encounter,
                                                      Provider.of<AuthProvider>(
                                                              context,
                                                              listen: false)
                                                          .userEntity!
                                                          .id,
                                                      selectedServices,
                                                      text);

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
                                                  const SnackBar(
                                                    content: Text(
                                                        'Ban hành thành công!'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                                item.expandedValue!.data
                                                    .forEach((element) {
                                                  element.isSelected = false;
                                                  element.status =
                                                      ServiceStatus.publish;
                                                });
                                              }
                                            }, true, 'Ghi chú');
                                          },
                                          child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                    Icons.check_circle_outline),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text('Ban hành')
                                              ]),
                                        )
                                      : const SizedBox.shrink())
                                  : const SizedBox.shrink(),
                            );
                          },
                          body: item.isLoading
                              ? Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  child: const CircularProgressIndicator(),
                                )
                              : (item.error != null
                                  ? Center(
                                      child: Text(item.error!),
                                    )
                                  : item.expandedValue != null
                                      ? SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Table(
                                              border: TableBorder.all(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      Colors.blueGrey.shade100,
                                                  width: 1.5),
                                              defaultVerticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              columnWidths: const {
                                                0: FixedColumnWidth(50),
                                                1: FixedColumnWidth(50),
                                                2: FixedColumnWidth(200),
                                                // 3: FixedColumnWidth(100),
                                                // 4: FixedColumnWidth(100),
                                                3: FixedColumnWidth(100),
                                                4: FixedColumnWidth(200),
                                              },
                                              children: [
                                                TableRow(children: [
                                                  TableCell(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey.shade200),
                                                      child: const Text(''),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade200),
                                                        child:
                                                            const Text('TT')),
                                                  ),
                                                  TableCell(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey.shade200),
                                                      child: const Text(
                                                        'Dịch vụ',
                                                      ),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey.shade200),
                                                      child: const Text('Giá'),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey.shade200),
                                                      child: const Text(
                                                          'Kết quả'),
                                                    ),
                                                  ),
                                                ]),
                                                ...item.expandedValue!.data
                                                    .map((e) {
                                                  return TableRow(
                                                      decoration: BoxDecoration(
                                                          color: e.isSelected
                                                              ? Colors
                                                                  .blue.shade50
                                                              : Colors.white),
                                                      children: [
                                                        TableCell(
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            // padding:
                                                            //     const EdgeInsets.all(8),
                                                            child: e.status ==
                                                                    ServiceStatus
                                                                        .planned
                                                                ? Transform
                                                                    .scale(
                                                                    scale: 1.4,
                                                                    child:
                                                                        Checkbox(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(3)),
                                                                      side: BorderSide(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade600,
                                                                          width:
                                                                              1.5),
                                                                      checkColor:
                                                                          Colors
                                                                              .white,
                                                                      fillColor: e
                                                                              .isSelected
                                                                          ? const WidgetStatePropertyAll(Colors
                                                                              .blue)
                                                                          : const WidgetStatePropertyAll(
                                                                              Colors.white),
                                                                      value: e
                                                                          .isSelected,
                                                                      onChanged:
                                                                          (bool?
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          e.isSelected =
                                                                              value!;
                                                                        });
                                                                      },
                                                                    ),
                                                                  )
                                                                : const SizedBox
                                                                    .shrink(),
                                                          ),
                                                        ),
                                                        TableCell(
                                                          child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              child: Tooltip(
                                                                triggerMode:
                                                                    TooltipTriggerMode
                                                                        .tap,
                                                                message: ServiceStatus
                                                                    .statusToVietnamese(
                                                                        e.status),
                                                                child: Icon(
                                                                    ServiceStatus
                                                                        .statusIcon(e
                                                                            .status),
                                                                    color: ServiceStatus
                                                                        .statusColor(
                                                                            e.status)),
                                                              )),
                                                        ),
                                                        TableCell(
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
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
                                                        TableCell(
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child: Text(
                                                              '${formatCurrency(e.price)}đ',
                                                            ),
                                                          ),
                                                        ),
                                                        TableCell(
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child: Text(
                                                              e.result ?? '',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .green),
                                                            ),
                                                          ),
                                                        ),
                                                      ]);
                                                })
                                              ]))
                                      : const SizedBox.shrink()),
                          isExpanded: item.isExpanded,
                        );
                      }).toList(),
                    ),
                    // Consumer<PatientProvider>(builder: (context, value, child) {
                    //   if (value.isLoadingServices) {
                    //     return Container(
                    //       alignment: Alignment.center,
                    //       padding: const EdgeInsets.all(16),
                    //       child: const CircularProgressIndicator(),
                    //     );
                    //   }
                    //   if (value.listPatientServices.isEmpty) {
                    //     return const Center(
                    //       child: Text('Không có dữ liệu'),
                    //     );
                    //   }
                    //   if (value.failure != null) {
                    //     return Center(
                    //       child: Text(value.failure!.errorMessage),
                    //     );
                    //   }

                    //   return ExpansionPanelList(
                    //     expandedHeaderPadding: const EdgeInsets.only(
                    //       top: 8,
                    //       bottom: 8,
                    //     ),
                    //     dividerColor: Colors.white,
                    //     elevation: 0,
                    //     materialGapSize: 0,
                    //     expansionCallback: (int index, bool isExpanded) {
                    //       setState(() {
                    //         value.patientSerExpandedItems[index].isExpanded =
                    //             isExpanded;
                    //       });
                    //     },
                    //     children: value.patientSerExpandedItems
                    //         .map<ExpansionPanel>((PatientSerExpandedItem item) {
                    //       return ExpansionPanel(
                    //         backgroundColor: Colors.white,
                    //         headerBuilder:
                    //             (BuildContext context, bool isExpanded) {
                    //           return ListTile(
                    //             contentPadding: const EdgeInsets.symmetric(
                    //                 horizontal: 16, vertical: 0),
                    //             title: Text(
                    //               item.headerValue,
                    //               style: Theme.of(context).textTheme.bodyMedium,
                    //             ),
                    //             trailing: item.expandedValue
                    //                     .where((e) => e.isSelected == true)
                    //                     .isNotEmpty
                    //                 ? ElevatedButton(
                    //                     style: ElevatedButton.styleFrom(
                    //                         padding: const EdgeInsets.all(8),
                    //                         backgroundColor: Colors.green),
                    //                     onPressed: () async {
                    //                       await showConfirmDialog(context,
                    //                           'Bạn có chắc chắn muốn ban hành dịch vụ này không?',
                    //                           (BuildContext contextInner,
                    //                               String text) async {
                    //                         if (Provider.of<PatientProvider>(
                    //                                 context,
                    //                                 listen: false)
                    //                             .isLoading) return;
                    //                         List<PatientServiceEntity>
                    //                             selectedServices = item
                    //                                 .expandedValue
                    //                                 .where((e) =>
                    //                                     e.isSelected == true)
                    //                                 .toList();
                    //                         final result = await Provider.of<
                    //                                     PatientProvider>(
                    //                                 context,
                    //                                 listen: false)
                    //                             .eitherFailureOrPublishPatientService(
                    //                                 ServiceStatus.publish,
                    //                                 selectedPatient.encounter,
                    //                                 Provider.of<AuthProvider>(
                    //                                         context,
                    //                                         listen: false)
                    //                                     .userEntity!
                    //                                     .id,
                    //                                 selectedServices,
                    //                                 text);

                    //                         if (result.runtimeType == Failure) {
                    //                           ScaffoldMessenger.of(contextInner)
                    //                               .showSnackBar(
                    //                             SnackBar(
                    //                               content: Text(
                    //                                   (result as Failure)
                    //                                       .errorMessage),
                    //                               backgroundColor: Colors.red,
                    //                             ),
                    //                           );
                    //                         } else {
                    //                           ScaffoldMessenger.of(contextInner)
                    //                               .showSnackBar(
                    //                             const SnackBar(
                    //                               content: Text(
                    //                                   'Ban hành thành công!'),
                    //                               backgroundColor: Colors.green,
                    //                             ),
                    //                           );
                    //                           Provider.of<PatientProvider>(
                    //                                   context,
                    //                                   listen: false)
                    //                               .eitherFailureOrGetPatientServices(
                    //                                   'all',
                    //                                   selectedPatient
                    //                                       .encounter);
                    //                         }
                    //                       }, true, 'Ghi chú');
                    //                     },
                    //                     child: const Row(
                    //                         mainAxisSize: MainAxisSize.min,
                    //                         children: [
                    //                           Icon(Icons.check_circle_outline),
                    //                           SizedBox(
                    //                             width: 4,
                    //                           ),
                    //                           Text('Ban hành')
                    //                         ]),
                    //                   )
                    //                 : const SizedBox.shrink(),
                    //           );
                    //         },
                    //         body: SingleChildScrollView(
                    //             scrollDirection: Axis.horizontal,
                    //             child: Table(
                    //                 border: TableBorder.all(
                    //                     borderRadius: BorderRadius.circular(5),
                    //                     color: Colors.blueGrey.shade100,
                    //                     width: 1.5),
                    //                 defaultVerticalAlignment:
                    //                     TableCellVerticalAlignment.middle,
                    //                 columnWidths: const {
                    //                   0: FixedColumnWidth(50),
                    //                   1: FixedColumnWidth(50),
                    //                   2: FixedColumnWidth(200),
                    //                   // 3: FixedColumnWidth(100),
                    //                   // 4: FixedColumnWidth(100),
                    //                   3: FixedColumnWidth(100),
                    //                   4: FixedColumnWidth(200),
                    //                 },
                    //                 children: [
                    //                   TableRow(children: [
                    //                     TableCell(
                    //                       child: Container(
                    //                         alignment: Alignment.center,
                    //                         padding: const EdgeInsets.all(8),
                    //                         decoration: BoxDecoration(
                    //                             color: Colors.grey.shade200),
                    //                         child: const Text(''),
                    //                       ),
                    //                     ),
                    //                     TableCell(
                    //                       child: Container(
                    //                           alignment: Alignment.center,
                    //                           padding: const EdgeInsets.all(8),
                    //                           decoration: BoxDecoration(
                    //                               color: Colors.grey.shade200),
                    //                           child: const Text('TT')),
                    //                     ),
                    //                     TableCell(
                    //                       child: Container(
                    //                         alignment: Alignment.center,
                    //                         padding: const EdgeInsets.all(8),
                    //                         decoration: BoxDecoration(
                    //                             color: Colors.grey.shade200),
                    //                         child: const Text(
                    //                           'Dịch vụ',
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     // TableCell(
                    //                     //   child: Container(
                    //                     //     alignment: Alignment.center,
                    //                     //     padding: const EdgeInsets.all(8),
                    //                     //     decoration: BoxDecoration(
                    //                     //         color: Colors.grey.shade200),
                    //                     //     child: const Text('Số lượng'),
                    //                     //   ),
                    //                     // ),
                    //                     // TableCell(
                    //                     //   child: Container(
                    //                     //     alignment: Alignment.center,
                    //                     //     padding: const EdgeInsets.all(8),
                    //                     //     decoration: BoxDecoration(
                    //                     //         color: Colors.grey.shade200),
                    //                     //     child: const Text('Đơn vị'),
                    //                     //   ),
                    //                     // ),
                    //                     TableCell(
                    //                       child: Container(
                    //                         alignment: Alignment.center,
                    //                         padding: const EdgeInsets.all(8),
                    //                         decoration: BoxDecoration(
                    //                             color: Colors.grey.shade200),
                    //                         child: const Text('Giá'),
                    //                       ),
                    //                     ),
                    //                     TableCell(
                    //                       child: Container(
                    //                         alignment: Alignment.center,
                    //                         padding: const EdgeInsets.all(8),
                    //                         decoration: BoxDecoration(
                    //                             color: Colors.grey.shade200),
                    //                         child: const Text('Kết quả'),
                    //                       ),
                    //                     ),
                    //                   ]),
                    //                   // ...groupByReportCode[item.headerValue]!
                    //                   //     .asMap()
                    //                   //     .entries
                    //                   //     .map((e) {
                    //                   //   return

                    //                   ...item.expandedValue.map((e) {
                    //                     return TableRow(
                    //                         decoration: BoxDecoration(
                    //                             color: e.isSelected
                    //                                 ? Colors.blue.shade50
                    //                                 : Colors.white),
                    //                         children: [
                    //                           TableCell(
                    //                             child: Container(
                    //                               alignment: Alignment.center,
                    //                               // padding:
                    //                               //     const EdgeInsets.all(8),
                    //                               child: e.status ==
                    //                                       ServiceStatus.planned
                    //                                   ? Transform.scale(
                    //                                       scale: 1.4,
                    //                                       child: Checkbox(
                    //                                         shape: RoundedRectangleBorder(
                    //                                             borderRadius:
                    //                                                 BorderRadius
                    //                                                     .circular(
                    //                                                         3)),
                    //                                         side: BorderSide(
                    //                                             color: Colors
                    //                                                 .grey
                    //                                                 .shade600,
                    //                                             width: 1.5),
                    //                                         checkColor:
                    //                                             Colors.white,
                    //                                         fillColor: e
                    //                                                 .isSelected
                    //                                             ? const WidgetStatePropertyAll(
                    //                                                 Colors.blue)
                    //                                             : const WidgetStatePropertyAll(
                    //                                                 Colors
                    //                                                     .white),
                    //                                         value: e.isSelected,
                    //                                         onChanged:
                    //                                             (bool? value) {
                    //                                           setState(() {
                    //                                             e.isSelected =
                    //                                                 value!;
                    //                                           });
                    //                                         },
                    //                                       ),
                    //                                     )
                    //                                   : const SizedBox.shrink(),
                    //                             ),
                    //                           ),
                    //                           TableCell(
                    //                             child: Container(
                    //                                 alignment: Alignment.center,
                    //                                 padding:
                    //                                     const EdgeInsets.all(8),
                    //                                 child: Tooltip(
                    //                                   triggerMode:
                    //                                       TooltipTriggerMode
                    //                                           .tap,
                    //                                   message: ServiceStatus
                    //                                       .statusToVietnamese(
                    //                                           e.status),
                    //                                   child: Icon(
                    //                                       ServiceStatus
                    //                                           .statusIcon(
                    //                                               e.status),
                    //                                       color: ServiceStatus
                    //                                           .statusColor(
                    //                                               e.status)),
                    //                                 )),
                    //                           ),
                    //                           TableCell(
                    //                             child: Container(
                    //                               alignment: Alignment.center,
                    //                               padding:
                    //                                   const EdgeInsets.all(8),
                    //                               child: Text(
                    //                                 '${e.service} - SL: ${e.quantity} - Đơn vị: ${e.unit}',
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           // TableCell(
                    //                           //   child: Container(
                    //                           //     alignment: Alignment.center,
                    //                           //     padding: const EdgeInsets.all(8),
                    //                           //     child: Text(
                    //                           //       e.quantity.toString(),
                    //                           //     ),
                    //                           //   ),
                    //                           // ),
                    //                           // TableCell(
                    //                           //   child: Container(
                    //                           //     alignment: Alignment.center,
                    //                           //     padding: const EdgeInsets.all(8),
                    //                           //     child: Text(
                    //                           //       e.unit,
                    //                           //     ),
                    //                           //   ),
                    //                           // ),
                    //                           TableCell(
                    //                             child: Container(
                    //                               alignment: Alignment.center,
                    //                               padding:
                    //                                   const EdgeInsets.all(8),
                    //                               child: Text(
                    //                                 '${formatCurrency(e.price)}đ',
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           TableCell(
                    //                             child: Container(
                    //                               alignment: Alignment.center,
                    //                               padding:
                    //                                   const EdgeInsets.all(8),
                    //                               child: Text(
                    //                                 e.result ?? '',
                    //                                 style: Theme.of(context)
                    //                                     .textTheme
                    //                                     .bodyMedium!
                    //                                     .copyWith(
                    //                                         color:
                    //                                             Colors.green),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ]);
                    //                   })
                    //                 ])),
                    //         isExpanded: item.isExpanded,
                    //       );
                    //     }).toList(),
                    //   );
                    // }),
                    TextButton(
                      onPressed: Provider.of<PatientProvider>(context,
                                      listen: true)
                                  .patientInfo ==
                              null
                          ? null
                          : () {
                              PatientEntity patientInfo =
                                  Provider.of<PatientProvider>(context,
                                          listen: false)
                                      .patientInfo!;

                              Navigator.of(context).pushNamed(
                                  RouteNames.requestClinicalService,
                                  arguments: SubclinicSerDesignationArguments(
                                      patientInfo: patientInfo,
                                      division: Provider.of<CategoryProvider>(
                                              context,
                                              listen: false)
                                          .selectedDepartment!
                                          .value));
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
                    const SizedBox(height: 100),
                  ]),
            ],
          ),
        ),
      ),
    );
  }

  loadDataForSubclinic(String code) async {
    final result = await Provider.of<PatientProvider>(context, listen: false)
        .eitherFailureOrGetPatientServices(code, selectedPatient.encounter);
    return result;
  }
}

class SubclinicSerDesignationArguments {
  final PatientEntity patientInfo;
  final int division;

  SubclinicSerDesignationArguments(
      {required this.patientInfo, required this.division});
}

class PatientSerExpandedItem {
  PatientSerExpandedItem({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = true,
  });

  List<PatientServiceEntity> expandedValue;
  String headerValue;
  bool isExpanded;
}

class SubclinicExpansionItem {
  SubclinicExpansionItem({
    this.expandedValue,
    required this.headerValue,
    this.isExpanded = true,
    this.isLoading = false,
  });

  ResponseModel<List<PatientServiceEntity>>? expandedValue;
  String? error;
  String headerValue;
  bool isExpanded;
  bool isLoading = false;
}
