import 'package:flutter/material.dart';
import '../../domain/entities/warehouse_receipt.dart';
import '../../domain/entities/material_item.dart';
import '../../core/utils/currency_formatter.dart';
import '../widgets/general_info_section.dart';
import '../widgets/material_section_card.dart';
import '../widgets/form_actions.dart';
import '../../data/services/firebase_service.dart';

class WarehouseReceiptForm extends StatefulWidget {
  const WarehouseReceiptForm({super.key});

  @override
  State<WarehouseReceiptForm> createState() => _WarehouseReceiptFormState();
}

class _WarehouseReceiptFormState extends State<WarehouseReceiptForm> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _isLoading = false;

  // Controllers cho các trường thông tin chung
  final _approvedByController = TextEditingController();
  final _createdByController = TextEditingController();
  final _creditAccountController = TextEditingController();
  final _dateController = TextEditingController();
  final _debitAccountController = TextEditingController();
  final _deliveredByController = TextEditingController();
  final _departmentController = TextEditingController();
  final _numberController = TextEditingController();
  final _originalDocumentCountController = TextEditingController();
  final _receivedByController = TextEditingController();
  final _referenceDateController = TextEditingController();
  final _referenceNumberController = TextEditingController();
  final _referenceOrganizationController = TextEditingController();
  final _referenceTypeController = TextEditingController();
  final _storeKeeperController = TextEditingController();
  final _totalAmountTextController = TextEditingController();
  final _unitController = TextEditingController();

  // Danh sách vật tư
  final List<MaterialItem> _materialItemsList = [];

  // Controllers tạm cho dòng vật tư mới
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _itemUnitController = TextEditingController();
  final _quantityDocumentController = TextEditingController();
  final _quantityReceivedController = TextEditingController();
  final _unitPriceController = TextEditingController();

  double get _totalAmount => _materialItemsList.fold(0, (sum, item) => sum + item.totalPrice);

  void _addMaterial() {
    // Kiểm tra các trường vật tư có đầy đủ không
    if (_codeController.text.trim().isEmpty ||
        _nameController.text.trim().isEmpty ||
        _itemUnitController.text.trim().isEmpty ||
        _quantityDocumentController.text.trim().isEmpty ||
        _quantityReceivedController.text.trim().isEmpty ||
        _unitPriceController.text.trim().isEmpty) {
      // Hiển thị thông báo lỗi
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng điền đầy đủ thông tin vật tư'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    final quantityDocument = int.tryParse(_quantityDocumentController.text);
    final quantityReceived = int.tryParse(_quantityReceivedController.text);
    final unitPrice = double.tryParse(_unitPriceController.text);

    // Kiểm tra giá trị số hợp lệ
    if (quantityDocument == null || quantityDocument <= 0) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Số lượng theo chứng từ phải là số dương'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    if (quantityReceived == null || quantityReceived <= 0) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Số lượng thực nhận phải là số dương'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    if (unitPrice == null || unitPrice <= 0) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đơn giá phải là số dương'), backgroundColor: Colors.red),
        );
      }
      return;
    }

    final totalPrice = quantityReceived * unitPrice;
    final itemName = _nameController.text.trim();

    setState(() {
      _materialItemsList.add(
        MaterialItem(
          code: _codeController.text.trim(),
          name: itemName,
          unit: _itemUnitController.text.trim(),
          quantityDocument: quantityDocument,
          quantityReceived: quantityReceived,
          unitPrice: unitPrice,
          totalPrice: totalPrice,
          index: _materialItemsList.length + 1,
        ),
      );
    });

    // Hiển thị thông báo thành công
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã thêm vật tư: $itemName\nCác trường đã được giữ nguyên để thêm tiếp'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _deleteMaterial(int index) {
    setState(() {
      _materialItemsList.removeAt(index);
      // Cập nhật lại index bằng cách tạo object mới
      for (int i = 0; i < _materialItemsList.length; i++) {
        final oldItem = _materialItemsList[i];
        _materialItemsList[i] = oldItem.copyWith(index: i + 1);
      }
    });
  }

  void _clearMaterialFields() {
    setState(() {
      _codeController.clear();
      _nameController.clear();
      _itemUnitController.clear();
      _quantityDocumentController.clear();
      _quantityReceivedController.clear();
      _unitPriceController.clear();
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã xóa trắng các trường vật tư\nSử dụng nút này khi muốn nhập vật tư mới'),
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _saveReceipt() async {
    // Bật autovalidate mode để hiển thị tất cả lỗi
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
      _isLoading = true;
    });

    // Kiểm tra form validation
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng điền đầy đủ thông tin bắt buộc'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    // Kiểm tra có vật tư nào không
    if (_materialItemsList.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng thêm ít nhất một vật tư'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    try {
      // Tạo đối tượng phiếu nhập kho
      final receipt = WarehouseReceipt(
        approvedBy: _approvedByController.text,
        createdBy: _createdByController.text,
        creditAccount: _creditAccountController.text,
        date: DateTime.tryParse(_dateController.text) ?? DateTime.now(),
        debitAccount: _debitAccountController.text,
        deliveredBy: _deliveredByController.text,
        department: _departmentController.text,
        number: _numberController.text,
        originalDocumentCount: int.tryParse(_originalDocumentCountController.text) ?? 0,
        receivedBy: _receivedByController.text,
        referenceDate: DateTime.tryParse(_referenceDateController.text) ?? DateTime.now(),
        referenceNumber: _referenceNumberController.text,
        referenceOrganization: _referenceOrganizationController.text,
        referenceType: _referenceTypeController.text,
        storeKeeper: _storeKeeperController.text,
        totalAmount: _totalAmount,
        totalAmountText: _totalAmountTextController.text,
        unit: _unitController.text,
        createdAt: DateTime.now(),
      );

      // Lưu vào Firebase
      String documentId = await FirebaseService.addWarehouseReceipt(receipt, _materialItemsList);

      setState(() {
        _isLoading = false;
      });

      // Hiển thị thông báo thành công
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Thành công!'),
              content: Text(
                'Đã lưu phiếu nhập kho với ID: $documentId\nTổng số tiền: ${CurrencyFormatter.formatVNDWithUnit(receipt.totalAmount)}',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _resetForm();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      // Hiển thị thông báo lỗi
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Lỗi!'),
              content: Text('Không thể lưu phiếu nhập kho: $e'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  void _resetForm() {
    _approvedByController.clear();
    _createdByController.clear();
    _creditAccountController.clear();
    _dateController.clear();
    _debitAccountController.clear();
    _deliveredByController.clear();
    _departmentController.clear();
    _numberController.clear();
    _originalDocumentCountController.clear();
    _receivedByController.clear();
    _referenceDateController.clear();
    _referenceNumberController.clear();
    _referenceOrganizationController.clear();
    _referenceTypeController.clear();
    _storeKeeperController.clear();
    _totalAmountTextController.clear();
    _unitController.clear();
    _codeController.clear();
    _nameController.clear();
    _itemUnitController.clear();
    _quantityDocumentController.clear();
    _quantityReceivedController.clear();
    _unitPriceController.clear();
    setState(() {
      _materialItemsList.clear();
    });
    _formKey.currentState?.reset();
  }

  @override
  void dispose() {
    _approvedByController.dispose();
    _createdByController.dispose();
    _creditAccountController.dispose();
    _dateController.dispose();
    _debitAccountController.dispose();
    _deliveredByController.dispose();
    _departmentController.dispose();
    _numberController.dispose();
    _originalDocumentCountController.dispose();
    _receivedByController.dispose();
    _referenceDateController.dispose();
    _referenceNumberController.dispose();
    _referenceOrganizationController.dispose();
    _referenceTypeController.dispose();
    _storeKeeperController.dispose();
    _totalAmountTextController.dispose();
    _unitController.dispose();
    _codeController.dispose();
    _nameController.dispose();
    _itemUnitController.dispose();
    _quantityDocumentController.dispose();
    _quantityReceivedController.dispose();
    _unitPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phiếu nhập kho',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Phần thông tin chung
              GeneralInfoSection(
                unitController: _unitController,
                departmentController: _departmentController,
                dateController: _dateController,
                numberController: _numberController,
                debitAccountController: _debitAccountController,
                creditAccountController: _creditAccountController,
                deliveredByController: _deliveredByController,
                receivedByController: _receivedByController,
                storeKeeperController: _storeKeeperController,
                referenceNumberController: _referenceNumberController,
                referenceDateController: _referenceDateController,
                referenceOrganizationController: _referenceOrganizationController,
                referenceTypeController: _referenceTypeController,
                originalDocumentCountController: _originalDocumentCountController,
                createdByController: _createdByController,
                approvedByController: _approvedByController,
              ),
              const SizedBox(height: 20),
              // Phần vật tư
              MaterialSectionCard(
                codeController: _codeController,
                nameController: _nameController,
                itemUnitController: _itemUnitController,
                quantityDocumentController: _quantityDocumentController,
                quantityReceivedController: _quantityReceivedController,
                unitPriceController: _unitPriceController,
                totalAmountTextController: _totalAmountTextController,
                materials: _materialItemsList,
                totalAmount: _totalAmount,
                onAddMaterial: _addMaterial,
                onClearFields: _clearMaterialFields,
                onDeleteMaterial: _deleteMaterial,
              ),
              // Các nút hành động
              FormActions(onSave: _saveReceipt, onReset: _resetForm, isLoading: _isLoading),
            ],
          ),
        ),
      ),
    );
  }
}
