# Vimes Warehouse Receipts App

Ứng dụng Flutter quản lý phiếu nhập kho, kết nối Firebase Firestore.

## Tính năng chính

- Tạo, xem, tìm kiếm, xóa phiếu nhập kho
- Thêm/xóa vật tư cho từng phiếu
- Lưu trữ dữ liệu trên Firestore
- Giao diện đẹp, dễ sử dụng
- **Toàn bộ code đã chuyển sang tiếng Anh (biến, hàm, file, class)**
- **Hiển thị số tiền VND với dấu chấm ngăn cách 3 số (ví dụ: 1.234.567 VNĐ)**

## Cấu trúc thư mục

```
lib/
  models/warehouse_receipt.dart         # Data models: WarehouseReceipt, MaterialItem
  services/firebase_service.dart        # Firebase CRUD
  screens/warehouse_receipt_form_screen.dart   # Form tạo phiếu
  screens/warehouse_receipt_list_screen.dart   # Danh sách phiếu
  screens/warehouse_receipt_detail_screen.dart # Chi tiết phiếu
  widgets/                             # Các widget con (GeneralInfoSection, MaterialListSection, ...)
  utils/currency_formatter.dart        # Format số tiền VND
```

## Format số tiền VND

- Sử dụng util `CurrencyFormatter` để hiển thị số tiền đúng chuẩn Việt Nam:

```dart
import 'utils/currency_formatter.dart';

final amount = 1234567.0;
print(CurrencyFormatter.formatVND(amount)); // 1.234.567
print(CurrencyFormatter.formatVNDWithUnit(amount)); // 1.234.567 VNĐ
```

- Tất cả các nơi hiển thị tiền trong app đều đã sử dụng format này.

## Hướng dẫn chạy

1. Cài đặt Flutter, clone repo, chạy `flutter pub get`
2. Thêm file cấu hình Firebase (`google-services.json` cho Android, `GoogleService-Info.plist` cho iOS)
3. Chạy app: `flutter run`

## Đóng góp

PR, issue, góp ý đều được chào đón!

---

**Vimes App - Quản lý phiếu nhập kho chuyên nghiệp, hiện đại, dễ sử dụng.**
