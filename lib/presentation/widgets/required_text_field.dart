import 'package:flutter/material.dart';

class RequiredTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isNumber;

  const RequiredTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isNumber = false,
  });

  @override
  State<RequiredTextField> createState() => _RequiredTextFieldState();
}

class _RequiredTextFieldState extends State<RequiredTextField> {
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
        keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
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
        onChanged: (value) {
          // Clear lỗi khi người dùng bắt đầu nhập
          if (_hasError && value.trim().isNotEmpty) {
            setState(() {
              _hasError = false;
            });
          }
        },
      ),
    );
  }
}
