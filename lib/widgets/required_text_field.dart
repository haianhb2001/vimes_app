import 'package:flutter/material.dart';

class RequiredTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isNumber;

  const RequiredTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.isNumber = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Trường này là bắt buộc';
          }
          return null;
        },
      ),
    );
  }
}
