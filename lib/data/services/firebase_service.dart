import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/warehouse_receipt_model.dart';
import '../models/material_item_model.dart';
import '../../domain/entities/warehouse_receipt.dart';
import '../../domain/entities/material_item.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'warehouse_receipts';
  static const String _subcollectionName = 'items';

  // Thêm phiếu nhập kho mới với items
  static Future<String> addWarehouseReceipt(
    WarehouseReceipt receipt,
    List<MaterialItem> items,
  ) async {
    try {
      // Chuyển đổi entity sang model
      final receiptModel = WarehouseReceiptModel.fromEntity(receipt);

      // Tạo document mới cho phiếu nhập kho
      DocumentReference docRef = await _firestore
          .collection(_collectionName)
          .add(receiptModel.toJson());

      // Thêm items vào subcollection
      if (items.isNotEmpty) {
        for (int i = 0; i < items.length; i++) {
          final item = items[i];
          final itemModel = MaterialItemModel.fromEntityWithIndex(item, i + 1);
          await docRef.collection(_subcollectionName).add(itemModel.toJson());
        }
      }

      return docRef.id;
    } catch (e) {
      throw Exception('Lỗi khi thêm phiếu nhập kho: $e');
    }
  }

  // Lấy tất cả phiếu nhập kho
  static Stream<List<WarehouseReceipt>> getWarehouseReceiptList() {
    return _firestore
        .collection(_collectionName)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final model = WarehouseReceiptModel.fromJson(doc.data(), doc.id);
            return model.toEntity();
          }).toList();
        });
  }

  // Lấy phiếu nhập kho theo ID
  static Future<WarehouseReceipt?> getWarehouseReceiptById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection(_collectionName).doc(id).get();

      if (doc.exists) {
        final model = WarehouseReceiptModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        return model.toEntity();
      }
      return null;
    } catch (e) {
      throw Exception('Lỗi khi lấy phiếu nhập kho: $e');
    }
  }

  // Lấy items của phiếu nhập kho
  static Stream<List<MaterialItem>> getItemsByReceiptId(String receiptId) {
    return _firestore
        .collection(_collectionName)
        .doc(receiptId)
        .collection(_subcollectionName)
        .orderBy('index')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final model = MaterialItemModel.fromJson(doc.data(), doc.id);
            return model.toEntity();
          }).toList();
        });
  }

  // Cập nhật phiếu nhập kho
  static Future<void> updateWarehouseReceipt(WarehouseReceipt receipt) async {
    try {
      if (receipt.id == null) {
        throw Exception('ID phiếu nhập kho không được để trống');
      }

      final receiptModel = WarehouseReceiptModel.fromEntity(receipt);
      await _firestore.collection(_collectionName).doc(receipt.id).update(receiptModel.toJson());
    } catch (e) {
      throw Exception('Lỗi khi cập nhật phiếu nhập kho: $e');
    }
  }

  // Cập nhật items của phiếu nhập kho
  static Future<void> updateItems(String receiptId, List<MaterialItem> items) async {
    try {
      // Xóa tất cả items cũ
      final oldItems =
          await _firestore
              .collection(_collectionName)
              .doc(receiptId)
              .collection(_subcollectionName)
              .get();

      for (var doc in oldItems.docs) {
        await doc.reference.delete();
      }

      // Thêm items mới
      for (int i = 0; i < items.length; i++) {
        final item = items[i];
        final itemModel = MaterialItemModel.fromEntityWithIndex(item, i + 1);
        await _firestore
            .collection(_collectionName)
            .doc(receiptId)
            .collection(_subcollectionName)
            .add(itemModel.toJson());
      }
    } catch (e) {
      throw Exception('Lỗi khi cập nhật items: $e');
    }
  }

  // Xóa phiếu nhập kho và tất cả items
  static Future<void> deleteWarehouseReceipt(String id) async {
    try {
      // Xóa tất cả items trước
      final items =
          await _firestore.collection(_collectionName).doc(id).collection(_subcollectionName).get();

      for (var doc in items.docs) {
        await doc.reference.delete();
      }

      // Xóa phiếu nhập kho
      await _firestore.collection(_collectionName).doc(id).delete();
    } catch (e) {
      throw Exception('Lỗi khi xóa phiếu nhập kho: $e');
    }
  }

  // Tìm kiếm phiếu nhập kho theo từ khóa
  static Stream<List<WarehouseReceipt>> searchWarehouseReceipt(String keyword) {
    return _firestore
        .collection(_collectionName)
        .where('number', isGreaterThanOrEqualTo: keyword)
        .where('number', isLessThan: keyword + '\uf8ff')
        .orderBy('number')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final model = WarehouseReceiptModel.fromJson(doc.data(), doc.id);
            return model.toEntity();
          }).toList();
        });
  }

  // Lấy phiếu nhập kho theo khoảng thời gian
  static Stream<List<WarehouseReceipt>> getWarehouseReceiptByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    return _firestore
        .collection(_collectionName)
        .where('date', isGreaterThanOrEqualTo: startDate.toIso8601String())
        .where('date', isLessThanOrEqualTo: endDate.toIso8601String())
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final model = WarehouseReceiptModel.fromJson(doc.data(), doc.id);
            return model.toEntity();
          }).toList();
        });
  }

  // Lấy phiếu nhập kho theo đơn vị
  static Stream<List<WarehouseReceipt>> getWarehouseReceiptByUnit(String unit) {
    return _firestore
        .collection(_collectionName)
        .where('unit', isEqualTo: unit)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final model = WarehouseReceiptModel.fromJson(doc.data(), doc.id);
            return model.toEntity();
          }).toList();
        });
  }
}
