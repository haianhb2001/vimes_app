import 'package:flutter/material.dart';
import '../models/warehouse_receipt.dart';
import '../utils/currency_formatter.dart';
import 'required_text_field.dart';

class MaterialListSection extends StatelessWidget {
  final List<MaterialItem> materials;
  final double totalAmount;
  final TextEditingController totalAmountTextController;
  final Function(int) onDeleteMaterial;

  const MaterialListSection({
    super.key,
    required this.materials,
    required this.totalAmount,
    required this.totalAmountTextController,
    required this.onDeleteMaterial,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Danh sách vật tư',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: materials.length,
          itemBuilder: (context, index) {
            final item = materials[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              color: Colors.indigo[50],
              child: ListTile(
                title: Text(
                  '${item.name} (${item.code})',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SL: ${item.quantityReceived}/${item.quantityDocument} ${item.unit}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Đơn giá: ${CurrencyFormatter.formatVNDWithUnit(item.unitPrice)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Thành tiền: ${CurrencyFormatter.formatVNDWithUnit(item.totalPrice)}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDeleteMaterial(index),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Tổng số tiền: ${CurrencyFormatter.formatVNDWithUnit(totalAmount)}',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
        ),
        const SizedBox(height: 12),
        RequiredTextField(controller: totalAmountTextController, label: 'Số tiền bằng chữ'),
      ],
    );
  }
}
