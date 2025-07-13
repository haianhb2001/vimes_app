import 'package:flutter_test/flutter_test.dart';
import 'package:vimes_app/core/errors/failures.dart';
import 'package:vimes_app/core/utils/either.dart';
import 'package:vimes_app/domain/entities/material_item.dart';
import 'package:vimes_app/domain/entities/warehouse_receipt.dart';

// Simple BLoC implementation for testing
abstract class WarehouseReceiptEvent {}

class LoadWarehouseReceipts extends WarehouseReceiptEvent {}

class SearchWarehouseReceipts extends WarehouseReceiptEvent {
  final String keyword;
  SearchWarehouseReceipts(this.keyword);
}

class FilterByDateRange extends WarehouseReceiptEvent {
  final DateTime startDate;
  final DateTime endDate;
  FilterByDateRange({required this.startDate, required this.endDate});
}

class FilterByUnit extends WarehouseReceiptEvent {
  final String unit;
  FilterByUnit(this.unit);
}

abstract class WarehouseReceiptState {}

class WarehouseReceiptInitial extends WarehouseReceiptState {}

class WarehouseReceiptLoading extends WarehouseReceiptState {}

class WarehouseReceiptLoaded extends WarehouseReceiptState {
  final List<WarehouseReceipt> receipts;
  WarehouseReceiptLoaded(this.receipts);
}

class WarehouseReceiptError extends WarehouseReceiptState {
  final String message;
  WarehouseReceiptError(this.message);
}

// Mock repository for testing
class MockWarehouseReceiptRepository {
  final List<WarehouseReceipt> receipts;
  final Failure? failure;

  MockWarehouseReceiptRepository({this.receipts = const [], this.failure});

  Stream<Either<Failure, List<WarehouseReceipt>>> getWarehouseReceiptList() {
    if (failure != null) {
      return Stream.value(Left(failure!));
    }
    return Stream.value(Right(receipts));
  }

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

  Future<Either<Failure, String>> addWarehouseReceipt(
    WarehouseReceipt receipt,
    List<MaterialItem> items,
  ) async {
    if (failure != null) {
      return Left(failure!);
    }
    return const Right('new_receipt_id');
  }

  Future<Either<Failure, void>> updateWarehouseReceipt(WarehouseReceipt receipt) async {
    if (failure != null) {
      return Left(failure!);
    }
    return const Right(null);
  }

  Future<Either<Failure, void>> deleteWarehouseReceipt(String id) async {
    if (failure != null) {
      return Left(failure!);
    }
    return const Right(null);
  }

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

  Stream<Either<Failure, List<WarehouseReceipt>>> getWarehouseReceiptByUnit(String unit) {
    if (failure != null) {
      return Stream.value(Left(failure!));
    }
    final filteredReceipts = receipts.where((r) => r.unit == unit).toList();
    return Stream.value(Right(filteredReceipts));
  }

  Stream<Either<Failure, List<MaterialItem>>> getItemsByReceiptId(String receiptId) {
    if (failure != null) {
      return Stream.value(Left(failure!));
    }
    return Stream.value(const Right([]));
  }

  Future<Either<Failure, void>> updateItems(String receiptId, List<MaterialItem> items) async {
    if (failure != null) {
      return Left(failure!);
    }
    return const Right(null);
  }
}

// Simple BLoC implementation for testing
class WarehouseReceiptBloc {
  final MockWarehouseReceiptRepository repository;
  WarehouseReceiptState _state = WarehouseReceiptInitial();

  WarehouseReceiptBloc(this.repository);

  WarehouseReceiptState get state => _state;

  void add(WarehouseReceiptEvent event) {
    if (event is LoadWarehouseReceipts) {
      _loadReceipts();
    } else if (event is SearchWarehouseReceipts) {
      _searchReceipts(event.keyword);
    } else if (event is FilterByDateRange) {
      _filterByDateRange(event.startDate, event.endDate);
    } else if (event is FilterByUnit) {
      _filterByUnit(event.unit);
    }
  }

  void _loadReceipts() {
    _state = WarehouseReceiptLoading();
    repository.getWarehouseReceiptList().listen((result) {
      result.fold(
        (failure) => _state = WarehouseReceiptError(failure.message),
        (receipts) => _state = WarehouseReceiptLoaded(receipts),
      );
    });
  }

  void _searchReceipts(String keyword) {
    _state = WarehouseReceiptLoading();
    repository.searchWarehouseReceipt(keyword).listen((result) {
      result.fold(
        (failure) => _state = WarehouseReceiptError(failure.message),
        (receipts) => _state = WarehouseReceiptLoaded(receipts),
      );
    });
  }

  void _filterByDateRange(DateTime startDate, DateTime endDate) {
    _state = WarehouseReceiptLoading();
    repository.getWarehouseReceiptByDateRange(startDate, endDate).listen((result) {
      result.fold(
        (failure) => _state = WarehouseReceiptError(failure.message),
        (receipts) => _state = WarehouseReceiptLoaded(receipts),
      );
    });
  }

  void _filterByUnit(String unit) {
    _state = WarehouseReceiptLoading();
    repository.getWarehouseReceiptByUnit(unit).listen((result) {
      result.fold(
        (failure) => _state = WarehouseReceiptError(failure.message),
        (receipts) => _state = WarehouseReceiptLoaded(receipts),
      );
    });
  }
}

void main() {
  group('WarehouseReceiptBloc Tests', () {
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

    test('initial state should be WarehouseReceiptInitial', () {
      final mockRepository = MockWarehouseReceiptRepository();
      final bloc = WarehouseReceiptBloc(mockRepository);

      expect(bloc.state, isA<WarehouseReceiptInitial>());
    });

    test('should emit loading state when LoadWarehouseReceipts is added', () {
      final mockRepository = MockWarehouseReceiptRepository(receipts: testReceipts);
      final bloc = WarehouseReceiptBloc(mockRepository);

      bloc.add(LoadWarehouseReceipts());

      expect(bloc.state, isA<WarehouseReceiptLoading>());
    });

    test('should emit loading state when SearchWarehouseReceipts is added', () {
      final mockRepository = MockWarehouseReceiptRepository(receipts: testReceipts);
      final bloc = WarehouseReceiptBloc(mockRepository);

      bloc.add(SearchWarehouseReceipts('NK001'));

      expect(bloc.state, isA<WarehouseReceiptLoading>());
    });

    test('should emit loading state when FilterByDateRange is added', () {
      final mockRepository = MockWarehouseReceiptRepository(receipts: testReceipts);
      final bloc = WarehouseReceiptBloc(mockRepository);

      bloc.add(FilterByDateRange(startDate: DateTime(2024, 1, 1), endDate: DateTime(2024, 1, 31)));

      expect(bloc.state, isA<WarehouseReceiptLoading>());
    });

    test('should emit loading state when FilterByUnit is added', () {
      final mockRepository = MockWarehouseReceiptRepository(receipts: testReceipts);
      final bloc = WarehouseReceiptBloc(mockRepository);

      bloc.add(FilterByUnit('Công ty XYZ'));

      expect(bloc.state, isA<WarehouseReceiptLoading>());
    });
  });
}
