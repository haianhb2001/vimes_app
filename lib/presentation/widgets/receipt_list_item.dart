import 'package:flutter/material.dart';
import '../../domain/entities/warehouse_receipt.dart';
import '../../core/utils/currency_formatter.dart';

class ReceiptListItem extends StatelessWidget {
  final WarehouseReceipt receipt;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final String Function(DateTime) formatDate;
  final String Function(DateTime) formatDateTime;

  const ReceiptListItem({
    super.key,
    required this.receipt,
    required this.onTap,
    required this.onDelete,
    required this.formatDate,
    required this.formatDateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: onTap,
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Số: ${receipt.number}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                CurrencyFormatter.formatVNDWithUnit(receipt.totalAmount),
                style: TextStyle(color: Colors.green[800], fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('Đơn vị: ${receipt.unit}'),
            Text('Phòng ban: ${receipt.department}'),
            Text('Ngày: ${formatDate(receipt.date)}'),
            Text('Người giao: ${receipt.deliveredBy}'),
            Text('Người nhận: ${receipt.receivedBy}'),
            Text('Thủ kho: ${receipt.storeKeeper}'),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  formatDateTime(receipt.createdAt),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'delete') {
              onDelete();
            }
          },
          itemBuilder:
              (context) => [
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Xóa'),
                    ],
                  ),
                ),
              ],
        ),
      ),
    );
  }
}
