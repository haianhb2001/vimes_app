import 'package:flutter_test/flutter_test.dart';
import 'package:vimes_app/core/utils/currency_formatter.dart';

void main() {
  group('CurrencyFormatter Tests', () {
    test('formatVND should format positive numbers correctly', () {
      expect(CurrencyFormatter.formatVND(1234567), '1.234.567');
      expect(CurrencyFormatter.formatVND(1000000), '1.000.000');
      expect(CurrencyFormatter.formatVND(1234), '1.234');
      expect(CurrencyFormatter.formatVND(100), '100');
    });

    test('formatVND should format zero correctly', () {
      expect(CurrencyFormatter.formatVND(0), '0');
    });

    test('formatVND should format negative numbers correctly', () {
      expect(CurrencyFormatter.formatVND(-1234567), '-1.234.567');
      expect(CurrencyFormatter.formatVND(-1000000), '-1.000.000');
    });

    test('formatVND should format decimal numbers correctly', () {
      expect(CurrencyFormatter.formatVND(1234567.89), '1.234.567');
      expect(CurrencyFormatter.formatVND(1000000.5), '1.000.000');
    });

    test('formatVNDWithUnit should add VNĐ unit', () {
      expect(CurrencyFormatter.formatVNDWithUnit(1234567), '1.234.567 VNĐ');
      expect(CurrencyFormatter.formatVNDWithUnit(1000000), '1.000.000 VNĐ');
      expect(CurrencyFormatter.formatVNDWithUnit(0), '0 VNĐ');
      expect(CurrencyFormatter.formatVNDWithUnit(-1234567), '-1.234.567 VNĐ');
    });

    test('formatVND should handle large numbers', () {
      expect(CurrencyFormatter.formatVND(999999999), '999.999.999');
      expect(CurrencyFormatter.formatVND(1000000000), '1.000.000.000');
    });

    test('formatVND should handle small numbers', () {
      expect(CurrencyFormatter.formatVND(1), '1');
      expect(CurrencyFormatter.formatVND(10), '10');
      expect(CurrencyFormatter.formatVND(100), '100');
    });
  });
}
