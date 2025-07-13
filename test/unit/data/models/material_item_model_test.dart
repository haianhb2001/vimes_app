import 'package:flutter_test/flutter_test.dart';
import 'package:vimes_app/data/models/material_item_model.dart';
import 'package:vimes_app/domain/entities/material_item.dart';

void main() {
  group('MaterialItemModel Tests', () {
    test('should create MaterialItemModel from JSON', () {
      final json = {
        'code': 'MT001',
        'name': 'Vật tư 1',
        'unit': 'Cái',
        'quantityDocument': 10,
        'quantityReceived': 8,
        'unitPrice': 100000.0,
        'totalPrice': 800000.0,
        'index': 1,
      };

      final model = MaterialItemModel.fromJson(json, 'item1');

      expect(model.id, 'item1');
      expect(model.code, 'MT001');
      expect(model.name, 'Vật tư 1');
      expect(model.unit, 'Cái');
      expect(model.quantityDocument, 10);
      expect(model.quantityReceived, 8);
      expect(model.unitPrice, 100000.0);
      expect(model.totalPrice, 800000.0);
      expect(model.index, 1);
    });

    test('should create MaterialItemModel without id from JSON', () {
      final json = {
        'code': 'MT001',
        'name': 'Vật tư 1',
        'unit': 'Cái',
        'quantityDocument': 10,
        'quantityReceived': 8,
        'unitPrice': 100000.0,
        'totalPrice': 800000.0,
        'index': 1,
      };

      final model = MaterialItemModel.fromJson(json, 'item1');

      expect(model.id, isNull);
      expect(model.code, 'MT001');
    });

    test('should convert MaterialItemModel to JSON', () {
      final model = MaterialItemModel(
        id: 'item1',
        code: 'MT001',
        name: 'Vật tư 1',
        unit: 'Cái',
        quantityDocument: 10,
        quantityReceived: 8,
        unitPrice: 100000.0,
        totalPrice: 800000.0,
        index: 1,
      );

      final json = model.toJson();

      expect(json['id'], 'item1');
      expect(json['code'], 'MT001');
      expect(json['name'], 'Vật tư 1');
      expect(json['unit'], 'Cái');
      expect(json['quantityDocument'], 10);
      expect(json['quantityReceived'], 8);
      expect(json['unitPrice'], 100000.0);
      expect(json['totalPrice'], 800000.0);
      expect(json['index'], 1);
    });

    test('should convert MaterialItemModel to Entity', () {
      final model = MaterialItemModel(
        id: 'item1',
        code: 'MT001',
        name: 'Vật tư 1',
        unit: 'Cái',
        quantityDocument: 10,
        quantityReceived: 8,
        unitPrice: 100000.0,
        totalPrice: 800000.0,
        index: 1,
      );

      final entity = model.toEntity();

      expect(entity, isA<MaterialItem>());
      expect(entity.id, 'item1');
      expect(entity.code, 'MT001');
      expect(entity.name, 'Vật tư 1');
      expect(entity.unit, 'Cái');
      expect(entity.quantityDocument, 10);
      expect(entity.quantityReceived, 8);
      expect(entity.unitPrice, 100000.0);
      expect(entity.totalPrice, 800000.0);
      expect(entity.index, 1);
    });

    test('should create MaterialItemModel from Entity', () {
      final entity = MaterialItem(
        id: 'item1',
        code: 'MT001',
        name: 'Vật tư 1',
        unit: 'Cái',
        quantityDocument: 10,
        quantityReceived: 8,
        unitPrice: 100000.0,
        totalPrice: 800000.0,
        index: 1,
      );

      final model = MaterialItemModel.fromEntity(entity);

      expect(model.id, 'item1');
      expect(model.code, 'MT001');
      expect(model.name, 'Vật tư 1');
      expect(model.unit, 'Cái');
      expect(model.quantityDocument, 10);
      expect(model.quantityReceived, 8);
      expect(model.unitPrice, 100000.0);
      expect(model.totalPrice, 800000.0);
      expect(model.index, 1);
    });

    test('should handle null values in JSON', () {
      final json = {
        'code': 'MT001',
        'name': 'Vật tư 1',
        'unit': 'Cái',
        'quantityDocument': 10,
        'quantityReceived': 8,
        'unitPrice': 100000.0,
        'totalPrice': 800000.0,
        'index': 1,
      };

      final model = MaterialItemModel.fromJson(json, 'item1');

      expect(model.id, isNull);
      expect(model.code, 'MT001');
    });

    test('equality should work correctly', () {
      final model1 = MaterialItemModel(
        id: 'item1',
        code: 'MT001',
        name: 'Vật tư 1',
        unit: 'Cái',
        quantityDocument: 10,
        quantityReceived: 8,
        unitPrice: 100000.0,
        totalPrice: 800000.0,
        index: 1,
      );

      final model2 = MaterialItemModel(
        id: 'item1',
        code: 'MT001',
        name: 'Vật tư 1',
        unit: 'Cái',
        quantityDocument: 10,
        quantityReceived: 8,
        unitPrice: 100000.0,
        totalPrice: 800000.0,
        index: 1,
      );

      final model3 = MaterialItemModel(
        id: 'item2',
        code: 'MT002',
        name: 'Vật tư 2',
        unit: 'Hộp',
        quantityDocument: 5,
        quantityReceived: 5,
        unitPrice: 50000.0,
        totalPrice: 250000.0,
        index: 2,
      );

      expect(model1, equals(model2));
      expect(model1, isNot(equals(model3)));
    });

    test('hashCode should be consistent with equality', () {
      final model1 = MaterialItemModel(
        id: 'item1',
        code: 'MT001',
        name: 'Vật tư 1',
        unit: 'Cái',
        quantityDocument: 10,
        quantityReceived: 8,
        unitPrice: 100000.0,
        totalPrice: 800000.0,
        index: 1,
      );

      final model2 = MaterialItemModel(
        id: 'item1',
        code: 'MT001',
        name: 'Vật tư 1',
        unit: 'Cái',
        quantityDocument: 10,
        quantityReceived: 8,
        unitPrice: 100000.0,
        totalPrice: 800000.0,
        index: 1,
      );

      expect(model1.hashCode, equals(model2.hashCode));
    });

    test('toString should return meaningful representation', () {
      final model = MaterialItemModel(
        id: 'item1',
        code: 'MT001',
        name: 'Vật tư 1',
        unit: 'Cái',
        quantityDocument: 10,
        quantityReceived: 8,
        unitPrice: 100000.0,
        totalPrice: 800000.0,
        index: 1,
      );

      final stringRepresentation = model.toString();

      expect(stringRepresentation, contains('MaterialItemModel'));
      expect(stringRepresentation, contains('item1'));
      expect(stringRepresentation, contains('MT001'));
      expect(stringRepresentation, contains('Vật tư 1'));
    });
  });
}
