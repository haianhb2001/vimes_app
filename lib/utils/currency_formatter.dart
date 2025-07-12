class CurrencyFormatter {
  /// Format số tiền VND với dấu chấm ngăn cách 3 số
  /// Ví dụ: 1234567 -> 1.234.567
  static String formatVND(double amount) {
    // Chuyển thành số nguyên để tránh vấn đề với số thập phân
    int intAmount = amount.round();

    // Chuyển thành string và thêm dấu chấm ngăn cách
    String amountStr = intAmount.toString();

    // Thêm dấu chấm từ phải sang trái, mỗi 3 số
    String result = '';
    for (int i = 0; i < amountStr.length; i++) {
      if (i > 0 && (amountStr.length - i) % 3 == 0) {
        result += '.';
      }
      result += amountStr[i];
    }

    return result;
  }

  /// Format số tiền VND với đơn vị VNĐ
  /// Ví dụ: 1234567 -> 1.234.567 VNĐ
  static String formatVNDWithUnit(double amount) {
    return '${formatVND(amount)} VNĐ';
  }
}
