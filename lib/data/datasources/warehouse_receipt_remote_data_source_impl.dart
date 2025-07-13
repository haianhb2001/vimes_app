import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/app_constants.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../models/material_item_model.dart';
import '../models/warehouse_receipt_model.dart';
import 'warehouse_receipt_remote_data_source.dart';

class WarehouseReceiptRemoteDataSourceImpl implements WarehouseReceiptRemoteDataSource {
  final FirebaseFirestore _firestore;

  WarehouseReceiptRemoteDataSourceImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, String>> addWarehouseReceipt(
    WarehouseReceiptModel receipt,
    List<MaterialItemModel> items,
  ) async {
    try {
      // Tạo document mới cho phiếu nhập kho
      DocumentReference docRef = await _firestore
          .collection(AppConstants.warehouseReceiptsCollection)
          .add(receipt.toJson());

      // Thêm items vào subcollection
      if (items.isNotEmpty) {
        for (int i = 0; i < items.length; i++) {
          final item = items[i].copyWith(index: i + 1) as MaterialItemModel;
          await docRef.collection(AppConstants.itemsSubcollection).add(item.toJson());
        }
      }

      return Right(docRef.id);
    } catch (e) {
      return Left(ServerFailure('Lỗi khi thêm phiếu nhập kho: $e'));
    }
  }

  @override
  Stream<Either<Failure, List<WarehouseReceiptModel>>> getWarehouseReceiptList() {
    return _firestore
        .collection(AppConstants.warehouseReceiptsCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          try {
            final receipts =
                snapshot.docs.map((doc) {
                  return WarehouseReceiptModel.fromJson(doc.data(), doc.id);
                }).toList();
            return Right(receipts);
          } catch (e) {
            return Left(ServerFailure('Lỗi khi lấy danh sách phiếu nhập kho: $e'));
          }
        });
  }

  @override
  Future<Either<Failure, WarehouseReceiptModel?>> getWarehouseReceiptById(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection(AppConstants.warehouseReceiptsCollection).doc(id).get();

      if (doc.exists) {
        final receipt = WarehouseReceiptModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        return Right(receipt);
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Lỗi khi lấy phiếu nhập kho: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateWarehouseReceipt(WarehouseReceiptModel receipt) async {
    try {
      if (receipt.id == null) {
        return Left(ValidationFailure('ID phiếu nhập kho không được để trống'));
      }

      await _firestore
          .collection(AppConstants.warehouseReceiptsCollection)
          .doc(receipt.id)
          .update(receipt.toJson());

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Lỗi khi cập nhật phiếu nhập kho: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateItems(String receiptId, List<MaterialItemModel> items) async {
    try {
      // Xóa tất cả items cũ
      final oldItems =
          await _firestore
              .collection(AppConstants.warehouseReceiptsCollection)
              .doc(receiptId)
              .collection(AppConstants.itemsSubcollection)
              .get();

      for (var doc in oldItems.docs) {
        await doc.reference.delete();
      }

      // Thêm items mới
      for (int i = 0; i < items.length; i++) {
        final item = items[i].copyWith(index: i + 1) as MaterialItemModel;
        await _firestore
            .collection(AppConstants.warehouseReceiptsCollection)
            .doc(receiptId)
            .collection(AppConstants.itemsSubcollection)
            .add(item.toJson());
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Lỗi khi cập nhật items: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteWarehouseReceipt(String id) async {
    try {
      // Xóa tất cả items trước
      final items =
          await _firestore
              .collection(AppConstants.warehouseReceiptsCollection)
              .doc(id)
              .collection(AppConstants.itemsSubcollection)
              .get();

      for (var doc in items.docs) {
        await doc.reference.delete();
      }

      // Xóa phiếu nhập kho
      await _firestore.collection(AppConstants.warehouseReceiptsCollection).doc(id).delete();

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Lỗi khi xóa phiếu nhập kho: $e'));
    }
  }

  @override
  Stream<Either<Failure, List<WarehouseReceiptModel>>> searchWarehouseReceipt(String keyword) {
    return _firestore
        .collection(AppConstants.warehouseReceiptsCollection)
        .where('number', isGreaterThanOrEqualTo: keyword)
        .where('number', isLessThan: keyword + '\uf8ff')
        .orderBy('number')
        .snapshots()
        .map((snapshot) {
          try {
            final receipts =
                snapshot.docs.map((doc) {
                  return WarehouseReceiptModel.fromJson(doc.data(), doc.id);
                }).toList();
            return Right(receipts);
          } catch (e) {
            return Left(ServerFailure('Lỗi khi tìm kiếm phiếu nhập kho: $e'));
          }
        });
  }

  @override
  Stream<Either<Failure, List<WarehouseReceiptModel>>> getWarehouseReceiptByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    return _firestore
        .collection(AppConstants.warehouseReceiptsCollection)
        .where('date', isGreaterThanOrEqualTo: startDate.toIso8601String())
        .where('date', isLessThanOrEqualTo: endDate.toIso8601String())
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          try {
            final receipts =
                snapshot.docs.map((doc) {
                  return WarehouseReceiptModel.fromJson(doc.data(), doc.id);
                }).toList();
            return Right(receipts);
          } catch (e) {
            return Left(ServerFailure('Lỗi khi lấy phiếu nhập kho theo ngày: $e'));
          }
        });
  }

  @override
  Stream<Either<Failure, List<WarehouseReceiptModel>>> getWarehouseReceiptByUnit(String unit) {
    return _firestore
        .collection(AppConstants.warehouseReceiptsCollection)
        .where('unit', isEqualTo: unit)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          try {
            final receipts =
                snapshot.docs.map((doc) {
                  return WarehouseReceiptModel.fromJson(doc.data(), doc.id);
                }).toList();
            return Right(receipts);
          } catch (e) {
            return Left(ServerFailure('Lỗi khi lấy phiếu nhập kho theo đơn vị: $e'));
          }
        });
  }

  @override
  Stream<Either<Failure, List<MaterialItemModel>>> getItemsByReceiptId(String receiptId) {
    return _firestore
        .collection(AppConstants.warehouseReceiptsCollection)
        .doc(receiptId)
        .collection(AppConstants.itemsSubcollection)
        .orderBy('index')
        .snapshots()
        .map((snapshot) {
          try {
            final items =
                snapshot.docs.map((doc) {
                  return MaterialItemModel.fromJson(doc.data(), doc.id);
                }).toList();
            return Right(items);
          } catch (e) {
            return Left(ServerFailure('Lỗi khi lấy items: $e'));
          }
        });
  }
}
