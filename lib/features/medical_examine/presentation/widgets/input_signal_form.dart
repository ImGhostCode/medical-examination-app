import 'package:flutter/material.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/providers/medical_examine_provider.dart';
import 'package:provider/provider.dart';

class InputSignalForm extends StatelessWidget {
  InputSignalForm({
    super.key,
    required this.unit,
    required this.onSubmitted,
  });

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final String unit;
  final Future<bool> Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                helperText: 'Đơn vị: $unit',
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
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: ElevatedButton(
                onPressed:
                    Provider.of<MedicalExamineProvider>(context, listen: true)
                            .isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              final success =
                                  await onSubmitted(_controller.text);
                              if (success) {
                                _controller.clear();
                              }
                            }
                          },
                child: const Text('Lưu')),
          )
        ],
      ),
    );
  }
}
