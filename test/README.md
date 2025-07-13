# Unit Tests cho Vimes App

Dự án này sử dụng Clean Architecture và có các unit tests được tổ chức theo từng layer.

## Cấu trúc Tests

```
test/
├── all_tests.dart                    # File chạy tất cả tests
├── unit/                            # Unit tests theo layer
│   ├── core/                        # Tests cho Core Layer
│   │   ├── either_test.dart         # Tests cho Either type
│   │   ├── failures_test.dart       # Tests cho Failure classes
│   │   └── currency_formatter_test.dart # Tests cho CurrencyFormatter
│   ├── domain/                      # Tests cho Domain Layer
│   │   ├── entities/                # Tests cho Entities
│   │   │   ├── material_item_test.dart
│   │   │   └── warehouse_receipt_test.dart
│   │   └── usecases/                # Tests cho Use Cases
│   │       └── get_warehouse_receipts_test.dart
│   ├── data/                        # Tests cho Data Layer
│   │   └── models/                  # Tests cho Data Models
│   │       └── material_item_model_test.dart
│   └── presentation/                # Tests cho Presentation Layer
│       └── blocs/                   # Tests cho BLoCs
│           └── warehouse_receipt_bloc_test.dart
└── README.md                        # File này
```

## Cách chạy Tests

### Chạy tất cả tests:

```bash
flutter test test/all_tests.dart
```

### Chạy tests theo layer:

**Core Layer:**

```bash
flutter test test/unit/core/
```

**Domain Layer:**

```bash
flutter test test/unit/domain/
```

**Data Layer:**

```bash
flutter test test/unit/data/
```

**Presentation Layer:**

```bash
flutter test test/unit/presentation/
```

### Chạy test cụ thể:

```bash
flutter test test/unit/core/either_test.dart
```

## Mô tả Tests

### Core Layer Tests

- **Either Tests**: Kiểm tra Either type để xử lý success/failure
- **Failures Tests**: Kiểm tra các loại failure khác nhau
- **Currency Formatter Tests**: Kiểm tra việc format tiền tệ VNĐ

### Domain Layer Tests

- **Entity Tests**: Kiểm tra các entity (MaterialItem, WarehouseReceipt)
- **Use Case Tests**: Kiểm tra business logic trong use cases

### Data Layer Tests

- **Model Tests**: Kiểm tra việc chuyển đổi giữa JSON và Model

### Presentation Layer Tests

- **BLoC Tests**: Kiểm tra state management với BLoC pattern

## Dependencies

Tests sử dụng các package sau:

- `flutter_test`: Framework testing của Flutter
- `mockito`: Tạo mock objects
- `build_runner`: Generate mock classes
- `bloc_test`: Testing cho BLoC (tùy chọn)

## Best Practices

1. **Test Structure**: Sử dụng AAA pattern (Arrange, Act, Assert)
2. **Mocking**: Sử dụng mock objects để isolate units
3. **Naming**: Tên test rõ ràng, mô tả behavior
4. **Coverage**: Đảm bảo test coverage cho business logic quan trọng
5. **Maintainability**: Tests dễ đọc và maintain

## Ví dụ Test

```dart
test('should create MaterialItem with all required fields', () {
  // Arrange
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

  // Assert
  expect(materialItem.code, 'MT001');
  expect(materialItem.name, 'Vật tư 1');
  expect(materialItem.totalPrice, 800000.0);
});
```

## Continuous Integration

Tests sẽ được chạy tự động trong CI/CD pipeline để đảm bảo code quality và prevent regression.
