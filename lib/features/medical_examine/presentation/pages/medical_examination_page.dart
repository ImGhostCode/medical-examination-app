import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/widgets.dart';
import 'package:medical_examination_app/core/constants/constants.dart';

class MedicalExaminationPage extends StatefulWidget {
  const MedicalExaminationPage({super.key});

  @override
  State<MedicalExaminationPage> createState() => _MedicalExaminationPageState();
}

class _MedicalExaminationPageState extends State<MedicalExaminationPage> {
  int _index = 0;
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Ghi nhận thông tin\nthăm khám',
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              // Patient info
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ExpansionTile(
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        _customTileExpanded = expanded;
                      });
                    },
                    collapsedShape: RoundedRectangleBorder(
                        side:
                            BorderSide(color: Colors.grey.shade300, width: 1.5),
                        borderRadius: BorderRadius.circular(8)),
                    shape: RoundedRectangleBorder(
                        side:
                            BorderSide(color: Colors.grey.shade300, width: 1.5),
                        borderRadius: BorderRadius.circular(8)),
                    title: Text(
                      _customTileExpanded
                          ? 'Thông tin bệnh nhân'
                          : 'Nguyễn Văn A',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    childrenPadding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Giới tính: Nam',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "Ngày sinh: 1990",
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('Địa chỉ: Xã Sĩ Hai, Huyện Hà Quảng, Tỉnh Cao Bằng',
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 8),
                      Text(
                        'Chuẩn đoán: Bệnh thương hàn và phó thương hàn',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                    ]),
              ),
              Stepper(
                physics: const NeverScrollableScrollPhysics(),
                currentStep: _index,
                onStepCancel: () {
                  if (_index > 0) {
                    setState(() {
                      _index -= 1;
                    });
                  }
                },
                onStepContinue: () {
                  if (_index <= 1) {
                    setState(() {
                      _index += 1;
                    });
                  }
                },
                onStepTapped: (int index) {
                  setState(() {
                    _index = index;
                  });
                },
                controlsBuilder: (context, details) => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_index > 0)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade400,
                            padding: const EdgeInsets.all(12)),
                        onPressed: details.onStepCancel,
                        child: const Text('Quay lại'),
                      ),
                    const SizedBox(width: 8),
                    if (_index < 2)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(12)),
                        onPressed: details.onStepContinue,
                        child: const Text('Tiếp theo'),
                      ),
                    // if (_index == 2)
                    //   ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //         padding: const EdgeInsets.all(12)),
                    //     onPressed: () {},
                    //     child: const Text('Hoàn tất'),
                    //   ),
                  ],
                ),
                steps: <Step>[
                  Step(
                    stepStyle: StepStyle(
                      color: _index == 0 ? Colors.blue : Colors.grey.shade400,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sinh hiệu',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      _index == 0 ? Colors.blue : Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        if (_index == 0)
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(8),
                                  backgroundColor: Colors.blue),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RouteNames.addSignal);
                              },
                              child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.edit_outlined),
                                    Text('Chỉnh sửa')
                                  ])),
                      ],
                    ),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const LabelTextField(label: 'Mạch'),
                            const SizedBox(height: 8),
                            // Table with 2 columns: value and date
                            Table(
                              border: TableBorder.all(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8)),
                              columnWidths: const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1),
                              },
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: [
                                // Table header
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(8)),
                                        ),
                                        child: Text('Giá trị',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(8)),
                                        ),
                                        child: Text('Thời gian',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontStyle:
                                                        FontStyle.italic)),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Text('80 lần/phút',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Text('25/05/2024 08:55:50',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontStyle: FontStyle.italic)),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Text('80 lần/phút',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Text('25/05/2024 08:55:50',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontStyle: FontStyle.italic)),
                                    ),
                                  ),
                                ]),
                              ],
                            ),

                            const SizedBox(height: 16),
                          ],
                        )),
                  ),
                  Step(
                    stepStyle: StepStyle(
                      color: _index == 1 ? Colors.blue : Colors.grey.shade400,
                    ),
                    title: Text(
                      'Tờ điều trị',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: _index == 1 ? Colors.blue : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Tờ điều trị số 1',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  backgroundColor: Colors.blue),
                                              onPressed: () {},
                                              child: const Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.edit_outlined),
                                                    Text('Chỉnh sửa')
                                                  ])),
                                          const SizedBox(width: 8),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  backgroundColor: Colors.red),
                                              onPressed: () {},
                                              child: const Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.close_rounded),
                                                    Text('Xóa')
                                                  ])),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                            'Diễn biến bệnh: Huyết áp tăng'),
                                        const SizedBox(height: 8),
                                        const Text('Chỉ định dịch vụ:'),
                                        const SizedBox(height: 4),
                                        ListView(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: const [
                                            Text(
                                                '1. Xét nghiệm đông máu nhanh tại giường'),
                                            Text('2. Chụp X-quang'),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        const Text('Chỉ định thuốc:'),
                                        const SizedBox(height: 4),
                                        ListView(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: const [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('1. Paracetamol 500mg'),
                                                Text(
                                                    '(buổi sáng 1 viên , buổi chiều 1 viên , trong 1 ngày)',
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic))
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('2. Amoxicillin 500mg'),
                                                Text(
                                                    '(buổi sáng 1 viên , buổi chiều 1 viên , trong 1 ngày)',
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          RouteNames.addStreatmentSheet);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.add_rounded,
                                            color: Colors.blue),
                                        Text('Thêm tờ điều trị mới',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: Colors.blue)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                  Step(
                    stepStyle: StepStyle(
                      color: _index == 2 ? Colors.blue : Colors.grey.shade400,
                    ),
                    title: Text(
                      'Tờ chăm sóc',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: _index == 2 ? Colors.blue : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Tờ chăm sóc số 1',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  backgroundColor: Colors.blue),
                                              onPressed: () {},
                                              child: const Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.edit_outlined),
                                                    Text('Chỉnh sửa')
                                                  ])),
                                          const SizedBox(width: 8),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  backgroundColor: Colors.red),
                                              onPressed: () {},
                                              child: const Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.close_rounded),
                                                    Text('Xóa')
                                                  ])),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                            'Theo dỗi diễn biến: Huyết áp tăng'),
                                        const SizedBox(height: 8),
                                        const Text('Y lệnh chăm sóc:'),
                                        const SizedBox(height: 4),
                                        ListView(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: const [
                                            Text(
                                                '1. Theo dõi huyết áp hàng giờ'),
                                            Text(
                                                '2. Theo dõi nhịp thở hàng giờ'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(RouteNames.addCareSheet);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.add_rounded,
                                            color: Colors.blue),
                                        Text('Thêm tờ chăm sóc mới',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: Colors.blue)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Lưu thông tin thăm khám'),
                ),
              ),
            ],
          ),
        ));
  }
}
