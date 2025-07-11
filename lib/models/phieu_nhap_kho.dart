class ChiTietVatTu {
  String ten;
  String ma;
  int soLuong;
  double donGia;
  double thanhTien;

  ChiTietVatTu({
    required this.ten,
    required this.ma,
    required this.soLuong,
    required this.donGia,
  }) : thanhTien = soLuong * donGia;
}

class PhieuNhapKho {
  String donVi;
  String boPhan;
  DateTime ngay;
  String so;
  String no;
  String co;
  String hoTenNguoiGiao;
  String soChungTu;
  DateTime ngayChungTu;
  String diaDiem;
  List<ChiTietVatTu> chiTietVatTu;
  double tongSoTien;
  String soChungTuGocKem;

  PhieuNhapKho({
    required this.donVi,
    required this.boPhan,
    required this.ngay,
    required this.so,
    required this.no,
    required this.co,
    required this.hoTenNguoiGiao,
    required this.soChungTu,
    required this.ngayChungTu,
    required this.diaDiem,
    required this.chiTietVatTu,
    required this.tongSoTien,
    required this.soChungTuGocKem,
  });
}
