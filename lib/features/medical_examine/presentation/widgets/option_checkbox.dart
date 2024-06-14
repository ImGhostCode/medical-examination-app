import 'package:flutter/material.dart';

class OptionCheckbox extends StatelessWidget {
  const OptionCheckbox({
    super.key,
    required this.title,
    required this.onPressed,
    required this.value,
  });
  final String title;
  final void Function(bool?) onPressed;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 1.4,
          child: Checkbox(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            side: BorderSide(color: Colors.grey.shade600, width: 1.5),
            checkColor: Colors.white,
            fillColor: value ? const WidgetStatePropertyAll(Colors.blue) : null,
            value: value,
            onChanged: onPressed,
          ),
        ),
        Text(title)
      ],
    );
  }
}
