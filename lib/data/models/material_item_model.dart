import '../../domain/entities/material_item.dart';

class MaterialItemModel extends MaterialItem {
  const MaterialItemModel({
    super.id,
    required super.code,
    required super.name,
    required super.unit,
    required super.quantityDocument,
    required super.quantityReceived,
    required super.unitPrice,
    required super.totalPrice,
    required super.index,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'unit': unit,
      'quantityDocument': quantityDocument,
      'quantityReceived': quantityReceived,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'index': index,
    };
  }

  // Create from JSON
  factory MaterialItemModel.fromJson(Map<String, dynamic> json, String documentId) {
    return MaterialItemModel(
      id: documentId,
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      unit: json['unit'] ?? '',
      quantityDocument: json['quantityDocument'] ?? 0,
      quantityReceived: json['quantityReceived'] ?? 0,
      unitPrice: (json['unitPrice'] ?? 0).toDouble(),
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      index: json['index'] ?? 0,
    );
  }

  // Convert from Entity
  factory MaterialItemModel.fromEntity(MaterialItem entity) {
    return MaterialItemModel(
      id: entity.id,
      code: entity.code,
      name: entity.name,
      unit: entity.unit,
      quantityDocument: entity.quantityDocument,
      quantityReceived: entity.quantityReceived,
      unitPrice: entity.unitPrice,
      totalPrice: entity.totalPrice,
      index: entity.index,
    );
  }

  // Convert from Entity with new index
  factory MaterialItemModel.fromEntityWithIndex(MaterialItem entity, int newIndex) {
    return MaterialItemModel(
      id: entity.id,
      code: entity.code,
      name: entity.name,
      unit: entity.unit,
      quantityDocument: entity.quantityDocument,
      quantityReceived: entity.quantityReceived,
      unitPrice: entity.unitPrice,
      totalPrice: entity.totalPrice,
      index: newIndex,
    );
  }

  // Convert to Entity
  MaterialItem toEntity() {
    return MaterialItem(
      id: id,
      code: code,
      name: name,
      unit: unit,
      quantityDocument: quantityDocument,
      quantityReceived: quantityReceived,
      unitPrice: unitPrice,
      totalPrice: totalPrice,
      index: index,
    );
  }
}
