# Vimes Warehouse Receipts App

Ứng dụng Flutter quản lý phiếu nhập kho, kết nối Firebase Firestore, được tái cấu trúc theo mô hình Clean Architecture.

## Tính năng chính

- Tạo, xem, tìm kiếm, xóa phiếu nhập kho
- Thêm/xóa vật tư cho từng phiếu
- Lưu trữ dữ liệu trên Firestore
- Giao diện đẹp, dễ sử dụng
- Kiến trúc Clean Architecture với BLoC pattern

## Cấu trúc Clean Architecture

```
lib/
├── core/                           # Core layer - Shared utilities
│   ├── constants/
│   │   └── app_constants.dart      # App constants, messages
│   ├── errors/
│   │   └── failures.dart           # Failure classes for error handling
│   ├── utils/
│   │   ├── either.dart             # Either type for functional programming
│   │   └── currency_formatter.dart # Format số tiền VND
│   └── di/
│       └── injection_container.dart # Dependency injection container
├── domain/                         # Domain layer - Business logic
│   ├── entities/
│   │   ├── warehouse_receipt.dart  # Warehouse receipt entity
│   │   └── material_item.dart      # Material item entity
│   ├── repositories/
│   │   └── warehouse_receipt_repository.dart # Repository interface
│   └── usecases/
│       └── warehouse_receipt_usecases.dart   # Business logic use cases
├── data/                           # Data layer - Data management
│   ├── models/
│   │   ├── warehouse_receipt_model.dart # Data model with JSON serialization
│   │   └── material_item_model.dart     # Data model with JSON serialization
│   ├── datasources/
│   │   ├── warehouse_receipt_remote_data_source.dart      # Data source interface
│   │   └── warehouse_receipt_remote_data_source_impl.dart # Firebase implementation
│   ├── repositories/
│   │   └── warehouse_receipt_repository_impl.dart         # Repository implementation
│   └── services/
│       └── firebase_service.dart   # Firebase operations (legacy)
└── presentation/                   # Presentation layer - UI
    ├── screens/
    │   ├── warehouse_receipt_form_screen.dart   # Form tạo phiếu
    │   ├── warehouse_receipt_list_screen.dart   # Danh sách phiếu
    │   └── warehouse_receipt_detail_screen.dart # Chi tiết phiếu
    ├── widgets/
    │   ├── required_text_field.dart        # Text field với validation
    │   ├── required_date_field.dart        # Date field với validation
    │   ├── general_info_section.dart       # Phần thông tin chung
    │   ├── material_input_section.dart     # Phần nhập vật tư
    │   ├── material_list_section.dart      # Phần danh sách vật tư
    │   ├── material_section_card.dart      # Card bọc phần vật tư
    │   ├── form_actions.dart               # Các nút hành động
    │   ├── search_bar_widget.dart          # Thanh tìm kiếm
    │   ├── receipt_list_item.dart          # Item trong danh sách
    │   ├── empty_state_widget.dart         # Trạng thái trống
    │   ├── error_state_widget.dart         # Trạng thái lỗi
    │   ├── info_row_widget.dart            # Dòng thông tin
    │   └── material_detail_card.dart       # Card chi tiết vật tư
    └── blocs/
        └── warehouse_receipt_bloc.dart     # State management với BLoC
```

## Kiến trúc Clean Architecture

### 1. **Core Layer** - Shared utilities

- **Constants**: App constants, validation messages, error messages
- **Errors**: Failure classes (ServerFailure, NetworkFailure, etc.)
- **Utils**: Either type, currency formatter, shared utilities
- **DI**: Dependency injection container

### 2. **Domain Layer** - Business logic

- **Entities**: Pure business objects (WarehouseReceipt, MaterialItem)
- **Repositories**: Abstract interfaces for data access
- **Use Cases**: Business logic operations

### 3. **Data Layer** - Data management

- **Models**: Data models with JSON serialization
- **Data Sources**: Abstract and concrete data sources
- **Repository Implementations**: Concrete implementations of repositories

### 4. **Presentation Layer** - UI

- **Screens**: Main UI screens
- **Widgets**: Reusable UI components
- **BLoCs**: State management with events and states

## State Management với BLoC

### Events

- `LoadWarehouseReceipts`: Tải danh sách phiếu
- `SearchWarehouseReceipts`: Tìm kiếm phiếu
- `AddWarehouseReceiptEvent`: Thêm phiếu mới
- `UpdateWarehouseReceiptEvent`: Cập nhật phiếu
- `DeleteWarehouseReceiptEvent`: Xóa phiếu
- `LoadItemsByReceiptId`: Tải danh sách vật tư
- `UpdateItemsEvent`: Cập nhật vật tư

### States

- `WarehouseReceiptInitial`: Trạng thái ban đầu
- `WarehouseReceiptLoading`: Đang tải
- `WarehouseReceiptLoaded`: Đã tải thành công
- `WarehouseReceiptDetailLoaded`: Chi tiết phiếu
- `WarehouseReceiptError`: Lỗi
- `WarehouseReceiptSuccess`: Thành công

## Error Handling

### Failure Types

- `ServerFailure`: Lỗi server/Firebase
- `NetworkFailure`: Lỗi kết nối mạng
- `CacheFailure`: Lỗi cache
- `ValidationFailure`: Lỗi validation
- `UnknownFailure`: Lỗi không xác định

### Either Type

Sử dụng `Either<Failure, Success>` để xử lý kết quả một cách type-safe:

```dart
final result = await repository.getWarehouseReceiptById(id);
result.fold(
  (failure) => emit(WarehouseReceiptError(failure.message)),
  (receipt) => emit(WarehouseReceiptDetailLoaded(receipt)),
);
```

