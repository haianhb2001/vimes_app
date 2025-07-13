import 'package:flutter_test/flutter_test.dart';
import 'package:vimes_app/domain/entities/warehouse_receipt.dart';

void main() {
  group('WarehouseReceipt Entity Tests', () {
    final testDate = DateTime(2024, 1, 15);
    final testReferenceDate = DateTime(2024, 1, 10);
    final testCreatedAt = DateTime(2024, 1, 15, 10, 30);

    test('should create WarehouseReceipt with all required fields', () {
      final receipt = WarehouseReceipt(
        id: 'receipt1',
        approvedBy: 'Nguyễn Văn A',
        createdBy: 'Trần Thị B',
        creditAccount: '331',
        date: testDate,
        debitAccount: '156',
        deliveredBy: 'Công ty ABC',
        department: 'Kho',
        number: 'NK001',
        originalDocumentCount: 2,
        receivedBy: 'Lê Văn C',
        referenceDate: testReferenceDate,
        referenceNumber: 'HD001',
        referenceOrganization: 'Công ty ABC',
        referenceType: 'Hóa đơn',
        storeKeeper: 'Phạm Thị D',
        totalAmount: 1500000.0,
        totalAmountText: 'Một triệu năm trăm nghìn đồng',
        unit: 'Công ty XYZ',
        createdAt: testCreatedAt,
      );

      expect(receipt.id, 'receipt1');
      expect(receipt.approvedBy, 'Nguyễn Văn A');
      expect(receipt.createdBy, 'Trần Thị B');
      expect(receipt.creditAccount, '331');
      expect(receipt.debitAccount, '156');
      expect(receipt.deliveredBy, 'Công ty ABC');
      expect(receipt.department, 'Kho');
      expect(receipt.number, 'NK001');
      expect(receipt.originalDocumentCount, 2);
      expect(receipt.receivedBy, 'Lê Văn C');
      expect(receipt.referenceNumber, 'HD001');
      expect(receipt.referenceOrganization, 'Công ty ABC');
      expect(receipt.referenceType, 'Hóa đơn');
      expect(receipt.storeKeeper, 'Phạm Thị D');
      expect(receipt.totalAmount, 1500000.0);
      expect(receipt.totalAmountText, 'Một triệu năm trăm nghìn đồng');
      expect(receipt.unit, 'Công ty XYZ');
    });

    test('should create WarehouseReceipt without id', () {
      final receipt = WarehouseReceipt(
        approvedBy: 'Nguyễn Văn A',
        createdBy: 'Trần Thị B',
        creditAccount: '331',
        date: testDate,
        debitAccount: '156',
        deliveredBy: 'Công ty ABC',
        department: 'Kho',
        number: 'NK001',
        originalDocumentCount: 2,
        receivedBy: 'Lê Văn C',
        referenceDate: testReferenceDate,
        referenceNumber: 'HD001',
        referenceOrganization: 'Công ty ABC',
        referenceType: 'Hóa đơn',
        storeKeeper: 'Phạm Thị D',
        totalAmount: 1500000.0,
        totalAmountText: 'Một triệu năm trăm nghìn đồng',
        unit: 'Công ty XYZ',
        createdAt: testCreatedAt,
      );

      expect(receipt.id, isNull);
      expect(receipt.number, 'NK001');
    });

    test('copyWith should create new instance with updated fields', () {
      final original = WarehouseReceipt(
        id: 'receipt1',
        approvedBy: 'Nguyễn Văn A',
        createdBy: 'Trần Thị B',
        creditAccount: '331',
        date: testDate,
        debitAccount: '156',
        deliveredBy: 'Công ty ABC',
        department: 'Kho',
        number: 'NK001',
        originalDocumentCount: 2,
        receivedBy: 'Lê Văn C',
        referenceDate: testReferenceDate,
        referenceNumber: 'HD001',
        referenceOrganization: 'Công ty ABC',
        referenceType: 'Hóa đơn',
        storeKeeper: 'Phạm Thị D',
        totalAmount: 1500000.0,
        totalAmountText: 'Một triệu năm trăm nghìn đồng',
        unit: 'Công ty XYZ',
        createdAt: testCreatedAt,
      );

      final updated = original.copyWith(
        number: 'NK002',
        totalAmount: 2000000.0,
        totalAmountText: 'Hai triệu đồng',
        department: 'Kho chính',
      );

      expect(updated.id, 'receipt1');
      expect(updated.number, 'NK002');
      expect(updated.totalAmount, 2000000.0);
      expect(updated.totalAmountText, 'Hai triệu đồng');
      expect(updated.department, 'Kho chính');
      expect(updated.approvedBy, 'Nguyễn Văn A'); // Unchanged
    });

    test('copyWith should keep original values when not specified', () {
      final original = WarehouseReceipt(
        id: 'receipt1',
        approvedBy: 'Nguyễn Văn A',
        createdBy: 'Trần Thị B',
        creditAccount: '331',
        date: testDate,
        debitAccount: '156',
        deliveredBy: 'Công ty ABC',
        department: 'Kho',
        number: 'NK001',
        originalDocumentCount: 2,
        receivedBy: 'Lê Văn C',
        referenceDate: testReferenceDate,
        referenceNumber: 'HD001',
        referenceOrganization: 'Công ty ABC',
        referenceType: 'Hóa đơn',
        storeKeeper: 'Phạm Thị D',
        totalAmount: 1500000.0,
        totalAmountText: 'Một triệu năm trăm nghìn đồng',
        unit: 'Công ty XYZ',
        createdAt: testCreatedAt,
      );

      final updated = original.copyWith(number: 'NK002');

      expect(updated.id, 'receipt1');
      expect(updated.number, 'NK002');
      expect(updated.approvedBy, 'Nguyễn Văn A');
      expect(updated.totalAmount, 1500000.0);
      expect(updated.department, 'Kho');
    });

    test('equality should work correctly', () {
      final receipt1 = WarehouseReceipt(
        id: 'receipt1',
        approvedBy: 'Nguyễn Văn A',
        createdBy: 'Trần Thị B',
        creditAccount: '331',
        date: testDate,
        debitAccount: '156',
        deliveredBy: 'Công ty ABC',
        department: 'Kho',
        number: 'NK001',
        originalDocumentCount: 2,
        receivedBy: 'Lê Văn C',
        referenceDate: testReferenceDate,
        referenceNumber: 'HD001',
        referenceOrganization: 'Công ty ABC',
        referenceType: 'Hóa đơn',
        storeKeeper: 'Phạm Thị D',
        totalAmount: 1500000.0,
        totalAmountText: 'Một triệu năm trăm nghìn đồng',
        unit: 'Công ty XYZ',
        createdAt: testCreatedAt,
      );

      final receipt2 = WarehouseReceipt(
        id: 'receipt1',
        approvedBy: 'Nguyễn Văn A',
        createdBy: 'Trần Thị B',
        creditAccount: '331',
        date: testDate,
        debitAccount: '156',
        deliveredBy: 'Công ty ABC',
        department: 'Kho',
        number: 'NK001',
        originalDocumentCount: 2,
        receivedBy: 'Lê Văn C',
        referenceDate: testReferenceDate,
        referenceNumber: 'HD001',
        referenceOrganization: 'Công ty ABC',
        referenceType: 'Hóa đơn',
        storeKeeper: 'Phạm Thị D',
        totalAmount: 1500000.0,
        totalAmountText: 'Một triệu năm trăm nghìn đồng',
        unit: 'Công ty XYZ',
        createdAt: testCreatedAt,
      );

      final receipt3 = WarehouseReceipt(
        id: 'receipt2',
        approvedBy: 'Nguyễn Văn B',
        createdBy: 'Trần Thị C',
        creditAccount: '332',
        date: DateTime(2024, 1, 16),
        debitAccount: '157',
        deliveredBy: 'Công ty DEF',
        department: 'Kho phụ',
        number: 'NK002',
        originalDocumentCount: 1,
        receivedBy: 'Lê Văn D',
        referenceDate: DateTime(2024, 1, 11),
        referenceNumber: 'HD002',
        referenceOrganization: 'Công ty DEF',
        referenceType: 'Phiếu xuất kho',
        storeKeeper: 'Phạm Thị E',
        totalAmount: 2000000.0,
        totalAmountText: 'Hai triệu đồng',
        unit: 'Công ty UVW',
        createdAt: DateTime(2024, 1, 16, 11, 30),
      );

      expect(receipt1, equals(receipt2));
      expect(receipt1, isNot(equals(receipt3)));
    });

    test('hashCode should be consistent with equality', () {
      final receipt1 = WarehouseReceipt(
        id: 'receipt1',
        approvedBy: 'Nguyễn Văn A',
        createdBy: 'Trần Thị B',
        creditAccount: '331',
        date: testDate,
        debitAccount: '156',
        deliveredBy: 'Công ty ABC',
        department: 'Kho',
        number: 'NK001',
        originalDocumentCount: 2,
        receivedBy: 'Lê Văn C',
        referenceDate: testReferenceDate,
        referenceNumber: 'HD001',
        referenceOrganization: 'Công ty ABC',
        referenceType: 'Hóa đơn',
        storeKeeper: 'Phạm Thị D',
        totalAmount: 1500000.0,
        totalAmountText: 'Một triệu năm trăm nghìn đồng',
        unit: 'Công ty XYZ',
        createdAt: testCreatedAt,
      );

      final receipt2 = WarehouseReceipt(
        id: 'receipt1',
        approvedBy: 'Nguyễn Văn A',
        createdBy: 'Trần Thị B',
        creditAccount: '331',
        date: testDate,
        debitAccount: '156',
        deliveredBy: 'Công ty ABC',
        department: 'Kho',
        number: 'NK001',
        originalDocumentCount: 2,
        receivedBy: 'Lê Văn C',
        referenceDate: testReferenceDate,
        referenceNumber: 'HD001',
        referenceOrganization: 'Công ty ABC',
        referenceType: 'Hóa đơn',
        storeKeeper: 'Phạm Thị D',
        totalAmount: 1500000.0,
        totalAmountText: 'Một triệu năm trăm nghìn đồng',
        unit: 'Công ty XYZ',
        createdAt: testCreatedAt,
      );

      expect(receipt1.hashCode, equals(receipt2.hashCode));
    });

    test('toString should return meaningful representation', () {
      final receipt = WarehouseReceipt(
        id: 'receipt1',
        approvedBy: 'Nguyễn Văn A',
        createdBy: 'Trần Thị B',
        creditAccount: '331',
        date: testDate,
        debitAccount: '156',
        deliveredBy: 'Công ty ABC',
        department: 'Kho',
        number: 'NK001',
        originalDocumentCount: 2,
        receivedBy: 'Lê Văn C',
        referenceDate: testReferenceDate,
        referenceNumber: 'HD001',
        referenceOrganization: 'Công ty ABC',
        referenceType: 'Hóa đơn',
        storeKeeper: 'Phạm Thị D',
        totalAmount: 1500000.0,
        totalAmountText: 'Một triệu năm trăm nghìn đồng',
        unit: 'Công ty XYZ',
        createdAt: testCreatedAt,
      );

      final stringRepresentation = receipt.toString();

      expect(stringRepresentation, contains('WarehouseReceipt'));
      expect(stringRepresentation, contains('receipt1'));
      expect(stringRepresentation, contains('NK001'));
      expect(stringRepresentation, contains('Công ty XYZ'));
    });
  });
}
