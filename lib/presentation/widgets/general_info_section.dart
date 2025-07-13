import 'package:flutter/material.dart';
import 'required_text_field.dart';
import 'required_date_field.dart';

class GeneralInfoSection extends StatelessWidget {
  final TextEditingController unitController;
  final TextEditingController departmentController;
  final TextEditingController dateController;
  final TextEditingController numberController;
  final TextEditingController debitAccountController;
  final TextEditingController creditAccountController;
  final TextEditingController deliveredByController;
  final TextEditingController receivedByController;
  final TextEditingController storeKeeperController;
  final TextEditingController referenceNumberController;
  final TextEditingController referenceDateController;
  final TextEditingController referenceOrganizationController;
  final TextEditingController referenceTypeController;
  final TextEditingController originalDocumentCountController;
  final TextEditingController createdByController;
  final TextEditingController approvedByController;

  const GeneralInfoSection({
    super.key,
    required this.unitController,
    required this.departmentController,
    required this.dateController,
    required this.numberController,
    required this.debitAccountController,
    required this.creditAccountController,
    required this.deliveredByController,
    required this.receivedByController,
    required this.storeKeeperController,
    required this.referenceNumberController,
    required this.referenceDateController,
    required this.referenceOrganizationController,
    required this.referenceTypeController,
    required this.originalDocumentCountController,
    required this.createdByController,
    required this.approvedByController,
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
            const Text(
              'Thông tin chung',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: RequiredTextField(controller: unitController, label: 'Đơn vị')),
                const SizedBox(width: 12),
                Expanded(
                  child: RequiredTextField(controller: departmentController, label: 'Phòng ban'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: RequiredDateField(controller: dateController, label: 'Ngày nhập kho'),
                ),
                const SizedBox(width: 12),
                Expanded(child: RequiredTextField(controller: numberController, label: 'Số phiếu')),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: RequiredTextField(
                    controller: debitAccountController,
                    label: 'Tài khoản Nợ',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: RequiredTextField(
                    controller: creditAccountController,
                    label: 'Tài khoản Có',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            RequiredTextField(controller: deliveredByController, label: 'Người giao hàng'),
            const SizedBox(height: 12),
            RequiredTextField(controller: receivedByController, label: 'Người nhận hàng'),
            const SizedBox(height: 12),
            RequiredTextField(controller: storeKeeperController, label: 'Thủ kho'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: RequiredTextField(
                    controller: referenceNumberController,
                    label: 'Số chứng từ gốc',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: RequiredDateField(
                    controller: referenceDateController,
                    label: 'Ngày chứng từ gốc',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            RequiredTextField(
              controller: referenceOrganizationController,
              label: 'Tổ chức tham chiếu',
            ),
            const SizedBox(height: 12),
            RequiredTextField(controller: referenceTypeController, label: 'Loại tham chiếu'),
            const SizedBox(height: 12),
            RequiredTextField(
              controller: originalDocumentCountController,
              label: 'Số lượng chứng từ gốc',
              isNumber: true,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: RequiredTextField(controller: createdByController, label: 'Người tạo'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: RequiredTextField(
                    controller: approvedByController,
                    label: 'Người phê duyệt',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
