import 'package:flutter/material.dart';

class LabelTextField extends StatelessWidget {
  final String label;
  const LabelTextField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
