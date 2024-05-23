import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/constants/constants.dart';

class SearchPatientPage extends StatelessWidget {
  const SearchPatientPage({super.key});

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
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              color: Colors.white,
              child: TextField(
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.bold),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.grey.shade600),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                  'Địa chỉ: Xã Sĩ Hai, Huyện Hà Quảng, Tỉnh Cao Bằng'),
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
}
