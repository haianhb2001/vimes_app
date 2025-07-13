import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../entities/material_item.dart';
import '../entities/warehouse_receipt.dart';
import '../repositories/warehouse_receipt_repository.dart';

class GetWarehouseReceiptList {
  final WarehouseReceiptRepository repository;

  GetWarehouseReceiptList(this.repository);

  Stream<Either<Failure, List<WarehouseReceipt>>> call() {
    return repository.getWarehouseReceiptList();
  }
}

class GetWarehouseReceiptById {
  final WarehouseReceiptRepository repository;

  GetWarehouseReceiptById(this.repository);

  Future<Either<Failure, WarehouseReceipt?>> call(String id) {
    return repository.getWarehouseReceiptById(id);
  }
}

class AddWarehouseReceipt {
  final WarehouseReceiptRepository repository;

  AddWarehouseReceipt(this.repository);

  Future<Either<Failure, String>> call(WarehouseReceipt receipt, List<MaterialItem> items) {
    return repository.addWarehouseReceipt(receipt, items);
  }
}

class UpdateWarehouseReceipt {
  final WarehouseReceiptRepository repository;

  UpdateWarehouseReceipt(this.repository);

  Future<Either<Failure, void>> call(WarehouseReceipt receipt) {
    return repository.updateWarehouseReceipt(receipt);
  }
}

class DeleteWarehouseReceipt {
  final WarehouseReceiptRepository repository;

  DeleteWarehouseReceipt(this.repository);

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteWarehouseReceipt(id);
  }
}

class SearchWarehouseReceipt {
  final WarehouseReceiptRepository repository;

  SearchWarehouseReceipt(this.repository);

  Stream<Either<Failure, List<WarehouseReceipt>>> call(String keyword) {
    return repository.searchWarehouseReceipt(keyword);
  }
}

class GetWarehouseReceiptByDateRange {
  final WarehouseReceiptRepository repository;

  GetWarehouseReceiptByDateRange(this.repository);

  Stream<Either<Failure, List<WarehouseReceipt>>> call(DateTime startDate, DateTime endDate) {
    return repository.getWarehouseReceiptByDateRange(startDate, endDate);
  }
}

class GetWarehouseReceiptByUnit {
  final WarehouseReceiptRepository repository;

  GetWarehouseReceiptByUnit(this.repository);

  Stream<Either<Failure, List<WarehouseReceipt>>> call(String unit) {
    return repository.getWarehouseReceiptByUnit(unit);
  }
}

class GetItemsByReceiptId {
  final WarehouseReceiptRepository repository;

  GetItemsByReceiptId(this.repository);

  Stream<Either<Failure, List<MaterialItem>>> call(String receiptId) {
    return repository.getItemsByReceiptId(receiptId);
  }
}

class UpdateItems {
  final WarehouseReceiptRepository repository;

  UpdateItems(this.repository);

  Future<Either<Failure, void>> call(String receiptId, List<MaterialItem> items) {
    return repository.updateItems(receiptId, items);
  }
}
