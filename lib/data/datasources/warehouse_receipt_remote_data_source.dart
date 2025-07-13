import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../models/material_item_model.dart';
import '../models/warehouse_receipt_model.dart';

abstract class WarehouseReceiptRemoteDataSource {
  // Warehouse Receipt operations
  Future<Either<Failure, String>> addWarehouseReceipt(
    WarehouseReceiptModel receipt,
    List<MaterialItemModel> items,
  );

  Stream<Either<Failure, List<WarehouseReceiptModel>>> getWarehouseReceiptList();

  Future<Either<Failure, WarehouseReceiptModel?>> getWarehouseReceiptById(String id);

  Future<Either<Failure, void>> updateWarehouseReceipt(WarehouseReceiptModel receipt);

  Future<Either<Failure, void>> deleteWarehouseReceipt(String id);

  Stream<Either<Failure, List<WarehouseReceiptModel>>> searchWarehouseReceipt(String keyword);

  Stream<Either<Failure, List<WarehouseReceiptModel>>> getWarehouseReceiptByDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  Stream<Either<Failure, List<WarehouseReceiptModel>>> getWarehouseReceiptByUnit(String unit);

  // Material Item operations
  Stream<Either<Failure, List<MaterialItemModel>>> getItemsByReceiptId(String receiptId);

  Future<Either<Failure, void>> updateItems(String receiptId, List<MaterialItemModel> items);
}
