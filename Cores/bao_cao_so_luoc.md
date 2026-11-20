# Báo cáo sơ lược TaskFlow

**Ngày cập nhật:** 20/11/2026  
**Phạm vi:** kiến trúc ứng dụng, schema/database, danh mục, thống kê, cài đặt
và điều hướng.

## 1. Tổng quan kiến trúc

TaskFlow là ứng dụng Flutter quản lý công việc, lưu dữ liệu cục bộ trên thiết
bị. Mã nguồn chia thành `core/` cho các thành phần dùng chung và `features/`
cho từng chức năng. Các feature chính gồm `tasks`, `categories`, `statistics`
và `settings`; mỗi feature tổ chức phần giao diện, trạng thái và truy cập dữ
liệu theo nhu cầu.

Luồng xử lý dữ liệu chính:

```text
UI (Flutter widgets)
    → Provider (ChangeNotifier)
        → Repository
            → SQLite hoặc SharedPreferences
```

- [`main.dart`](../../../26-27hk1-ct48401-project-vub2306602/lib/main.dart)
  khởi tạo Flutter, đọc cài đặt đã lưu và khởi tạo dịch vụ nhắc việc trước khi
  chạy giao diện. Lỗi khởi tạo được báo qua Flutter error reporting; app vẫn
  được khởi chạy để người dùng có thể tiếp tục thao tác.
- [`app.dart`](../../../26-27hk1-ct48401-project-vub2306602/lib/app.dart) là
  composition root: đăng ký `SettingsProvider`, `CategoryProvider`,
  `StatsProvider`, `TaskProvider` bằng `MultiProvider`, rồi cấu hình
  `MaterialApp.router`, theme sáng/tối và router.
- Repository nhận database có thể được inject để kiểm thử; khi chạy ứng dụng,
  repository mặc định dùng `DatabaseHelper` dùng chung.

## 2. Database và hợp đồng dữ liệu

Ứng dụng dùng SQLite qua `sqflite`. Database tên `taskflow.db`, schema hiện ở
version 1 và được mở khi repository cần truy cập. Chi tiết DDL và quy ước ngày
giờ nằm trong [`schema.md`](./schema.md); phần cài đặt ở
[`database_helper.dart`](../../../26-27hk1-ct48401-project-vub2306602/lib/core/database/database_helper.dart).

Schema có hai bảng:

| Bảng | Dữ liệu chính |
|---|---|
| `categories` | `id`, `name` (không rỗng, duy nhất), `color` tùy chọn và `created_at` |
| `tasks` | tiêu đề, mô tả tùy chọn, hạn, mức ưu tiên, trạng thái hoàn thành, danh mục tùy chọn, thời điểm nhắc và các mốc tạo/cập nhật |

Các ràng buộc chính:

- Mức ưu tiên chỉ nhận `1`, `2` hoặc `3`; trạng thái hoàn thành chỉ nhận `0`
  hoặc `1`.
- `tasks.category_id` tham chiếu `categories.id`; khóa ngoại được bật khi mở
  database. Xóa danh mục đặt liên kết của task thành `NULL`, không xóa task.
- Mốc ngày giờ được lưu dưới dạng ISO 8601. Các repository chuyển đổi dữ liệu
  giữa SQLite map và model.
- Khi thay đổi schema đã phát hành, cần tăng database version và viết migration
  để bảo toàn dữ liệu người dùng.

## 3. Danh mục

`CategoryRepository` đọc, thêm, sửa và xóa dữ liệu trong bảng `categories`.
Tên được trim trước khi ghi; danh sách sắp xếp không phân biệt hoa/thường.
`CategoryProvider` giữ danh sách cho giao diện, thông báo trạng thái loading/lỗi
và cập nhật danh sách trong bộ nhớ sau thao tác CRUD. Giao diện quản lý danh
mục hiển thị danh sách, số công việc theo danh mục, form CRUD và xác nhận
trước khi xóa.

Quan hệ danh mục-task được bảo vệ ở database. Khi xóa danh mục đang được task
sử dụng, task vẫn được giữ lại và `category_id` trở thành `NULL`. Hành vi này
được kiểm tra bằng repository test; phần CRUD/trạng thái giao diện cũng có
test riêng.

## 4. Thống kê

