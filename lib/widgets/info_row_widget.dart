import 'package:flutter/material.dart';

class InfoRowWidget extends StatelessWidget {
  final String label;
  final String value;
  final double labelWidth;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const InfoRowWidget({
    super.key,
    required this.label,
    required this.value,
    this.labelWidth = 140,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: labelWidth,
            child: Text(
              label,
              style: labelStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          Expanded(child: Text(value, style: valueStyle ?? const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
