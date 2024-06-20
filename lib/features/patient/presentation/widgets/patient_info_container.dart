import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/enums.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/patient/business/entities/in_room_patient_entity.dart';
import 'package:medical_examination_app/features/patient/presentation/providers/patient_provider.dart';
import 'package:provider/provider.dart';

class PatientInfoContainer extends StatefulWidget {
  final InRoomPatientEntity patient;
  final VoidCallback onPatientChange;
  const PatientInfoContainer(
      {super.key, required this.patient, required this.onPatientChange});
  @override
  State<PatientInfoContainer> createState() => _PatientInfoContainerState();
}

class _PatientInfoContainerState extends State<PatientInfoContainer> {
  bool _userInfoExpanded = false;

  @override
  void initState() {
    Provider.of<PatientProvider>(context, listen: false)
        .eitherFailureOrGetPatientInfo('all', widget.patient.encounter);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        onExpansionChanged: (bool expanded) {
          setState(() {
            _userInfoExpanded = expanded;
          });
        },
        collapsedShape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8)),
        title: Text(
          _userInfoExpanded ? 'Thông tin bệnh nhân' : widget.patient.name,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<PatientProvider>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (value.patientInfo == null) {
                return const Center(
                  child: Text('Không có dữ liệu'),
                );
              }
              if (value.failure != null) {
                return Center(
                  child: Text(value.failure!.errorMessage),
                );
              }
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Số HSBA: ${value.patientInfo!.encounter}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          value.patientInfo!.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "MSBN: ${value.patientInfo!.subject}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Giới tính: ${widget.patient.gender}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "Ngày sinh: ${value.patientInfo!.birthdate}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    // const SizedBox(height: 8),
                    // Text('Địa chỉ: ${value.patientInfo!.address}',
                    //     style: Theme.of(context).textTheme.bodyMedium),
                    if (widget.patient.classifyName != '')
                      const SizedBox(height: 8),
                    if (widget.patient.classifyName != '')
                      Text(
                        'Loại bệnh án: ${widget.patient.classifyName}',
                      ),
                    const SizedBox(height: 8),
                    if (value.patientInfo!.medicalClass == MedicalClass.IMP &&
                        value.patientInfo!.location.isNotEmpty)
                      Text(
                        'Vị trí: ${value.patientInfo!.location[0].display}',
                      ),

                    const SizedBox(height: 8),
                    Text(
                      'BHYT: ${value.patientInfo!.healthInsuranceCard != null ? "Có sử dụng" : "Không sử dụng"}',
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    // color:
                                    //     Theme.of(context).colorScheme.primary,
                                    // fontWeight: FontWeight.bold
                                    )),
                        onPressed: () async {
                          final selectedPatient = await Navigator.of(context)
                              .pushNamed(RouteNames.searchPatients);
                          if (selectedPatient != null) {
                            Navigator.of(context).pop();
                            widget.onPatientChange();
                          }
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.swap_horiz,
                              size: 28,
                            ),
                            SizedBox(width: 8),
                            Text('Thay đổi bệnh nhân')
                          ],
                        ))
                  ]);
            },
          )
        ]);
  }
}
