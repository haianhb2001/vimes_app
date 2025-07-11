import 'package:flutter/material.dart';

class RequiredDateField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const RequiredDateField({
    Key? key,
    required this.controller,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(Icons.calendar_today),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            controller.text = picked.toIso8601String().substring(0, 10);
          }
        },
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
