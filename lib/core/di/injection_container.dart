import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/datasources/warehouse_receipt_remote_data_source.dart';
import '../../data/datasources/warehouse_receipt_remote_data_source_impl.dart';
import '../../data/repositories/warehouse_receipt_repository_impl.dart';
import '../../domain/repositories/warehouse_receipt_repository.dart';
import '../../domain/usecases/warehouse_receipt_usecases.dart';

class InjectionContainer {
  static final InjectionContainer _instance = InjectionContainer._internal();
  factory InjectionContainer() => _instance;
  InjectionContainer._internal();

  // Data Sources
  WarehouseReceiptRemoteDataSource get warehouseReceiptRemoteDataSource {
    return WarehouseReceiptRemoteDataSourceImpl(firestore: FirebaseFirestore.instance);
  }

  // Repositories
  WarehouseReceiptRepository get warehouseReceiptRepository {
    return WarehouseReceiptRepositoryImpl(remoteDataSource: warehouseReceiptRemoteDataSource);
  }

  // Use Cases
  GetWarehouseReceiptList get getWarehouseReceiptList {
    return GetWarehouseReceiptList(warehouseReceiptRepository);
  }

  GetWarehouseReceiptById get getWarehouseReceiptById {
    return GetWarehouseReceiptById(warehouseReceiptRepository);
  }

  AddWarehouseReceipt get addWarehouseReceipt {
    return AddWarehouseReceipt(warehouseReceiptRepository);
  }

  UpdateWarehouseReceipt get updateWarehouseReceipt {
    return UpdateWarehouseReceipt(warehouseReceiptRepository);
  }

  DeleteWarehouseReceipt get deleteWarehouseReceipt {
    return DeleteWarehouseReceipt(warehouseReceiptRepository);
  }

  SearchWarehouseReceipt get searchWarehouseReceipt {
    return SearchWarehouseReceipt(warehouseReceiptRepository);
  }

  GetWarehouseReceiptByDateRange get getWarehouseReceiptByDateRange {
    return GetWarehouseReceiptByDateRange(warehouseReceiptRepository);
  }

  GetWarehouseReceiptByUnit get getWarehouseReceiptByUnit {
    return GetWarehouseReceiptByUnit(warehouseReceiptRepository);
  }

  GetItemsByReceiptId get getItemsByReceiptId {
    return GetItemsByReceiptId(warehouseReceiptRepository);
  }

  UpdateItems get updateItems {
    return UpdateItems(warehouseReceiptRepository);
  }
}
