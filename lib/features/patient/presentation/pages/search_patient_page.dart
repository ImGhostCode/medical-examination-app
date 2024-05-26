import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/constants/constants.dart';

class SearchPatientPage extends StatefulWidget {
  const SearchPatientPage({super.key});

  @override
  State<SearchPatientPage> createState() => _SearchPatientPageState();
}

class _SearchPatientPageState extends State<SearchPatientPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _locationController =
      TextEditingController(text: 'PK số 28');
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
      body: Padding(
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
                    _showLocationModal(context);
                  },
                ),
              ),
              readOnly: true,
              onTap: () {
                _showLocationModal(context);
              },
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16, top: 8),
              color: Colors.white,
              child: TextField(
                controller: _searchController,
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
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'STT: 24000652',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Nguyễn Văn A',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Mã số: 123456",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Giới tính: Nam',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    "Ngày sinh: 1990",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Chuẩn đoán: Bệnh thương hàn và phó thương hàn',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontStyle: FontStyle.italic),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      RouteNames.medialExamine,
                                    );
                                  },
                                  child: const Text('Thăm khám'))
                            ]));
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16);
                  },
                  itemCount: 3),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showLocationModal(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
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
                  controller: _locationController,
                  style: Theme.of(context).textTheme.bodyMedium,
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
                        _locationController.clear();
                      },
                    ),
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    ListTile(
                      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                      title: const Text('Khoa Thu Dung Điều trị COVID-19'),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                              ),
                              onPressed: () {},
                              child: const Text('Chọn')),
                        ],
                      ),
                    ),
                    ListTile(
                      title: const Text('Khoa Y học cổ truyền'),
                      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade400,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                              ),
                              onPressed: () {},
                              child: const Text('Đã chọn')),
                        ],
                      ),
                    ),
                    ListTile(
                      title: const Text('PK số 30'),
                      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                              ),
                              onPressed: () {},
                              child: const Text('Chọn')),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
