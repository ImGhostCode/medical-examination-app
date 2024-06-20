import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:medical_examination_app/features/category/presentation/providers/category_provider.dart';
import 'package:medical_examination_app/features/patient/presentation/pages/search_patient_page.dart';
import 'package:medical_examination_app/features/patient/presentation/providers/patient_provider.dart';
import 'package:medical_examination_app/features/user/business/entities/user_entity.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// DepartmentEntity? _selectedDepartment;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    if (Provider.of<CategoryProvider>(context, listen: false)
            .selectedDepartment ==
        null) {
      Provider.of<CategoryProvider>(context, listen: false)
          .eitherFailureOrGetDepartments('all', 'treatment_role');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Feature> features = [
      Feature(
        title: 'Tạo hồ sơ bệnh nhân',
        icon: 'assets/icons/cre-patient-removebg-preview.png',
        onTap: () {
          Navigator.of(context).pushNamed(RouteNames.crePatientProfile);
        },
      ),
      Feature(
        title: 'Thăm khám',
        icon: 'assets/icons/record-removebg-preview.png',
        onTap: () async {
          final provider = Provider.of<PatientProvider>(context, listen: false);
          if (provider.selectedPatientInRoom == null) {
            await Navigator.of(context).pushNamed(RouteNames.searchPatients);
          }

          if (provider.selectedPatientInRoom != null) {
            Navigator.of(context).pushNamed(
              RouteNames.medialExamine,
              arguments: PatientInfoArguments(
                patient: provider.selectedPatientInRoom!,
                division: Provider.of<CategoryProvider>(context, listen: false)
                    .selectedDepartment!
                    .value,
              ),
            );
          }
        },
      ),
      Feature(
        title: 'Chỉ định dịch vụ',
        icon: 'assets/images/cute-set-medical-service-cartoon-vector.jpg',
        onTap: () async {
          final provider = Provider.of<PatientProvider>(context, listen: false);
          if (provider.selectedPatientInRoom == null) {
            await Navigator.of(context).pushNamed(RouteNames.searchPatients);
          }

          if (provider.selectedPatientInRoom != null) {
            Navigator.of(context).pushNamed(
              RouteNames.assignService,
            );
          }
        },
      ),
    ];

    UserEntity? user = Provider.of<AuthProvider>(context).userEntity;

    return Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chào buổi ${getGreeting()}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                          Text(
                            user?.display ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.search_rounded,
                              size: 30,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.notifications_outlined,
                              size: 30,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 8),
                  child: Consumer<CategoryProvider>(
                    builder: (context, value, child) {
                      if (value.isLoading) {
                        return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: const SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                )));
                      }
                      if (value.listDepartment.isEmpty) {
                        return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: const Text('Không có dữ liệu',
                                style: TextStyle(color: Colors.white)));
                      }
                      if (value.failure != null) {
                        return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(value.failure!.errorMessage,
                                style: const TextStyle(color: Colors.white)));
                      }

                      return TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          showLocationModal(context, value.listDepartment,
                              value.selectedDepartment, (department) {
                            setState(() {
                              value.selectedDepartment = department;
                              Provider.of<PatientProvider>(context,
                                      listen: false)
                                  .selectedPatientInRoom = null;
                            });
                          });
                        },
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            Provider.of<CategoryProvider>(context,
                                    listen: false)
                                .selectedDepartment!
                                .display,
                          ),
                          const Icon(Icons.keyboard_arrow_down_rounded),
                        ]),
                      );
                    },
                  ),
                ),

                Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.18),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.12),
                              Text(
                                'Tính năng nổi bật',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 16, left: 16, right: 16),
                          padding: const EdgeInsets.all(16),
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 3,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(28)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 0.7,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                    ),
                                    itemCount: features.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: features[index].onTap,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Image.asset(
                                                  features[index].icon),
                                            ),
                                            Text(
                                              features[index].title,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        )),
                  ],
                )
                // Positioned(
                //   top: 0,
                //   left: 0,
                //   child: Stack(children: [
                //     Container(
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(24),
                //       ),
                //       width: MediaQuery.of(context).size.width,
                //       height: MediaQuery.of(context).size.height * 0.25,
                //     ),
                //   ]),
                // )
              ],
            ),
          ),
        ));
  }
}

class Feature {
  final String title;
  final String icon;
  final VoidCallback onTap;

  Feature({required this.title, required this.icon, required this.onTap});
}

String getGreeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'sáng';
  }
  if (hour < 18) {
    return 'chiều';
  }
  return 'tối';
}
