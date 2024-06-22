import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/helpers.dart';
import 'package:medical_examination_app/features/category/presentation/providers/category_provider.dart';
import 'package:medical_examination_app/features/patient/business/entities/in_room_patient_entity.dart';
import 'package:medical_examination_app/features/patient/presentation/providers/patient_provider.dart';
import 'package:provider/provider.dart';

class AddNutritionAssginationPage extends StatefulWidget {
  const AddNutritionAssginationPage({super.key});

  @override
  State<AddNutritionAssginationPage> createState() =>
      _AddNutritionAssginationPageState();
}

class _AddNutritionAssginationPageState
    extends State<AddNutritionAssginationPage> {
  final TextEditingController _searchController = TextEditingController();
  List<InRoomPatientEntity> listRenderPatient = [];

  @override
  void initState() {
    final int selectedDepartment =
        Provider.of<CategoryProvider>(context, listen: false)
            .selectedDepartment!
            .value;
    Provider.of<PatientProvider>(context, listen: false)
        .eitherFailureOrGetPatientInRoom(
            selectedDepartment.toString(),
            'active',
            "2024-03-16 00:00:00",
            '2024-03-16 23:59:59',
            false,
            null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Thêm chỉ định dinh dưỡng',
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      bottomSheet: _buildBottomNavbar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                // border: Border.all(color: Colors.grey.shade300, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cơm chay',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Price
                      RichText(
                        text: TextSpan(
                          text: 'Giá: ',
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: <TextSpan>[
                            TextSpan(
                                text: '${formatCurrency(123552)}đ',
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
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                IconButton(
                                    // onPressed: selectedSubclinicServices[index]
                                    //         .editQuantity!
                                    //     ? () {
                                    //         if (selectedSubclinicServices[index]
                                    //                 .quantity! >
                                    //             1) {
                                    //           selectedSubclinicServices[index]
                                    //                   .quantity =
                                    //               selectedSubclinicServices[
                                    //                           index]
                                    //                       .quantity! -
                                    //                   1;
                                    //           setState(() {});
                                    //         }
                                    //       }
                                    //     : null,
                                    onPressed: () {},
                                    icon: Icon(Icons.remove_rounded,
                                        color:
                                            // selectedSubclinicServices[index]
                                            //         .editQuantity!
                                            //     ?
                                            Colors.blue
                                        // :
                                        //  Colors.grey,
                                        )),
                                Text('${1}'),
                                IconButton(
                                    // onPressed: selectedSubclinicServices[index]
                                    //         .editQuantity!
                                    //     ? () {
                                    //         selectedSubclinicServices[index]
                                    //                 .quantity =
                                    //             selectedSubclinicServices[index]
                                    //                     .quantity! +
                                    //                 1;
                                    //         setState(() {});
                                    //       }
                                    //     : null,

                                    onPressed: () {},
                                    icon: Icon(Icons.add_rounded,
                                        color:
                                            // selectedSubclinicServices[index]
                                            //         .editQuantity!
                                            //     ?
                                            Colors.blue
                                        // :
                                        //  Colors.grey,
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
            ),
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
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            '${listRenderPatient[index].encounter} - ${listRenderPatient[index].name}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              '${listRenderPatient[index].gender} - Ngày sinh: ${listRenderPatient[index].birthdate}'),
                          trailing: Transform.scale(
                            scale: 1.4,
                            child: Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              side: BorderSide(
                                  color: Colors.grey.shade600, width: 1.5),
                              checkColor: Colors.white,
                              fillColor: true
                                  ? const WidgetStatePropertyAll(Colors.blue)
                                  : null,
                              value: true,
                              onChanged: (value) {},
                            ),
                          ),
                        );
                      },
                      itemCount: listRenderPatient.length),
                );
              })
          ],
        ),
      ),
    );
  }
}

Container _buildBottomNavbar(BuildContext context) {
  // int total = selectedSubclinicServices.fold(
  //     0,
  //     (previousValue, element) =>
  //         previousValue + element.price! * element.quantity!);
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Tổng cộng: '),
              Text(
                '${formatCurrency(123543)}đ',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.blue),
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
                      // Provider.of<MedicalExamineProvider>(context,
                      //             listen: true)
                      //         .isLoading
                      //     ? null
                      //     :
                      () async {
                    // saveData(false, () {
                    //   Navigator.of(context).pop();
                    //   Provider.of<PatientProvider>(context, listen: false)
                    //       .eitherFailureOrGetPatientServices(
                    //           'all', args.patientInfo.encounter);
                    // });
                  },
                  child: const Text('Lưu'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed:
                      // Provider.of<MedicalExamineProvider>(context,
                      //             listen: true)
                      //         .isLoading
                      //     ? null
                      //     :
                      () async {
                    // saveData(true, () {
                    //   Navigator.of(context).pop();
                    //   Provider.of<PatientProvider>(context, listen: false)
                    //       .eitherFailureOrGetPatientServices(
                    //           'all', args.patientInfo.encounter);
                    // });
                  },
                  child: const Text('Ban hành'),
                ),
              ),
            ],
          ),
        ],
      ));
}
