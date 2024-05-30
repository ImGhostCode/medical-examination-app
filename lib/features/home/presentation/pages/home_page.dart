import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:medical_examination_app/features/user/business/entities/user_entity.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        onTap: () {
          Navigator.of(context).pushNamed(RouteNames.searchPatients);
        },
      ),
    ];

    UserEntity? user = Provider.of<AuthProvider>(context).userEntity;

    return Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chào buổi sáng',
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
                Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2),
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
                          margin: const EdgeInsets.all(16),
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