`StatsRepository` tính tổng số công việc, số đã hoàn thành và số chưa hoàn
thành trực tiếp từ bảng `tasks`. Tỷ lệ hoàn thành bằng 0 khi chưa có công
việc, tránh chia cho 0. Thống kê theo tuần tính từ thứ Hai đến Chủ nhật, nhóm
theo ngày đến hạn; ngày không có công việc trả về giá trị 0 và task không có
hạn không nằm trong biểu đồ.

`StatsProvider` tải số liệu tổng quan và tuần cho
[`StatisticsPage`](../../../26-27hk1-ct48401-project-vub2306602/lib/core/router/app_pages.dart).
Màn hình có trạng thái đang tải, lỗi kèm thao tác thử lại, kéo để tải lại và
thông báo khi chưa có dữ liệu. Biểu đồ tuần được dựng bằng widget Flutter,
không phụ thuộc package biểu đồ ngoài.

**Giới hạn diễn giải:** schema hiện không lưu thời điểm hoàn thành riêng.
Vì vậy số công việc hoàn thành trong biểu đồ tuần là trạng thái hiện tại của
các task có hạn trong ngày đó, không cho biết task đã hoàn thành vào chính
ngày đó hay chưa.

## 5. Cài đặt

`SettingsProvider` lưu các tùy chọn qua `SharedPreferences`:

- Theme: `system`, `light` hoặc `dark`; mặc định là theo hệ thống nếu chưa có
  giá trị lưu.
- Thời gian nhắc trước hạn mặc định: 15 phút; giá trị không được âm.

Cài đặt được đọc trước khi dựng app và được cung cấp cho toàn bộ cây widget.
Khi lưu thất bại, provider giữ lỗi và ném lỗi để giao diện có thể thông báo
thay vì báo thành công giả. Theme sáng/tối và việc giữ lựa chọn sau khi khởi
động lại đã được kiểm tra trong test cài đặt và trên thiết bị ở các lượt kiểm
thử trước.

Dịch vụ thông báo cục bộ được khởi tạo khi app bắt đầu và gắn với vòng đời
công việc. Tuy nhiên, phát thông báo thực tế trong các tình huống foreground,
background và quyền Android vẫn cần kiểm tra end-to-end trên thiết bị.

## 6. Điều hướng

Điều hướng dùng `go_router`. `/` chuyển về `/tasks`; các route chính:

| Chức năng | Path |
|---|---|
| Danh sách công việc | `/tasks` |
| Tạo công việc | `/tasks/new` |
| Chi tiết công việc | `/tasks/:id` |
| Sửa công việc | `/tasks/:id/edit` |
| Danh mục | `/categories` |
| Thống kê | `/statistics` |
| Cài đặt | `/settings` |

Các màn chính dùng chung `TaskFlowShell`, gồm app bar, drawer và thanh điều
hướng dưới. Màn tạo/chi tiết/sửa công việc nằm trong nhánh route task; nút
quay lại trở về route trước đó hoặc danh sách khi không có route để pop. Các
route dùng chuyển cảnh fade kết hợp slide nhẹ.

Router và shell được kiểm tra bằng widget test; theme, settings và các luồng
danh mục cũng có test tập trung. Kết quả gần nhất được ghi trong
[`checkpoint.md`](./checkpoint.md): 31 widget test đạt ở lượt Ngày 15, các
test danh mục và navigation/theme/settings đạt ở lượt Ngày 16, analyzer
không phát hiện vấn đề ở những lượt kiểm tra đó.

## 7. Trạng thái kiểm chứng và việc còn lại

- Ngày 19, database trên SM A125F qua `PRAGMA integrity_check`; dữ liệu demo
  gồm 4 danh mục và 3 công việc, không có task tham chiếu danh mục không tồn
  tại. Theme sáng được lưu và mở lại đúng.
- Build/cài thử Android và kết quả kiểm thử chi tiết được theo dõi trong
  [`checkpoint.md`](./checkpoint.md).
- Cần tiếp tục kiểm tra thông báo trên thiết bị ở foreground/background và
  quyền thông báo; chưa xem đây là luồng end-to-end đã nghiệm thu.
- Trước buổi demo, cần biên tập nội dung nháp của công việc đầu tiên trong dữ
  liệu demo; ghi chú cụ thể ở checkpoint Ngày 19.
