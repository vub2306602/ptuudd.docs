# Tiêu chí đánh giá và nghiệm thu dự án TaskFlow

Tài liệu này chuyển các tiêu chí đánh giá của môn học thành yêu cầu có thể
triển khai và kiểm chứng cho TaskFlow. Dùng tài liệu làm cơ sở khi giao việc,
viết code, review và nghiệm thu. Nếu yêu cầu môn học hoặc giảng viên cập nhật,
ưu tiên yêu cầu mới và cập nhật tài liệu này.

## 1. Phạm vi dự án

TaskFlow là ứng dụng Flutter quản lý công việc, gồm công việc, danh mục, thống
kê và cài đặt. Ưu tiên luồng nghiệp vụ cốt lõi, chạy ổn định và lưu dữ liệu qua
các lần mở ứng dụng. Các ý tưởng streak, điểm thưởng, tài khoản/đăng nhập và
mạng xã hội không thuộc phạm vi bắt buộc, trừ khi nhóm thống nhất bổ sung.

Schema SQLite version 1 gồm hai bảng `tasks` và `categories`, được mô tả trong
[`schema.md`](./schema.md) và đã được tạo bởi database helper. Việc tích hợp
CRUD task/category vào toàn bộ giao diện vẫn đang được triển khai.

## 2. Tiêu chí đánh giá và cách nghiệm thu

### 2.1. Thiết kế giao diện bằng Flutter widgets

**Yêu cầu**

- Có ít nhất **6 màn hình giao diện riêng biệt**, gắn với quy trình nghiệp vụ:
  1. Danh sách công việc.
  2. Form thêm công việc.
  3. Chi tiết công việc.
  4. Form sửa công việc (có thể dùng chung widget với form thêm).
  5. Quản lý danh mục.
  6. Thống kê.
  7. Cài đặt.
- Giao diện dùng widget phù hợp và đa dạng, chẳng hạn `Scaffold`, `AppBar`,
  `ListView`/`GridView`, `Card`, `Form`, `TextFormField`, `DropdownButton`,
  `Checkbox`/`Switch`, `SnackBar`, dialog, icon và nút tương tác.
- Có phản hồi cho trạng thái tải, lỗi, danh sách rỗng và thao tác thành công
  hoặc thất bại khi phù hợp.
- Bố cục responsive cơ bản: nội dung không tràn hoặc bị cắt trên kích thước
  màn hình mục tiêu; form và danh sách có thể sử dụng được trên màn hình hẹp.
- Có nhắc việc bằng **local notification hoặc push notification**. Với phạm vi
  TaskFlow, ưu tiên local notification theo hạn công việc; xin quyền khi nền
  tảng yêu cầu và hủy/cập nhật lịch nhắc khi task bị sửa, xóa hoặc hoàn thành.

**Nghiệm thu**

- Đếm được tối thiểu 6 màn hình nghiệp vụ truy cập được trong ứng dụng.
- Tạo và cập nhật công việc qua form; có validation tiêu đề bắt buộc.
- Giao diện danh sách thể hiện thông tin task cần thiết và có empty state.
- Kiểm tra bố cục ít nhất trên một kích thước màn hình nhỏ và một kích thước
  phổ biến; không có overflow cản trở thao tác.
- Có thể đặt một lịch nhắc và xác nhận luồng quyền/lịch nhắc trên thiết bị hoặc
  môi trường hỗ trợ. Nếu môi trường không hỗ trợ, ghi rõ giới hạn kiểm thử.

### 2.2. Điều hướng giữa các trang

**Yêu cầu**

- Dùng `go_router` cho điều hướng chính (có thể kết hợp Navigator API khi cần).
- Các trang chính có route rõ ràng và có thể mở được; màn chưa triển khai có
  thể dùng placeholder tạm trong giai đoạn phát triển.
- Luồng công việc hỗ trợ danh sách → tạo/sửa → chi tiết và quay lại phù hợp.
- Truyền/nhận dữ liệu khi điều hướng; route chi tiết và sửa nhận `id` công việc,
  xử lý trường hợp ID không tồn tại.
- Tùy chỉnh chuyển cảnh ở mức nhất quán, không làm mất trạng thái hoặc gây khó
  sử dụng chức năng back.

**Route đề xuất**

| Tên | Path | Mục đích |
|---|---|---|
| `tasks` | `/tasks` | Danh sách công việc và trang khởi đầu |
| `task-create` | `/tasks/new` | Thêm công việc |
| `task-detail` | `/tasks/:id` | Chi tiết công việc |
| `task-edit` | `/tasks/:id/edit` | Sửa công việc |
| `categories` | `/categories` | Quản lý danh mục |
| `statistics` | `/statistics` | Thống kê công việc |
| `settings` | `/settings` | Cài đặt ứng dụng |

**Nghiệm thu**

- Mở được các trang chính qua điều hướng trong app.
- Tạo task xong trở lại danh sách thấy dữ liệu mới; mở chi tiết đúng task được
  chọn; thao tác back hoạt động.
- Các nút/chuyển hướng không dẫn tới route lỗi hoặc màn hình trắng.

### 2.3. Quản lý trạng thái và kiến trúc ứng dụng

**Yêu cầu**

- Dùng một giải pháp quản lý trạng thái nhất quán. Lựa chọn cho MVP là
  `Provider`/`ChangeNotifier`; không trộn nhiều thư viện state management nếu
  không có lý do rõ ràng.
