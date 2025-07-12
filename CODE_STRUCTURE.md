# Cấu Trúc Code

## Tổng Quan

Ứng dụng đã được tối ưu hóa bằng cách chia nhỏ các màn hình thành các widget con riêng biệt, giúp code sạch hơn, dễ maintain và tái sử dụng.

## Cấu Trúc Thư Mục

```
lib/
├── models/
│   └── phieu_nhap_kho.dart          # Data models
├── screens/
│   ├── phieu_nhap_kho_screen.dart   # Form tạo phiếu (đã tối ưu)
│   ├── phieu_nhap_kho_list_screen.dart  # Danh sách phiếu (đã tối ưu)
│   └── phieu_nhap_kho_detail_screen.dart # Chi tiết phiếu (đã tối ưu)
├── services/
│   └── firebase_service.dart        # Firebase operations
└── widgets/
    ├── required_text_field.dart     # Text field với validation
    ├── required_date_field.dart     # Date field với validation
    ├── general_info_section.dart    # Phần thông tin chung
    ├── material_input_section.dart  # Phần nhập vật tư
    ├── material_list_section.dart   # Phần danh sách vật tư
    ├── material_section_card.dart   # Card bọc phần vật tư
    ├── form_actions.dart            # Các nút hành động
    ├── search_bar_widget.dart       # Thanh tìm kiếm
    ├── phieu_list_item.dart         # Item trong danh sách
    ├── empty_state_widget.dart      # Trạng thái trống
    ├── error_state_widget.dart      # Trạng thái lỗi
    ├── info_row_widget.dart         # Dòng thông tin
    └── material_detail_card.dart    # Card chi tiết vật tư
```

## Các Widget Con Đã Tạo

### 1. Form Widgets

#### `GeneralInfoSection`

- **Mục đích**: Hiển thị phần thông tin chung của phiếu nhập kho
- **Props**: Các TextEditingController cho từng trường
- **Tái sử dụng**: Có thể dùng cho form tạo và chỉnh sửa

#### `MaterialInputSection`

- **Mục đích**: Phần nhập thông tin vật tư mới
- **Props**: Controllers và callbacks cho thêm/xóa trắng
- **Tái sử dụng**: Có thể dùng cho form tạo và chỉnh sửa

#### `MaterialListSection`

- **Mục đích**: Hiển thị danh sách vật tư đã thêm
- **Props**: List vật tư, tổng tiền, callbacks
- **Tái sử dụng**: Có thể dùng cho form và chi tiết

#### `MaterialSectionCard`

- **Mục đích**: Card bọc toàn bộ phần vật tư
- **Props**: Kết hợp MaterialInputSection và MaterialListSection
- **Tái sử dụng**: Chỉ dùng cho form tạo

#### `FormActions`

- **Mục đích**: Các nút hành động (Lưu, Làm mới)
- **Props**: Callbacks và trạng thái loading
- **Tái sử dụng**: Có thể dùng cho nhiều form khác

### 2. List Widgets

#### `SearchBarWidget`

- **Mục đích**: Thanh tìm kiếm
- **Props**: Hint text, callback onChanged, giá trị ban đầu
- **Tái sử dụng**: Có thể dùng cho nhiều màn hình danh sách

#### `PhieuListItem`

- **Mục đích**: Item trong danh sách phiếu nhập kho
- **Props**: PhieuNhapKho object, callbacks, format functions
- **Tái sử dụng**: Có thể dùng cho danh sách khác

#### `EmptyStateWidget`

- **Mục đích**: Hiển thị khi không có dữ liệu
- **Props**: Icon, message, colors
- **Tái sử dụng**: Có thể dùng cho nhiều màn hình

#### `ErrorStateWidget`

- **Mục đích**: Hiển thị khi có lỗi
- **Props**: Error message, retry callback
- **Tái sử dụng**: Có thể dùng cho nhiều màn hình

### 3. Detail Widgets

#### `InfoRowWidget`

- **Mục đích**: Hiển thị một dòng thông tin (label: value)
- **Props**: Label, value, styles, width
- **Tái sử dụng**: Có thể dùng cho nhiều màn hình chi tiết

#### `MaterialDetailCard`

- **Mục đích**: Card hiển thị chi tiết một vật tư
- **Props**: ChiTietVatTu object
- **Tái sử dụng**: Có thể dùng cho form và chi tiết

## Lợi Ích Của Việc Tối Ưu

### 1. **Tính Tái Sử Dụng**

- Các widget con có thể được sử dụng ở nhiều nơi khác nhau
- Giảm code trùng lặp
- Dễ dàng thay đổi UI một cách nhất quán

### 2. **Dễ Maintain**

- Mỗi widget có trách nhiệm riêng biệt
- Dễ debug và sửa lỗi
- Code ngắn gọn, dễ đọc

### 3. **Hiệu Suất**

- Widget con chỉ rebuild khi cần thiết
- Giảm thời gian build cho các widget lớn
- Tối ưu memory usage

### 4. **Khả Năng Mở Rộng**

- Dễ dàng thêm tính năng mới
- Có thể tạo các biến thể của widget
- Dễ dàng thay đổi UI/UX

## Cách Sử Dụng

### 1. Import Widget

```dart
import '../widgets/general_info_section.dart';
```

### 2. Sử Dụng Trong Build Method

```dart
GeneralInfoSection(
  unitController: _unitController,
  departmentController: _departmentController,
  // ... other controllers
),
```

### 3. Truyền Callbacks

```dart
FormActions(
  onSave: _luuPhieu,
  onReset: _resetForm,
  isLoading: _isLoading,
),
```

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

## Kết Luận

Việc tối ưu hóa code bằng cách chia nhỏ thành các widget con đã mang lại nhiều lợi ích:

1. **Code sạch hơn**: Mỗi widget có trách nhiệm rõ ràng
2. **Dễ maintain**: Dễ debug và sửa lỗi
3. **Tái sử dụng cao**: Có thể dùng ở nhiều nơi
4. **Hiệu suất tốt**: Tối ưu rebuild và memory
5. **Khả năng mở rộng**: Dễ thêm tính năng mới

Cấu trúc này tạo nền tảng vững chắc cho việc phát triển và maintain ứng dụng trong tương lai.
