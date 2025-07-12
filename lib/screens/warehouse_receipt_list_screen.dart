import 'package:flutter/material.dart';
import '../models/warehouse_receipt.dart';
import '../services/firebase_service.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/receipt_list_item.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_state_widget.dart';
import 'warehouse_receipt_form_screen.dart';
import 'warehouse_receipt_detail_screen.dart';

class WarehouseReceiptListScreen extends StatefulWidget {
  const WarehouseReceiptListScreen({super.key});

  @override
  State<WarehouseReceiptListScreen> createState() => _WarehouseReceiptListScreenState();
}

class _WarehouseReceiptListScreenState extends State<WarehouseReceiptListScreen> {
  String _searchKeyword = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh sách phiếu nhập kho',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WarehouseReceiptForm()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          SearchBarWidget(
            hintText: 'Tìm kiếm theo số phiếu...',
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchKeyword = value;
              });
            },
          ),
          // List
          Expanded(
            child: StreamBuilder<List<WarehouseReceipt>>(
              stream:
                  _searchKeyword.trim().isEmpty
                      ? FirebaseService.getWarehouseReceiptList()
                      : FirebaseService.searchWarehouseReceipt(_searchKeyword.trim()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return ErrorStateWidget(errorMessage: snapshot.error.toString());
                }

                final receiptList = snapshot.data ?? [];

                if (receiptList.isEmpty) {
                  return const EmptyStateWidget(
                    icon: Icons.inbox_outlined,
                    message: 'Chưa có phiếu nhập kho nào',
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: receiptList.length,
                  itemBuilder: (context, index) {
                    final receipt = receiptList[index];
                    return ReceiptListItem(
                      receipt: receipt,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WarehouseReceiptDetailScreen(receipt: receipt),
                          ),
                        );
                      },
                      onDelete: () => _showDeleteDialog(receipt),
                      formatDate: _formatDate,
                      formatDateTime: _formatDateTime,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WarehouseReceiptForm()),
          );
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _formatDateTime(DateTime dateTime) {
    return '${_formatDate(dateTime)} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _showDeleteDialog(WarehouseReceipt receipt) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Xác nhận xóa'),
            content: Text('Bạn có chắc chắn muốn xóa phiếu nhập kho số "${receipt.number}"?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  try {
                    await FirebaseService.deleteWarehouseReceipt(receipt.id!);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Đã xóa phiếu nhập kho thành công'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Lỗi khi xóa: $e'), backgroundColor: Colors.red),
                    );
                  }
                },
                child: const Text('Xóa', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }
}
