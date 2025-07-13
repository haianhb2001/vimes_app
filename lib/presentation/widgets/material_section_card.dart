import 'package:flutter/material.dart';
import '../../domain/entities/material_item.dart';
import 'material_input_section.dart';
import 'material_list_section.dart';

class MaterialSectionCard extends StatelessWidget {
  final TextEditingController codeController;
  final TextEditingController nameController;
  final TextEditingController itemUnitController;
  final TextEditingController quantityDocumentController;
  final TextEditingController quantityReceivedController;
  final TextEditingController unitPriceController;
  final TextEditingController totalAmountTextController;
  final List<MaterialItem> materials;
  final double totalAmount;
  final VoidCallback onAddMaterial;
  final VoidCallback onClearFields;
  final Function(int) onDeleteMaterial;

  const MaterialSectionCard({
    super.key,
    required this.codeController,
    required this.nameController,
    required this.itemUnitController,
    required this.quantityDocumentController,
    required this.quantityReceivedController,
    required this.unitPriceController,
    required this.totalAmountTextController,
    required this.materials,
    required this.totalAmount,
    required this.onAddMaterial,
    required this.onClearFields,
    required this.onDeleteMaterial,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialInputSection(
              codeController: codeController,
              nameController: nameController,
              itemUnitController: itemUnitController,
              quantityDocumentController: quantityDocumentController,
              quantityReceivedController: quantityReceivedController,
              unitPriceController: unitPriceController,
              onAddMaterial: onAddMaterial,
              onClearFields: onClearFields,
            ),
            MaterialListSection(
              materials: materials,
              totalAmount: totalAmount,
              totalAmountTextController: totalAmountTextController,
              onDeleteMaterial: onDeleteMaterial,
            ),
          ],
        ),
      ),
    );
  }
}
