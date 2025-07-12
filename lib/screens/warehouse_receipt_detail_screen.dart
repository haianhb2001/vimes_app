import 'package:flutter/material.dart';
import '../models/warehouse_receipt.dart';
import '../services/firebase_service.dart';
import '../utils/currency_formatter.dart';
import '../widgets/info_row_widget.dart';
import '../widgets/material_detail_card.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_state_widget.dart';

class WarehouseReceiptDetailScreen extends StatelessWidget {
  final WarehouseReceipt receipt;

  const WarehouseReceiptDetailScreen({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết phiếu ${receipt.number}',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        elevation: 2,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thông tin chung
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Thông tin chung',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 16),
                    InfoRowWidget(label: 'Số phiếu:', value: receipt.number),
                    InfoRowWidget(label: 'Đơn vị:', value: receipt.unit),
                    InfoRowWidget(label: 'Phòng ban:', value: receipt.department),
                    InfoRowWidget(label: 'Ngày nhập kho:', value: _formatDate(receipt.date)),
                    InfoRowWidget(label: 'Tài khoản Nợ:', value: receipt.debitAccount),
                    InfoRowWidget(label: 'Tài khoản Có:', value: receipt.creditAccount),
                    InfoRowWidget(label: 'Người giao hàng:', value: receipt.deliveredBy),
                    InfoRowWidget(label: 'Người nhận hàng:', value: receipt.receivedBy),
                    InfoRowWidget(label: 'Thủ kho:', value: receipt.storeKeeper),
                    InfoRowWidget(label: 'Số chứng từ gốc:', value: receipt.referenceNumber),
                    InfoRowWidget(
                      label: 'Ngày chứng từ gốc:',
                      value: _formatDate(receipt.referenceDate),
                    ),
                    InfoRowWidget(
                      label: 'Tổ chức tham chiếu:',
                      value: receipt.referenceOrganization,
                    ),
                    InfoRowWidget(label: 'Loại tham chiếu:', value: receipt.referenceType),
                    InfoRowWidget(
                      label: 'Số lượng chứng từ gốc:',
                      value: receipt.originalDocumentCount.toString(),
                    ),
                    InfoRowWidget(label: 'Người tạo:', value: receipt.createdBy),
                    InfoRowWidget(label: 'Người phê duyệt:', value: receipt.approvedBy),
                    InfoRowWidget(
                      label: 'Tổng số tiền:',
                      value: CurrencyFormatter.formatVNDWithUnit(receipt.totalAmount),
                    ),
                    InfoRowWidget(label: 'Số tiền bằng chữ:', value: receipt.totalAmountText),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Danh sách vật tư
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Danh sách vật tư',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 16),
                    StreamBuilder<List<MaterialItem>>(
                      stream: FirebaseService.getItemsByReceiptId(receipt.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return ErrorStateWidget(errorMessage: snapshot.error.toString());
                        }

                        final items = snapshot.data ?? [];

                        if (items.isEmpty) {
                          return const EmptyStateWidget(
                            icon: Icons.inbox_outlined,
                            message: 'Chưa có vật tư nào',
                          );
                        }

                        return Column(
                          children: items.map((item) => MaterialDetailCard(item: item)).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
