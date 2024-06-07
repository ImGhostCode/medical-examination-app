import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/enums.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/providers/medical_examine_provider.dart';
import 'package:provider/provider.dart';

class InputBloodTypeForm extends StatefulWidget {
  const InputBloodTypeForm({super.key, required this.onSubmitted});
  // Void Callback with String parameter
  final void Function(String) onSubmitted;

  @override
  State<InputBloodTypeForm> createState() => _InputBloodTypeFormState();
}

class _InputBloodTypeFormState extends State<InputBloodTypeForm> {
  String bloodType = bloodTypes[0];
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: DropdownButtonFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                value: bloodType,
                validator: (value) {
                  if (value == null) {
                    return 'Vui lòng chọn nhóm máu';
                  }
                  return null;
                },
                items: bloodTypes
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onTap: () {},
                onChanged: (value) {
                  setState(() {
                    bloodType = value.toString();
                  });
                }),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: ElevatedButton(
                onPressed:
                    Provider.of<MedicalExamineProvider>(context, listen: true)
                            .isLoading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              widget.onSubmitted(bloodType);
                            }
                          },
                child: const Text('Lưu')),
          )
        ],
      ),
    );
  }
}
