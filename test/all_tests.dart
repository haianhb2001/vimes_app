import 'package:flutter_test/flutter_test.dart';
import 'unit/core/either_test.dart' as either_test;
import 'unit/core/failures_test.dart' as failures_test;
import 'unit/core/currency_formatter_test.dart' as currency_formatter_test;
import 'unit/domain/entities/material_item_test.dart' as material_item_test;
import 'unit/domain/entities/warehouse_receipt_test.dart' as warehouse_receipt_test;
import 'unit/data/models/material_item_model_test.dart' as material_item_model_test;
import 'unit/domain/usecases/get_warehouse_receipts_test.dart' as get_warehouse_receipts_test;
import 'unit/presentation/blocs/warehouse_receipt_bloc_test.dart' as warehouse_receipt_bloc_test;

void main() {
  group('Core Layer Tests', () {
    either_test.main();
    failures_test.main();
    currency_formatter_test.main();
  });

  group('Domain Layer Tests', () {
    material_item_test.main();
    warehouse_receipt_test.main();
    get_warehouse_receipts_test.main();
  });

  group('Data Layer Tests', () {
    material_item_model_test.main();
  });

  group('Presentation Layer Tests', () {
    warehouse_receipt_bloc_test.main();
  });
}
