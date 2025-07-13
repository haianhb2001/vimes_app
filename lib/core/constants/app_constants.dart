class AppConstants {
  // App Info
  static const String appName = 'VY Warehouse';
  static const String appVersion = '1.0.0';

  // Firebase Collections
  static const String warehouseReceiptsCollection = 'warehouse_receipts';
  static const String itemsSubcollection = 'items';

  // Validation Messages
  static const String requiredFieldMessage = 'Trường này là bắt buộc';
  static const String invalidNumberMessage = 'Số không hợp lệ';
  static const String invalidDateMessage = 'Ngày không hợp lệ';

  // Error Messages
  static const String generalErrorMessage = 'Đã xảy ra lỗi. Vui lòng thử lại.';
  static const String networkErrorMessage = 'Lỗi kết nối mạng. Vui lòng kiểm tra kết nối.';
  static const String firebaseErrorMessage = 'Lỗi Firebase. Vui lòng thử lại.';

  // Success Messages
  static const String saveSuccessMessage = 'Lưu thành công';
  static const String deleteSuccessMessage = 'Xóa thành công';
  static const String updateSuccessMessage = 'Cập nhật thành công';
}
