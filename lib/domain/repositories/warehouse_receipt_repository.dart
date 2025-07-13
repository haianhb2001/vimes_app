import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../entities/material_item.dart';
import '../entities/warehouse_receipt.dart';

abstract class WarehouseReceiptRepository {
  // Warehouse Receipt operations
  Future<Either<Failure, String>> addWarehouseReceipt(
    WarehouseReceipt receipt,
    List<MaterialItem> items,
  );

  Stream<Either<Failure, List<WarehouseReceipt>>> getWarehouseReceiptList();

  Future<Either<Failure, WarehouseReceipt?>> getWarehouseReceiptById(String id);

  Future<Either<Failure, void>> updateWarehouseReceipt(WarehouseReceipt receipt);

  Future<Either<Failure, void>> deleteWarehouseReceipt(String id);

  Stream<Either<Failure, List<WarehouseReceipt>>> searchWarehouseReceipt(String keyword);

  Stream<Either<Failure, List<WarehouseReceipt>>> getWarehouseReceiptByDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  Stream<Either<Failure, List<WarehouseReceipt>>> getWarehouseReceiptByUnit(String unit);

  // Material Item operations
  Stream<Either<Failure, List<MaterialItem>>> getItemsByReceiptId(String receiptId);

  Future<Either<Failure, void>> updateItems(String receiptId, List<MaterialItem> items);
}
