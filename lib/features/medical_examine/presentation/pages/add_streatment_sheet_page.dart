import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/widgets.dart';

class AddStreatmentSheetPage extends StatefulWidget {
  const AddStreatmentSheetPage({super.key});

  @override
  State<AddStreatmentSheetPage> createState() => _AddStreatmentSheetPageState();
}

class _AddStreatmentSheetPageState extends State<AddStreatmentSheetPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Tờ điều trị',
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTextField(label: 'Diễn biến bệnh'),
                    const SizedBox(height: 5),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        // hintText: 'Nhập diễn biến bệnh',
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.mic,
                            color: Colors.blue,
                            size: 30,
                          ),
                          onPressed: () {
                            // Add your microphone button functionality here
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng điền vào chỗ trống';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    const LabelTextField(label: 'Chỉ định dịch vụ'),
                    const SizedBox(height: 5),
                    // ListView.separated(
                    //     shrinkWrap: true,
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     itemBuilder: (context, index) {
                    //       return ListTile(
                    //         minLeadingWidth: 1,
                    //         leading: Text('${index + 1}.',
                    //             style: Theme.of(context).textTheme.bodyMedium),
                    //         title: Text('Xét nghiệm đông máu nhanh tại giường',
                    //             style: Theme.of(context).textTheme.bodyMedium),
                    //         trailing: IconButton(
                    //           icon: const Icon(Icons.delete),
                    //           onPressed: () {
                    //             // Add your delete button functionality here
                    //           },
                    //         ),
                    //       );
                    //     },
                    //     separatorBuilder: (context, index) {
                    //       return const SizedBox(height: 8);
                    //     },
                    //     itemCount: 3)
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ListTile(
                          minLeadingWidth: 1,
                          titleAlignment: ListTileTitleAlignment.center,
                          leading: Text('1.',
                              style: Theme.of(context).textTheme.bodyMedium),
                          title: Text('Xét nghiệm đông máu nhanh tại giường',
                              style: Theme.of(context).textTheme.bodyMedium),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                backgroundColor: Colors.red),
                            onPressed: () {},
                            child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.close_rounded),
                                  Text('Xóa')
                                ]),
                          ),
                        ),
                        ListTile(
                          minLeadingWidth: 1,
                          titleAlignment: ListTileTitleAlignment.center,
                          leading: Text('2.',
                              style: Theme.of(context).textTheme.bodyMedium),
                          title: Text('Chụp X-quang phổi',
                              style: Theme.of(context).textTheme.bodyMedium),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                backgroundColor: Colors.red),
                            onPressed: () {},
                            child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.close_rounded),
                                  Text('Xóa')
                                ]),
                          ),
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add_rounded, color: Colors.blue),
                          Text('Thêm dịch vụ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.blue)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const LabelTextField(label: 'Chỉ định thuốc'),
                    const SizedBox(height: 5),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ListTile(
                          minLeadingWidth: 1,
                          titleAlignment: ListTileTitleAlignment.center,
                          leading: Text('1.',
                              style: Theme.of(context).textTheme.bodyMedium),
                          title: Text('Paracetamol 500mg',
                              style: Theme.of(context).textTheme.bodyMedium),
                          subtitle: const Text(
                              '(buổi sáng 1 viên , buổi chiều 1 viên , trong 1 ngày)',
                              style: TextStyle(fontStyle: FontStyle.italic)),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                backgroundColor: Colors.red),
                            onPressed: () {},
                            child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.close_rounded),
                                  Text('Xóa')
                                ]),
                          ),
                        ),
                        ListTile(
                          minLeadingWidth: 1,
                          titleAlignment: ListTileTitleAlignment.center,
                          leading: Text('2.',
                              style: Theme.of(context).textTheme.bodyMedium),
                          title: Text('Amoxicillin 500mg',
                              style: Theme.of(context).textTheme.bodyMedium),
                          subtitle: const Text(
                              '(buổi sáng 1 viên , buổi chiều 1 viên , trong 1 ngày)',
                              style: TextStyle(fontStyle: FontStyle.italic)),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                backgroundColor: Colors.red),
                            onPressed: () {},
                            child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.close_rounded),
                                  Text('Xóa')
                                ]),
                          ),
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add_rounded, color: Colors.blue),
                          Text('Thêm thuốc',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.blue)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side:
                            BorderSide(color: Colors.grey.shade300, width: 1.5),
                      ),
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {}
                      },
                      child: const Text('Tiếp tục nhập'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      child: const Text('Hoàn tất'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
