import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_examination_app/core/constants/constants.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Setting> settings = [
      Setting(
        title: 'Cài đặt tài khoản',
        icon: const Icon(Icons.settings_outlined),
        onTap: () {
          Navigator.of(context).pushNamed(RouteNames.accountSetting);
        },
      ),
      Setting(
        title: 'Cài đặt thông báo',
        icon: const Icon(Icons.notifications_outlined),
        onTap: () {},
      ),
    ];

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
                      Text(
                        'Hồ sơ của tôi',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 10),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.edit_outlined,
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
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: const BorderRadius.only(
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
                                'Cài đặt',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(settings[index].title),
                                        leading: settings[index].icon,
                                        onTap: settings[index].onTap,
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        color: Colors.grey.shade200,
                                        height: 1,
                                      );
                                    },
                                    itemCount: settings.length),
                              )
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
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/doctor-example-removebg-preview.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'BS Nguyễn Văn A',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Giới tính:',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: Colors.black),
                                            children: const <TextSpan>[
                                              TextSpan(
                                                text: ' Nam',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Chuyên khoa: ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: Colors.black),
                                            children: const <TextSpan>[
                                              TextSpan(
                                                text: 'Nội khoa',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ))),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class Setting {
  final String title;
  final Icon icon;
  final VoidCallback onTap;

  Setting({required this.title, required this.icon, required this.onTap});
}
