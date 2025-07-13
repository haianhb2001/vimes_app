import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color? iconColor;
  final Color? textColor;

  const EmptyStateWidget({
    super.key,
    this.icon = Icons.inbox_outlined,
    this.message = 'Không có dữ liệu',
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: iconColor ?? Colors.grey),
          const SizedBox(height: 16),
          Text(message, style: TextStyle(fontSize: 16, color: textColor ?? Colors.grey)),
        ],
      ),
    );
  }
}
