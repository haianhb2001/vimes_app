import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../../domain/entities/material_item.dart';
import '../../domain/entities/warehouse_receipt.dart';
import '../../domain/repositories/warehouse_receipt_repository.dart';
import '../datasources/warehouse_receipt_remote_data_source.dart';
import '../models/material_item_model.dart';
import '../models/warehouse_receipt_model.dart';

class WarehouseReceiptRepositoryImpl implements WarehouseReceiptRepository {
  final WarehouseReceiptRemoteDataSource remoteDataSource;

  WarehouseReceiptRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> addWarehouseReceipt(
    WarehouseReceipt receipt,
    List<MaterialItem> items,
  ) async {
    try {
      final receiptModel = WarehouseReceiptModel.fromEntity(receipt);
      final itemModels = items.map((item) => MaterialItemModel.fromEntity(item)).toList();

      return await remoteDataSource.addWarehouseReceipt(receiptModel, itemModels);
    } catch (e) {
      return Left(UnknownFailure('Lỗi không xác định: $e'));
    }
  }

  @override
  Stream<Either<Failure, List<WarehouseReceipt>>> getWarehouseReceiptList() {
    return remoteDataSource.getWarehouseReceiptList().map((result) {
      return result.fold(
        (failure) => Left(failure),
        (models) => Right(models.map((model) => model.toEntity()).toList()),
      );
    });
  }

  @override
  Future<Either<Failure, WarehouseReceipt?>> getWarehouseReceiptById(String id) async {
    try {
      final result = await remoteDataSource.getWarehouseReceiptById(id);
      return result.fold((failure) => Left(failure), (model) => Right(model?.toEntity()));
    } catch (e) {
      return Left(UnknownFailure('Lỗi không xác định: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateWarehouseReceipt(WarehouseReceipt receipt) async {
    try {
      final receiptModel = WarehouseReceiptModel.fromEntity(receipt);
      return await remoteDataSource.updateWarehouseReceipt(receiptModel);
    } catch (e) {
      return Left(UnknownFailure('Lỗi không xác định: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteWarehouseReceipt(String id) async {
    try {
      return await remoteDataSource.deleteWarehouseReceipt(id);
    } catch (e) {
      return Left(UnknownFailure('Lỗi không xác định: $e'));
    }
  }

  @override
  Stream<Either<Failure, List<WarehouseReceipt>>> searchWarehouseReceipt(String keyword) {
    return remoteDataSource.searchWarehouseReceipt(keyword).map((result) {
      return result.fold(
        (failure) => Left(failure),
        (models) => Right(models.map((model) => model.toEntity()).toList()),
      );
    });
  }

  @override
  Stream<Either<Failure, List<WarehouseReceipt>>> getWarehouseReceiptByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    return remoteDataSource.getWarehouseReceiptByDateRange(startDate, endDate).map((result) {
      return result.fold(
        (failure) => Left(failure),
        (models) => Right(models.map((model) => model.toEntity()).toList()),
      );
    });
  }

  @override
  Stream<Either<Failure, List<WarehouseReceipt>>> getWarehouseReceiptByUnit(String unit) {
    return remoteDataSource.getWarehouseReceiptByUnit(unit).map((result) {
      return result.fold(
        (failure) => Left(failure),
        (models) => Right(models.map((model) => model.toEntity()).toList()),
      );
    });
  }

  @override
  Stream<Either<Failure, List<MaterialItem>>> getItemsByReceiptId(String receiptId) {
    return remoteDataSource.getItemsByReceiptId(receiptId).map((result) {
      return result.fold(
        (failure) => Left(failure),
        (models) => Right(models.map((model) => model.toEntity()).toList()),
      );
    });
  }

  @override
  Future<Either<Failure, void>> updateItems(String receiptId, List<MaterialItem> items) async {
    try {
      final itemModels = items.map((item) => MaterialItemModel.fromEntity(item)).toList();
      return await remoteDataSource.updateItems(receiptId, itemModels);
    } catch (e) {
      return Left(UnknownFailure('Lỗi không xác định: $e'));
    }
  }
}
