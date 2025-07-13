import 'package:flutter/material.dart';

class RequiredDateField extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const RequiredDateField({super.key, required this.controller, required this.label});

  @override
  State<RequiredDateField> createState() => _RequiredDateFieldState();
}

class _RequiredDateFieldState extends State<RequiredDateField> {
  late FocusNode _focusNode;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && _hasError) {
      setState(() {
        _hasError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.indigo, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
        readOnly: true,
        onTap: () async {
          // Clear lỗi khi focus vào field
          if (_hasError) {
            setState(() {
              _hasError = false;
            });
          }

          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            widget.controller.text = picked.toIso8601String().substring(0, 10);
            setState(() {
              _hasError = false;
            });
          }
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            setState(() {
              _hasError = true;
            });
            return 'Trường này là bắt buộc';
          }
          setState(() {
            _hasError = false;
          });
          return null;
        },
      ),
    );
  }
}
