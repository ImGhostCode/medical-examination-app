import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/core/services/shared_pref_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:permission_handler/permission_handler.dart';'

final SharedPreferences prefs = SharedPrefService.prefs;

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  int currTab = 0;
  Timer? _timer;
  void _printTabIndex() {
    setState(() {
      currTab = _tabController.index;
    });
  }

  @override
  void initState() {
    super.initState();
    // _requestPermission();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_printTabIndex);
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
      setState(() {
        _tabController.index = (_tabController.index + 1) % 3;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Image.asset(
                                'assets/images/happy-cartoon-doctor.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ghi nhận thông tin thăm khám',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            Text('dễ dàng',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Image.asset(
                                'assets/images/schedule-a-appointment.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Đặt lịch hẹn bác sĩ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            Text('nhanh chóng',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Center(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Image.asset(
                                  'assets/images/online-healthcare-and-medical-advise-tele.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: 'Tư vấn trực tuyến \n',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'tiện lợi',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currTab == 0
                              ? Colors.blue
                              : Colors.grey.shade300)),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currTab == 1
                              ? Colors.blue
                              : Colors.grey.shade300)),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currTab == 2
                              ? Colors.blue
                              : Colors.grey.shade300)),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pushNamed(RouteNames.login);
                  },
                  child: Text(
                    'Bắt đầu ngay',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // void _requestPermission() async {
  //   var status = await Permission.notification.status;
  //   var alarmStatus = await Permission.scheduleExactAlarm.status;

  //   if (status.isPermanentlyDenied) {
  //     return;
  //   }
  //   if (status.isDenied) {
  //     await Permission.notification.request();
  //   }

  //   if (alarmStatus.isPermanentlyDenied) {
  //     return;
  //   }
  //   if (alarmStatus.isDenied) {
  //     await Permission.scheduleExactAlarm.request();
  //   }
  // }
}

/*
String? storedUser;

@override
void initState() {
  super.initState();
  _loadUserName();
}

void _loadUserName() async {
  storedUser = await prefs.getString('userName');
  if (storedUser != null) {
    Navigator.of(context).pushNamed(RouteNames.login);
  }
}

@override
Widget build(BuildContext context) {
  return FutureBuilder(
    future: _loadUserName(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // Show loading while waiting for data
      } else {
        // Your normal build code here
      }
    },
  );
}
*/