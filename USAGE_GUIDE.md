# Hướng dẫn sử dụng VIMES App

## 📋 Cách sử dụng

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
