import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/widgets.dart';

enum BloodType { A, B, AB, O }

class AddSignalPage extends StatefulWidget {
  const AddSignalPage({super.key});

  @override
  State<AddSignalPage> createState() => _AddSignalPageState();
}

class _AddSignalPageState extends State<AddSignalPage> {
  final _formKey = GlobalKey<FormState>();
  BloodType _bloodType = BloodType.A;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Sinh hiệu',
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
                    const LabelTextField(label: 'Mạch'),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        helperText: 'Đơn vị: lần/phút',
                        helperStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng điền vào chỗ trống';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    const LabelTextField(label: 'Nhiệt độ'),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        helperText: 'Đơn vị: độ C',
                        helperStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng điền vào chỗ trống';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    const LabelTextField(label: 'SP02'),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        helperText: 'Đơn vị: %',
                        helperStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng điền vào chỗ trống';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    const LabelTextField(label: 'Nhịp thở'),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        helperText: 'Đơn vị: lần/phút',
                        helperStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng điền vào chỗ trống';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    const LabelTextField(label: 'Chiều cao'),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        helperText: 'Đơn vị: cm',
                        helperStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng điền vào chỗ trống';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    const LabelTextField(label: 'Cân nặng'),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        helperText: 'Đơn vị: Kg',
                        helperStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng điền vào chỗ trống';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    const LabelTextField(label: 'Nhóm máu'),
                    const SizedBox(height: 5),
                    DropdownButtonFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        value: _bloodType,
                        validator: (value) {
                          if (value == null) {
                            return 'Vui lòng chọn nhóm máu';
                          }
                          return null;
                        },
                        items: const [
                          DropdownMenuItem(
                            value: BloodType.A,
                            child: Text('A'),
                          ),
                          DropdownMenuItem(
                            value: BloodType.B,
                            child: Text('B'),
                          ),
                          DropdownMenuItem(
                            value: BloodType.AB,
                            child: Text('AB'),
                          ),
                          DropdownMenuItem(
                            value: BloodType.O,
                            child: Text('O'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _bloodType = value as BloodType;
                          });
                        }),
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