## Dependency Injection

Sử dụng `InjectionContainer` để quản lý dependencies:

```dart
// Data Sources
WarehouseReceiptRemoteDataSource get warehouseReceiptRemoteDataSource

// Repositories
WarehouseReceiptRepository get warehouseReceiptRepository

// Use Cases
GetWarehouseReceiptList get getWarehouseReceiptList
AddWarehouseReceipt get addWarehouseReceipt
// ... other use cases
```

## Hướng dẫn sử dụng

### 1. Tạo phiếu nhập kho mới

#### Bước 1: Điền thông tin chung

- **Đơn vị**: Tên công ty/đơn vị
- **Phòng ban**: Bộ phận thực hiện
- **Ngày nhập kho**: Ngày thực hiện nhập kho
- **Số phiếu**: Mã số phiếu nhập kho
- **Tài khoản Nợ/Có**: Mã tài khoản kế toán
- **Người giao hàng**: Người cung cấp vật tư
- **Người nhận hàng**: Người nhận tại kho
- **Thủ kho**: Người quản lý kho
- **Số chứng từ gốc**: Mã chứng từ từ nhà cung cấp
- **Ngày chứng từ gốc**: Ngày trên chứng từ gốc
- **Tổ chức tham chiếu**: Đơn vị cung cấp
- **Loại tham chiếu**: Loại chứng từ (HD, PXK, etc.)
- **Số lượng chứng từ gốc**: Số tờ chứng từ kèm theo
- **Người tạo**: Người lập phiếu
- **Người phê duyệt**: Người duyệt phiếu

#### Bước 2: Thêm vật tư

- **Mã vật tư**: Mã sản phẩm/vật tư
- **Tên vật tư**: Tên đầy đủ sản phẩm
- **Đơn vị**: Đơn vị tính (Cái, Hộp, Kg, etc.)
- **SL theo chứng từ**: Số lượng trên chứng từ gốc
- **SL thực nhận**: Số lượng thực tế nhận được
- **Đơn giá**: Giá một đơn vị (VNĐ)

#### Bước 3: Lưu phiếu

- Nhấn "Lưu phiếu nhập kho"
- Hệ thống sẽ kiểm tra và lưu vào Firebase
- Hiển thị thông báo thành công với ID phiếu

### 2. Quản lý danh sách vật tư

#### Thêm vật tư

1. Điền đầy đủ thông tin vật tư
2. Nhấn "Thêm vật tư"
3. Vật tư sẽ xuất hiện trong danh sách
4. Các trường vật tư được giữ nguyên để thêm tiếp hoặc chỉnh sửa

#### Xóa trắng trường vật tư

- Nhấn "Xóa trắng" để clear tất cả trường vật tư
- Thông tin chung không bị ảnh hưởng

#### Xóa vật tư đã thêm

- Nhấn icon "🗑️" bên cạnh vật tư
- Vật tư sẽ bị xóa khỏi danh sách

### 3. Validation và thông báo

#### Thông báo lỗi

- **Trường bắt buộc**: "Vui lòng điền đầy đủ thông tin bắt buộc"
- **Thiếu vật tư**: "Vui lòng thêm ít nhất một vật tư"
- **Thông tin vật tư**: "Vui lòng điền đầy đủ thông tin vật tư"
- **Số lượng không hợp lệ**: "Số lượng phải là số dương"
- **Đơn giá không hợp lệ**: "Đơn giá phải là số dương"

#### Thông báo thành công

- **Thêm vật tư**: "Đã thêm vật tư: [Tên vật tư]"
- **Xóa trắng**: "Đã xóa trắng các trường vật tư"
- **Lưu phiếu**: "Đã lưu phiếu nhập kho thành công"

#### Smart Validation

- **Tự động clear lỗi**: Khi focus vào field có lỗi, lỗi sẽ tự động biến mất
- **Real-time validation**: Kiểm tra ngay khi người dùng nhập liệu
- **Visual feedback**: Border thay đổi màu sắc theo trạng thái (normal/focus/error)
- **Focus management**: Tự động quản lý focus và clear lỗi

## Format số tiền VND

- Sử dụng util `CurrencyFormatter` để hiển thị số tiền đúng chuẩn Việt Nam:

```dart
import 'utils/currency_formatter.dart';

final amount = 1234567.0;
print(CurrencyFormatter.formatVND(amount)); // 1.234.567
print(CurrencyFormatter.formatVNDWithUnit(amount)); // 1.234.567 VNĐ
```

- Tất cả các nơi hiển thị tiền trong app đều đã sử dụng format này.

## Hướng dẫn chạy

1. Cài đặt Flutter, clone repo, chạy `flutter pub get`
2. Thêm file cấu hình Firebase (`google-services.json` cho Android, `GoogleService-Info.plist` cho iOS)
3. Chạy app: `flutter run`

## Best Practices

### 1. **Naming Convention**

- Widget names: PascalCase (e.g., `GeneralInfoSection`)
- File names: snake_case (e.g., `general_info_section.dart`)

### 2. **Props Design**

- Sử dụng `required` cho props bắt buộc
- Cung cấp default values cho props tùy chọn
- Sử dụng callback functions thay vì direct method calls

### 3. **State Management**

- Widget con nên là StatelessWidget khi có thể
- Truyền state từ parent widget
- Sử dụng callbacks để thông báo thay đổi

### 4. **Error Handling**

- Sử dụng `ErrorStateWidget` cho error states
- Cung cấp retry functionality khi cần

## Đóng góp

PR, issue, góp ý đều được chào đón!

---

**Vimes App - Quản lý phiếu nhập kho chuyên nghiệp, hiện đại, dễ sử dụng.**