- Phân tách trách nhiệm theo luồng **UI → Provider → Repository → SQLite**.
  Widget không chứa SQL; state cục bộ chỉ dùng cho dữ liệu tạm thời của giao
  diện, không thay thế nguồn dữ liệu dùng chung.
- `main.dart` là entry point gọi `runApp`; `app.dart` lắp ghép app, theme,
  router và provider cấp ứng dụng.
- Repository xử lý truy cập dữ liệu; Provider điều phối tải/thêm/sửa/xóa/hoàn
  thành và cung cấp trạng thái loading/error cho UI.
- Giữ tên cột, kiểu dữ liệu, nullability và quy ước chuyển đổi model thống nhất
  theo [`schema.md`](./schema.md).

**Nghiệm thu**

- Có thể lần theo luồng thao tác UI đến provider/repository/database.
- CRUD và hoàn thành task cập nhật trạng thái giao diện nhất quán.
- Lỗi đọc/ghi không bị nuốt im lặng; UI nhận được trạng thái lỗi phù hợp.
- Mã nguồn phân lớp rõ, không lặp logic truy cập database trong nhiều màn hình.

### 2.4. Cập nhật và lưu trạng thái/dữ liệu qua các lần chạy

**Yêu cầu**

- Lưu task và category cục bộ bằng SQLite theo schema đã thống nhất.
- Task hỗ trợ tạo, đọc, sửa, xóa, đánh dấu hoàn thành; category hỗ trợ CRUD.
- Quan hệ `tasks.category_id` tham chiếu category; khi xóa category, task còn
  lại và bỏ liên kết danh mục theo chính sách trong schema.
- Dữ liệu vẫn còn sau khi đóng và mở lại ứng dụng.
- Các tùy chọn như theme hoặc thời gian nhắc mặc định được lưu bền vững bằng
  `shared_preferences` hoặc giải pháp đã thống nhất; không bắt buộc tạo thêm
  bảng cho các tùy chọn này.
- Thời gian nhắc mặc định được biểu diễn bằng số phút trước hạn công việc; giá
  trị ban đầu là 15 phút và 0 phút nghĩa là nhắc đúng thời điểm đến hạn.
- Thay đổi schema sau khi đã có dữ liệu phải có version và migration; không xóa
  dữ liệu để né migration.

**Nghiệm thu**

- Tạo/sửa/xóa task và category; khởi động lại ứng dụng rồi xác nhận dữ liệu còn
  và phản ánh đúng thay đổi.
- Thử task không có category, các trường nullable và xóa category đang được
  task sử dụng.
- Thử lưu rồi khởi động lại để xác nhận cài đặt được giữ nguyên.
- Có kiểm thử repository/database cho CRUD và các quy tắc dữ liệu quan trọng.

### 2.5. Tùy biến và triển khai ứng dụng

**Yêu cầu**

- Có giao diện và theme nhất quán; hỗ trợ tùy chọn sáng/tối nếu nằm trong cấu
  hình nhóm đã chốt.
- Cấu hình tên ứng dụng, icon/branding và quyền nền tảng cần thiết cho tính
  năng đã triển khai, đặc biệt là thông báo.
- Ứng dụng chạy được trên thiết bị/emulator mục tiêu; có thể build bản Android
  để demo và báo cáo.
- Hướng dẫn cách cài dependency, chạy ứng dụng và build bản demo phải được cập
  nhật trong tài liệu dự án.

**Nghiệm thu**

- `flutter pub get`, phân tích Dart và test liên quan chạy thành công.
- Chạy app trên emulator hoặc thiết bị mục tiêu; kiểm tra luồng chính.
- Tạo được bản build Android dùng cho demo; ghi nhận lỗi/giới hạn môi trường nếu
  chưa thể xác nhận trên thiết bị thật.

## 3. Quy tắc cho các yêu cầu và thay đổi tiếp theo

- Dùng tiêu chí trong tài liệu này làm chuẩn mặc định cho các yêu cầu triển
  khai TaskFlow; không tự mở rộng phạm vi ngoài các mục trên nếu chưa được yêu
  cầu.
- Trước khi sửa, kiểm tra trạng thái mã nguồn để phân biệt chức năng đã có,
  đang làm và mới là kế hoạch.
- Khi có nhiều lựa chọn ảnh hưởng kiến trúc, ưu tiên giải pháp đơn giản nhất
  đáp ứng tiêu chí và tương thích với code hiện tại; hỏi nhóm nếu quyết định làm
  thay đổi hợp đồng/schema hoặc ảnh hưởng dữ liệu.
- Mỗi thay đổi cần cập nhật kiểm thử và tài liệu liên quan, đồng thời chạy
  kiểm tra phù hợp với phạm vi thay đổi.
- Không ghi một tiêu chí là hoàn thành nếu chưa có mã nguồn hoặc bằng chứng
  kiểm thử/chạy ứng dụng tương ứng.

## 4. Trạng thái tiêu chí

**Trạng thái hiện tại theo repository ngày 10/11/2026:** entry point TaskFlow,
router, Provider, SQLite version 1, CRUD Task/Category, danh sách/form/chi tiết
Task và lưu cài đặt theme/thời gian nhắc đã có trong mã nguồn. Thống kê vẫn dùng
số liệu mẫu; local notification chưa được triển khai. Chưa xác nhận build, chạy
trên thiết bị hay persistence bằng lần khởi động lại trong lần cập nhật này; các
widget test hiện có còn kỳ vọng màn task placeholder và cần đồng bộ. Các điều
khoản khác ở tài liệu này vẫn là tiêu chí mục tiêu cho tới khi có bằng chứng
nghiệm thu tương ứng.
