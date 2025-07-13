import 'package:flutter_test/flutter_test.dart';
import 'package:vimes_app/domain/entities/material_item.dart';

void main() {
  group('MaterialItem Entity Tests', () {
    test('should create MaterialItem with all required fields', () {
      const materialItem = MaterialItem(
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

      expect(materialItem.id, 'item1');
      expect(materialItem.code, 'MT001');
      expect(materialItem.name, 'Vật tư 1');
      expect(materialItem.unit, 'Cái');
      expect(materialItem.quantityDocument, 10);
      expect(materialItem.quantityReceived, 8);
      expect(materialItem.unitPrice, 100000.0);
      expect(materialItem.totalPrice, 800000.0);
      expect(materialItem.index, 1);
    });

    test('should create MaterialItem without id', () {
      const materialItem = MaterialItem(
        code: 'MT001',
        name: 'Vật tư 1',
        unit: 'Cái',
        quantityDocument: 10,
        quantityReceived: 8,
        unitPrice: 100000.0,
        totalPrice: 800000.0,
        index: 1,
      );

      expect(materialItem.id, isNull);
      expect(materialItem.code, 'MT001');
    });

    test('copyWith should create new instance with updated fields', () {
      const original = MaterialItem(
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

      final updated = original.copyWith(
        name: 'Vật tư 1 Updated',
        quantityReceived: 9,
        totalPrice: 900000.0,
        index: 2,
      );

      expect(updated.id, 'item1');
      expect(updated.code, 'MT001');
      expect(updated.name, 'Vật tư 1 Updated');
      expect(updated.unit, 'Cái');
      expect(updated.quantityDocument, 10);
      expect(updated.quantityReceived, 9);
      expect(updated.unitPrice, 100000.0);
      expect(updated.totalPrice, 900000.0);
      expect(updated.index, 2);
    });

    test('copyWith should keep original values when not specified', () {
      const original = MaterialItem(
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

      final updated = original.copyWith(name: 'Vật tư 1 Updated');

      expect(updated.id, 'item1');
      expect(updated.code, 'MT001');
      expect(updated.name, 'Vật tư 1 Updated');
      expect(updated.unit, 'Cái');
      expect(updated.quantityDocument, 10);
      expect(updated.quantityReceived, 8);
      expect(updated.unitPrice, 100000.0);
      expect(updated.totalPrice, 800000.0);
      expect(updated.index, 1);
    });

    test('equality should work correctly', () {
      const item1 = MaterialItem(
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

      const item2 = MaterialItem(
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

      const item3 = MaterialItem(
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

      expect(item1, equals(item2));
      expect(item1, isNot(equals(item3)));
    });

    test('hashCode should be consistent with equality', () {
      const item1 = MaterialItem(
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

      const item2 = MaterialItem(
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

      expect(item1.hashCode, equals(item2.hashCode));
    });

    test('toString should return meaningful representation', () {
      const item = MaterialItem(
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

      final stringRepresentation = item.toString();

      expect(stringRepresentation, contains('MaterialItem'));
      expect(stringRepresentation, contains('item1'));
      expect(stringRepresentation, contains('MT001'));
      expect(stringRepresentation, contains('Vật tư 1'));
    });
  });
}
