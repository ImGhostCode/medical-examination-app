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

class SearchInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  const SearchInputField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.prefixIcon,
      this.suffixIcon,
      this.onSuffixIconPressed});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyMedium,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon,
          size: 30,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                ),
                onPressed: onSuffixIconPressed,
              )
            : null,
      ),
    );
  }
}

Future<void> showConfirmDialog(BuildContext context, String message,
    Function callback, bool hasTextField, String hinText) async {
  final TextEditingController controller = TextEditingController();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext contextInner) {
      return AlertDialog(
        title: const Text('Xác nhận'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            if (hasTextField)
              const SizedBox(
                height: 8,
              ),
            if (hasTextField)
              TextField(
                controller: controller,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: hinText,
                ),
              ),
          ],
        ),
        actions: <Widget>[
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text('Hủy bỏ'),
                  onPressed: () {
                    Navigator.of(contextInner).pop();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Xác nhận'),
                  onPressed: () async {
                    await callback(contextInner, controller.text);
                    Navigator.of(contextInner).pop();
                  },
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
