import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/widgets.dart';

class AddCareSheetPage extends StatefulWidget {
  const AddCareSheetPage({super.key});

  @override
  State<AddCareSheetPage> createState() => _AddCareSheetPageState();
}

class _AddCareSheetPageState extends State<AddCareSheetPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Tờ chăm sóc',
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
                    const LabelTextField(label: 'Theo dõi diễn biến'),
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
                      )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng điền vào chỗ trống';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    const LabelTextField(label: 'Y lệnh chăm sóc'),
                    const SizedBox(height: 5),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                          // hintText: 'Nhập diễn biến bệnh',
                          suffixIcon: IconButton(
                        alignment: Alignment.bottomRight,
                        icon: const Icon(
                          Icons.mic,
                          color: Colors.blue,
                          size: 30,
                        ),
                        onPressed: () {
                          // Add your microphone button functionality here
                        },
                      )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng điền vào chỗ trống';
                        }
                        return null;
                      },
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
