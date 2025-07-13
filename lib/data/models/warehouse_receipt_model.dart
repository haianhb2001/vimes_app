import '../../domain/entities/warehouse_receipt.dart';

class WarehouseReceiptModel extends WarehouseReceipt {
  const WarehouseReceiptModel({
    super.id,
    required super.approvedBy,
    required super.createdBy,
    required super.creditAccount,
    required super.date,
    required super.debitAccount,
    required super.deliveredBy,
    required super.department,
    required super.number,
    required super.originalDocumentCount,
    required super.receivedBy,
    required super.referenceDate,
    required super.referenceNumber,
    required super.referenceOrganization,
    required super.referenceType,
    required super.storeKeeper,
    required super.totalAmount,
    required super.totalAmountText,
    required super.unit,
    required super.createdAt,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'approvedBy': approvedBy,
      'createdBy': createdBy,
      'creditAccount': creditAccount,
      'date': date.toIso8601String(),
      'debitAccount': debitAccount,
      'deliveredBy': deliveredBy,
      'department': department,
      'number': number,
      'originalDocumentCount': originalDocumentCount,
      'receivedBy': receivedBy,
      'referenceDate': referenceDate.toIso8601String(),
      'referenceNumber': referenceNumber,
      'referenceOrganization': referenceOrganization,
      'referenceType': referenceType,
      'storeKeeper': storeKeeper,
      'totalAmount': totalAmount,
      'totalAmountText': totalAmountText,
      'unit': unit,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory WarehouseReceiptModel.fromJson(Map<String, dynamic> json, String documentId) {
    return WarehouseReceiptModel(
      id: documentId,
      approvedBy: json['approvedBy'] ?? '',
      createdBy: json['createdBy'] ?? '',
      creditAccount: json['creditAccount'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      debitAccount: json['debitAccount'] ?? '',
      deliveredBy: json['deliveredBy'] ?? '',
      department: json['department'] ?? '',
      number: json['number'] ?? '',
      originalDocumentCount: json['originalDocumentCount'] ?? 0,
      receivedBy: json['receivedBy'] ?? '',
      referenceDate: DateTime.tryParse(json['referenceDate'] ?? '') ?? DateTime.now(),
      referenceNumber: json['referenceNumber'] ?? '',
      referenceOrganization: json['referenceOrganization'] ?? '',
      referenceType: json['referenceType'] ?? '',
      storeKeeper: json['storeKeeper'] ?? '',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      totalAmountText: json['totalAmountText'] ?? '',
      unit: json['unit'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  // Convert from Entity
  factory WarehouseReceiptModel.fromEntity(WarehouseReceipt entity) {
    return WarehouseReceiptModel(
      id: entity.id,
      approvedBy: entity.approvedBy,
      createdBy: entity.createdBy,
      creditAccount: entity.creditAccount,
      date: entity.date,
      debitAccount: entity.debitAccount,
      deliveredBy: entity.deliveredBy,
      department: entity.department,
      number: entity.number,
      originalDocumentCount: entity.originalDocumentCount,
      receivedBy: entity.receivedBy,
      referenceDate: entity.referenceDate,
      referenceNumber: entity.referenceNumber,
      referenceOrganization: entity.referenceOrganization,
      referenceType: entity.referenceType,
      storeKeeper: entity.storeKeeper,
      totalAmount: entity.totalAmount,
      totalAmountText: entity.totalAmountText,
      unit: entity.unit,
      createdAt: entity.createdAt,
    );
  }

  // Convert to Entity
  WarehouseReceipt toEntity() {
    return WarehouseReceipt(
      id: id,
      approvedBy: approvedBy,
      createdBy: createdBy,
      creditAccount: creditAccount,
      date: date,
      debitAccount: debitAccount,
      deliveredBy: deliveredBy,
      department: department,
      number: number,
      originalDocumentCount: originalDocumentCount,
      receivedBy: receivedBy,
      referenceDate: referenceDate,
      referenceNumber: referenceNumber,
      referenceOrganization: referenceOrganization,
      referenceType: referenceType,
      storeKeeper: storeKeeper,
      totalAmount: totalAmount,
      totalAmountText: totalAmountText,
      unit: unit,
      createdAt: createdAt,
    );
  }
}
