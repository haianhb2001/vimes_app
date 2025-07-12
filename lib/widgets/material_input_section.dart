import 'package:flutter/material.dart';
import 'required_text_field.dart';

class MaterialInputSection extends StatelessWidget {
  final TextEditingController codeController;
  final TextEditingController nameController;
  final TextEditingController itemUnitController;
  final TextEditingController quantityDocumentController;
  final TextEditingController quantityReceivedController;
  final TextEditingController unitPriceController;
  final VoidCallback onAddMaterial;
  final VoidCallback onClearFields;

  const MaterialInputSection({
    super.key,
    required this.codeController,
    required this.nameController,
    required this.itemUnitController,
    required this.quantityDocumentController,
    required this.quantityReceivedController,
    required this.unitPriceController,
    required this.onAddMaterial,
    required this.onClearFields,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RequiredTextField(controller: codeController, label: 'Mã vật tư'),
        const SizedBox(height: 8),
        RequiredTextField(controller: nameController, label: 'Tên vật tư'),
        const SizedBox(height: 8),
        RequiredTextField(controller: itemUnitController, label: 'Đơn vị'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: RequiredTextField(
                controller: quantityDocumentController,
                label: 'SL theo chứng từ',
                isNumber: true,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: RequiredTextField(
                controller: quantityReceivedController,
                label: 'SL thực nhận',
                isNumber: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        RequiredTextField(controller: unitPriceController, label: 'Đơn giá', isNumber: true),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onAddMaterial,
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('Thêm vật tư', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onClearFields,
                icon: const Icon(Icons.clear, color: Colors.white),
                label: const Text('Xóa trắng', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(),
      ],
    );
  }
}
