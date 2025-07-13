import 'package:flutter_test/flutter_test.dart';
import 'package:vimes_app/core/errors/failures.dart';
import 'package:vimes_app/core/utils/either.dart';
import 'package:vimes_app/domain/entities/material_item.dart';
import 'package:vimes_app/domain/entities/warehouse_receipt.dart';
import 'package:vimes_app/domain/repositories/warehouse_receipt_repository.dart';

// Mock repository for testing
class MockWarehouseReceiptRepository implements WarehouseReceiptRepository {
  final List<WarehouseReceipt> receipts;
  final Failure? failure;

  MockWarehouseReceiptRepository({this.receipts = const [], this.failure});

  @override
  Future<Either<Failure, String>> addWarehouseReceipt(
    WarehouseReceipt receipt,
    List<MaterialItem> items,
  ) async {
    if (failure != null) {
      return Left(failure!);
    }
    return const Right('new_receipt_id');
  }

  @override
  Stream<Either<Failure, List<WarehouseReceipt>>> getWarehouseReceiptList() {
    if (failure != null) {
      return Stream.value(Left(failure!));
    }
    return Stream.value(Right(receipts));
  }

  @override
  Future<Either<Failure, WarehouseReceipt?>> getWarehouseReceiptById(String id) async {
    if (failure != null) {
      return Left(failure!);
    }
    try {
      final receipt = receipts.firstWhere((r) => r.id == id);
      return Right(receipt);
    } catch (e) {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> updateWarehouseReceipt(WarehouseReceipt receipt) async {
    if (failure != null) {
      return Left(failure!);
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> deleteWarehouseReceipt(String id) async {
    if (failure != null) {
      return Left(failure!);
    }
    return const Right(null);
  }

  @override
  Stream<Either<Failure, List<WarehouseReceipt>>> searchWarehouseReceipt(String keyword) {
    if (failure != null) {
      return Stream.value(Left(failure!));
    }
    final filteredReceipts =
        receipts
            .where(
              (r) =>
                  r.number.contains(keyword) ||
                  r.unit.contains(keyword) ||
                  r.department.contains(keyword),
            )
            .toList();
    return Stream.value(Right(filteredReceipts));
  }

  @override
  Stream<Either<Failure, List<WarehouseReceipt>>> getWarehouseReceiptByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    if (failure != null) {
      return Stream.value(Left(failure!));
    }
    final filteredReceipts =
        receipts
            .where(
              (r) =>
                  r.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
                  r.date.isBefore(endDate.add(const Duration(days: 1))),
            )
            .toList();
    return Stream.value(Right(filteredReceipts));
  }

  @override
  Stream<Either<Failure, List<WarehouseReceipt>>> getWarehouseReceiptByUnit(String unit) {
    if (failure != null) {
      return Stream.value(Left(failure!));
    }
    final filteredReceipts = receipts.where((r) => r.unit == unit).toList();
    return Stream.value(Right(filteredReceipts));
  }

  @override
  Stream<Either<Failure, List<MaterialItem>>> getItemsByReceiptId(String receiptId) {
    if (failure != null) {
      return Stream.value(Left(failure!));
    }
    return Stream.value(const Right([]));
  }

  @override
  Future<Either<Failure, void>> updateItems(String receiptId, List<MaterialItem> items) async {
    if (failure != null) {
      return Left(failure!);
    }
    return const Right(null);
  }
}

// Simple use case implementation for testing
class GetWarehouseReceipts {
  final WarehouseReceiptRepository repository;

  GetWarehouseReceipts(this.repository);

  Stream<Either<Failure, List<WarehouseReceipt>>> call() {
    return repository.getWarehouseReceiptList();
  }
}

void main() {
  group('GetWarehouseReceipts Tests', () {
    final testDate = DateTime(2024, 1, 15);
    final testReferenceDate = DateTime(2024, 1, 10);
    final testCreatedAt = DateTime(2024, 1, 15, 10, 30);

    final testReceipts = [
      WarehouseReceipt(
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
      ),
      WarehouseReceipt(
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
      ),
    ];

    test('should get warehouse receipts from repository', () async {
      // arrange
      final mockRepository = MockWarehouseReceiptRepository(receipts: testReceipts);
      final useCase = GetWarehouseReceipts(mockRepository);

      // act
      final result = await useCase().first;

      // assert
      expect(result, Right(testReceipts));
    });

    test('should return ServerFailure when repository fails', () async {
      // arrange
      final failure = ServerFailure('Server error');
      final mockRepository = MockWarehouseReceiptRepository(failure: failure);
      final useCase = GetWarehouseReceipts(mockRepository);

      // act
      final result = await useCase().first;

      // assert
      expect(result, Left(failure));
    });

    test('should return NetworkFailure when network fails', () async {
      // arrange
      final failure = NetworkFailure('Network error');
      final mockRepository = MockWarehouseReceiptRepository(failure: failure);
      final useCase = GetWarehouseReceipts(mockRepository);

      // act
      final result = await useCase().first;

      // assert
      expect(result, Left(failure));
    });

    test('should return empty list when no receipts found', () async {
      // arrange
      final mockRepository = MockWarehouseReceiptRepository(receipts: []);
      final useCase = GetWarehouseReceipts(mockRepository);

      // act
      final result = await useCase().first;

      // assert
      expect(result, const Right([]));
    });
  });
}
