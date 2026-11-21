# Báo cáo sơ lược TaskFlow

> Ngày viết: 21/11/2026
> Thành viên: Lý Huỳnh Thắng (B2306582), Nguyễn Tuấn Vũ (B2306602)
> Học phần: CT484-01

## 1. Tổng quan

TaskFlow là ứng dụng Flutter quản lý công việc cá nhân trên Android. Dữ liệu
lưu cục bộ bằng SQLite; theme và thời gian nhắc mặc định lưu bằng
`SharedPreferences`. Ứng dụng có luồng công việc, danh mục, thống kê, cài đặt
và điều hướng theo kiến trúc phân lớp.

## 2. Kiến trúc

Luồng dữ liệu chính là:

```text
Widget/UI
  -> ChangeNotifier Provider
  -> Repository
  -> SQLite hoặc SharedPreferences
```

`lib/main.dart` là entry point. Nó tải settings trước, khởi tạo notification
service và chạy `TaskFlowApp`. `lib/app.dart` đăng ký các provider cấp ứng dụng
bằng `MultiProvider` và lắp ghép theme/router bằng `MaterialApp.router`.

- Widget không chứa SQL.
- Provider quản lý loading/error và điều phối thao tác CRUD.
- Repository thực hiện truy vấn dữ liệu.
- `DatabaseHelper` cung cấp kết nối SQLite dùng chung.

## 3. Schema SQLite

Database tên `taskflow.db`, version 1, gồm bảng `categories` và `tasks`.

### categories

- `id`: khóa chính tự tăng.
- `name`: chuỗi bắt buộc, duy nhất.
- `color`: màu ARGB kiểu số nguyên, nullable.
- `created_at`: thời gian tạo ISO 8601.

### tasks

- `id`: khóa chính tự tăng.
- `title`: chuỗi bắt buộc.
- `description`: nội dung, nullable.
- `due_at`: hạn công việc ISO 8601, nullable.
- `priority`: 1 thấp, 2 vừa, 3 cao.
- `is_completed`: 0 chưa hoàn thành, 1 đã hoàn thành.
- `category_id`: khóa ngoại tới `categories.id`, nullable.
- `reminder_at`: thời điểm nhắc ISO 8601, nullable.
- `created_at`, `updated_at`: thời gian ISO 8601.

Khóa ngoại được bật bằng `PRAGMA foreign_keys = ON`. Khi danh mục bị xóa,
SQLite áp dụng `ON DELETE SET NULL`, giữ task nhưng xóa liên kết danh mục.
Database helper có hook `onUpgrade` cho migration ở các version database sau.

## 4. Công việc

Phần công việc có model, repository, provider, danh sách, form thêm/sửa, chi tiết
và route theo ID.

- Tạo, đọc, sửa, xóa và đánh dấu hoàn thành task.
- Validation tiêu đề không được chỉ có khoảng trắng.
- Hỗ trợ task không hạn và không nhắc.
- Tìm kiếm/lọc theo trạng thái, danh mục và hạn.
- Có trạng thái loading, empty, error và xác nhận trước khi xóa.
- Local notification được nối theo vòng đời thêm/sửa/xóa/hoàn thành.

## 5. Danh mục

`CategoryRepository` thực hiện CRUD SQLite; `CategoryProvider` giữ danh mục dùng
chung cho giao diện.

- Giao diện grid responsive, tối đa 4 cột.
- Thêm/sửa bằng dialog, xóa có xác nhận.
- Hiển thị số task thuộc danh mục.
- Có loading, empty, error và retry.
- Xóa danh mục không xóa task liên quan; `category_id` thành `NULL`.

## 6. Thống kê

`StatsRepository` truy vấn trực tiếp SQLite để lấy:

- Tổng số công việc.
- Số đã hoàn thành.
- Số chưa hoàn thành.
- Tỷ lệ hoàn thành.
- Thống kê bảy ngày thứ Hai đến Chủ nhật trong tuần hiện tại.

Biểu đồ cột được xây bằng Flutter thuần. Vì schema chưa lưu thời điểm hoàn
thành, thống kê theo ngày thể hiện trạng thái hiện tại của task có `due_at`
trong ngày đó; không suy diễn task thực sự hoàn thành đúng ngày.

## 7. Cài đặt

`SettingsProvider` lưu:

- Theme `system`, `light` hoặc `dark`.
- Số phút nhắc trước hạn; mặc định 15 phút, 0 phút nghĩa là nhắc đúng hạn.

Giá trị được lưu bằng `SharedPreferences`, load lại ở lần mở app và cung cấp
trạng thái loading/error cho giao diện.

## 8. Điều hướng và theme

Ứng dụng dùng `go_router` với các route:

- `/tasks`
- `/tasks/new`
- `/tasks/:id`
- `/tasks/:id/edit`
- `/categories`
- `/statistics`
- `/settings`

Shell chung dùng drawer, bottom navigation, app bar và nút thêm. Route task nhận
ID dưới dạng `int`; ID không hợp lệ hoặc không tồn tại được xử lý ở màn chi tiết.
Theme sáng/tối dùng `AppTheme.light` và `AppTheme.dark`.

## 9. Android và build

- Tên ứng dụng Android: `TaskFlow`.
- Package hiện tại: `com.example.ct484project`.
- Đã cấu hình splash, icon launcher và quyền thông báo/rung.
- Debug APK build thành công.
- APK đã cài bằng `adb install -r` trên Samsung Galaxy A12 (SM-A125F).
- App process khởi động thành công và đã lưu ảnh màn hình kiểm thử Ngày 17.
- Release thực tế cần đổi application ID khỏi namespace scaffold mẫu.

## 10. Kiểm thử

Kết quả đã xác nhận:

- Full suite tuần tự hiện tại: 42/42 test passed.
- `flutter analyze --no-pub`: không có vấn đề.
- Cold-reopen SQLite cho task/category.
- Khôi phục theme và thời gian nhắc bằng provider mới.
- Khóa ngoại và `ON DELETE SET NULL`.
- CRUD danh mục bằng widget test.
- Chuyển theme sáng/tối và điều hướng shell.
- Build và cài APK trên thiết bị Android.

Còn lại:

- Notification phát thật foreground/background chưa xác nhận.
- Trường hợp người dùng từ chối notification chưa kiểm chứng end-to-end.
- Chưa lưu bộ ảnh demo Ngày 19 và chưa hoàn tất diễn tập/nghiệm thu Ngày 21.

## 11. Kết luận

Dự án đã hoàn thành phần lớn P0/P1 theo kế hoạch: kiến trúc
Provider/Repository, SQLite, Task/Category CRUD, thống kê, cài đặt, điều hướng,
build và cài Android đều có bằng chứng tự động hoặc chạy thiết bị. Notification
là phần còn cần kiểm thử runtime; demo, báo cáo và ảnh minh chứng là phần còn
lại trước nghiệm thu Ngày 21.