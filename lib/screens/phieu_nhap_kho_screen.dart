import 'package:flutter/material.dart';
import '../models/phieu_nhap_kho.dart';
import '../widgets/required_text_field.dart';
import '../widgets/required_date_field.dart';

class PhieuNhapKhoForm extends StatefulWidget {
  const PhieuNhapKhoForm({Key? key}) : super(key: key);

  @override
  State<PhieuNhapKhoForm> createState() => _PhieuNhapKhoFormState();
}

class _PhieuNhapKhoFormState extends State<PhieuNhapKhoForm> {
  final _formKey = GlobalKey<FormState>();
  // Controllers cho các trường thông tin chung
  final _donViController = TextEditingController();
  final _boPhanController = TextEditingController();
  final _ngayController = TextEditingController();
  final _soController = TextEditingController();
  final _noController = TextEditingController();
  final _coController = TextEditingController();
  final _hoTenNguoiGiaoController = TextEditingController();
  final _soChungTuController = TextEditingController();
  final _ngayChungTuController = TextEditingController();
  final _diaDiemController = TextEditingController();
  final _soChungTuGocKemController = TextEditingController();

  // Danh sách vật tư
  List<ChiTietVatTu> _chiTietVatTuList = [];

  // Controllers tạm cho dòng vật tư mới
  final _tenVatTuController = TextEditingController();
  final _maVatTuController = TextEditingController();
  final _soLuongController = TextEditingController();
  final _donGiaController = TextEditingController();

  double get _tongSoTien =>
      _chiTietVatTuList.fold(0, (sum, item) => sum + item.thanhTien);

  void _themVatTu() {
    if (_tenVatTuController.text.isEmpty ||
        _maVatTuController.text.isEmpty ||
        _soLuongController.text.isEmpty ||
        _donGiaController.text.isEmpty)
      return;

    setState(() {
      _chiTietVatTuList.add(
        ChiTietVatTu(
          ten: _tenVatTuController.text,
          ma: _maVatTuController.text,
          soLuong: int.tryParse(_soLuongController.text) ?? 0,
          donGia: double.tryParse(_donGiaController.text) ?? 0,
        ),
      );
      _tenVatTuController.clear();
      _maVatTuController.clear();
      _soLuongController.clear();
      _donGiaController.clear();
    });
  }

  void _xoaVatTu(int index) {
    setState(() {
      _chiTietVatTuList.removeAt(index);
    });
  }

  void _luuPhieu() {
    if (!_formKey.currentState!.validate()) {
      // Nếu form không hợp lệ thì không lưu
      return;
    }
    // Tạo đối tượng phiếu nhập kho
    final phieu = PhieuNhapKho(
      donVi: _donViController.text,
      boPhan: _boPhanController.text,
      ngay: DateTime.tryParse(_ngayController.text) ?? DateTime.now(),
      so: _soController.text,
      no: _noController.text,
      co: _coController.text,
      hoTenNguoiGiao: _hoTenNguoiGiaoController.text,
      soChungTu: _soChungTuController.text,
      ngayChungTu:
          DateTime.tryParse(_ngayChungTuController.text) ?? DateTime.now(),
      diaDiem: _diaDiemController.text,
      chiTietVatTu: _chiTietVatTuList,
      tongSoTien: _tongSoTien,
      soChungTuGocKem: _soChungTuGocKemController.text,
    );

    // TODO: Lưu phieu vào database hoặc xử lý tiếp
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Đã lưu phiếu nhập kho!'),
            content: Text('Tổng số tiền:  {phieu.tongSoTien}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _resetForm();
                },
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  void _resetForm() {
    _donViController.clear();
    _boPhanController.clear();
    _ngayController.clear();
    _soController.clear();
    _noController.clear();
    _coController.clear();
    _hoTenNguoiGiaoController.clear();
    _soChungTuController.clear();
    _ngayChungTuController.clear();
    _diaDiemController.clear();
    _soChungTuGocKemController.clear();
    _tenVatTuController.clear();
    _maVatTuController.clear();
    _soLuongController.clear();
    _donGiaController.clear();
    setState(() {
      _chiTietVatTuList.clear();
    });
    _formKey.currentState?.reset();
  }

  @override
  void dispose() {
    _donViController.dispose();
    _boPhanController.dispose();
    _ngayController.dispose();
    _soController.dispose();
    _noController.dispose();
    _coController.dispose();
    _hoTenNguoiGiaoController.dispose();
    _soChungTuController.dispose();
    _ngayChungTuController.dispose();
    _diaDiemController.dispose();
    _soChungTuGocKemController.dispose();
    _tenVatTuController.dispose();
    _maVatTuController.dispose();
    _soLuongController.dispose();
    _donGiaController.dispose();
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
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
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: RequiredTextField(
                              controller: _donViController,
                              label: 'Đơn vị',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RequiredTextField(
                              controller: _boPhanController,
                              label: 'Bộ phận',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: RequiredDateField(
                              controller: _ngayController,
                              label: 'Ngày nhập kho',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RequiredTextField(
                              controller: _soController,
                              label: 'Số',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: RequiredTextField(
                              controller: _noController,
                              label: 'Nợ',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RequiredTextField(
                              controller: _coController,
                              label: 'Có',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      RequiredTextField(
                        controller: _hoTenNguoiGiaoController,
                        label: 'Họ tên người giao',
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: RequiredTextField(
                              controller: _soChungTuController,
                              label: 'Số chứng từ',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RequiredDateField(
                              controller: _ngayChungTuController,
                              label: 'Ngày chứng từ',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      RequiredTextField(
                        controller: _diaDiemController,
                        label: 'Địa điểm',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
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
                      const SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RequiredTextField(
                            controller: _tenVatTuController,
                            label: 'Tên vật tư',
                          ),
                          const SizedBox(height: 8),
                          RequiredTextField(
                            controller: _maVatTuController,
                            label: 'Mã',
                          ),
                          const SizedBox(height: 8),
                          RequiredTextField(
                            controller: _soLuongController,
                            label: 'Số lượng',
                            isNumber: true,
                          ),
                          const SizedBox(height: 8),
                          RequiredTextField(
                            controller: _donGiaController,
                            label: 'Đơn giá',
                            isNumber: true,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _themVatTu,
                              icon: const Icon(Icons.add),
                              label: const Text('Thêm vật tư'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Divider(),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _chiTietVatTuList.length,
                        itemBuilder: (context, index) {
                          final item = _chiTietVatTuList[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            color: Colors.indigo[50],
                            child: ListTile(
                              title: Text(
                                '${item.ten} (${item.ma})',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'SL: ${item.soLuong}, Đơn giá: ${item.donGia}, Thành tiền: ${item.thanhTien}',
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _xoaVatTu(index),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Tổng số tiền: $_tongSoTien',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequiredTextField(
                        controller: _soChungTuGocKemController,
                        label: 'Số chứng từ gốc kèm theo',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _luuPhieu,
                icon: const Icon(Icons.save),
                label: const Text('Lưu phiếu nhập kho'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
