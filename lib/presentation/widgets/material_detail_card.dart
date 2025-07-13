import 'package:flutter/material.dart';
import '../../domain/entities/material_item.dart';
import '../../core/utils/currency_formatter.dart';
import 'info_row_widget.dart';

class MaterialDetailCard extends StatelessWidget {
  final MaterialItem item;

  const MaterialDetailCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.indigo[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'STT: ${item.index}',
                    style: TextStyle(
                      color: Colors.indigo[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            InfoRowWidget(
              label: 'Mã vật tư:',
              value: item.code,
              labelWidth: 120,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontSize: 14,
              ),
              valueStyle: const TextStyle(fontSize: 14),
            ),
            InfoRowWidget(
              label: 'Đơn vị:',
              value: item.unit,
              labelWidth: 120,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontSize: 14,
              ),
              valueStyle: const TextStyle(fontSize: 14),
            ),
            InfoRowWidget(
              label: 'SL theo chứng từ:',
              value: '${item.quantityDocument}',
              labelWidth: 120,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontSize: 14,
              ),
              valueStyle: const TextStyle(fontSize: 14),
            ),
            InfoRowWidget(
              label: 'SL thực nhận:',
              value: '${item.quantityReceived}',
              labelWidth: 120,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontSize: 14,
              ),
              valueStyle: const TextStyle(fontSize: 14),
            ),
            InfoRowWidget(
              label: 'Đơn giá:',
              value: CurrencyFormatter.formatVNDWithUnit(item.unitPrice),
              labelWidth: 120,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontSize: 14,
              ),
              valueStyle: const TextStyle(fontSize: 14),
            ),
            InfoRowWidget(
              label: 'Thành tiền:',
              value: CurrencyFormatter.formatVNDWithUnit(item.totalPrice),
              labelWidth: 120,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontSize: 14,
              ),
              valueStyle: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
