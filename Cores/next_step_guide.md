# Next-step guide — phân công chi tiết 21 ngày cho TaskFlow

> TaskFlow là ứng dụng **quản lý công việc**. Ảnh Habit Tracker chỉ là tham khảo thiết kế: màu pastel, thẻ bo góc, trang tổng quan theo ngày, lưới danh mục, lịch và thẻ tiến độ. Không xây dữ liệu/lịch lặp Habit, habit logs, streak hay điểm xu trong phạm vi bắt buộc. Tham khảo [đặc tả giao diện](thiet-ke-giao-dien.md), [phân công tổng quan](phan-cong-3-tuan.md), [checkpoint](checkpoint.md).
>
> Codebase làm việc: `26-27hk1-ct48401-labs-thangb2306582`. Đã có Flutter Android/iOS, `lib/models`, `lib/services`, `lib/ui`, Provider, GoRouter, theme, drawer, `path`, `sqflite`, `shared_preferences`, `intl`. Đây là app bán hàng; cần tách luồng products/cart/orders khỏi entry flow. SQLite hiện chỉ lưu `cart_items`, không tái sử dụng cho tasks.

## 1. Phân công và quyền sở hữu

| Người | Phạm vi | File/thư mục đề xuất |
|---|---|---|
| SV-A | Công việc: CRUD, trang chủ/danh sách, form, chi tiết, tìm kiếm/lọc, nhắc việc, responsive danh sách-chi tiết | `lib/models/task.dart`; service/repository riêng trong `lib/services/`; `lib/ui/tasks/` |
| SV-B | Danh mục, thống kê, cài đặt/theme, điều hướng/drawer, tùy biến nhận diện | `lib/models/category.dart`; service/repository thống kê/danh mục trong `lib/services/`; `lib/ui/categories/`, `lib/ui/statistics/`, `lib/ui/settings/`, `lib/ui/shared/app_drawer.dart` |
| Cả hai | Database entry/schema, tích hợp route/provider, tách màn shop khỏi app đích, review, build, báo cáo/demo | `lib/main.dart`, `pubspec.yaml`, database service, drawer và các file dùng chung |

Chỉ một người phụ trách mỗi feature. `main.dart`, `pubspec.yaml`, database entry và drawer cần phối hợp qua PR tích hợp; không tạo lại `app.dart`, router hay provider tree vì GoRouter/MultiProvider đã có trong `main.dart`.

## 2. Hợp đồng dữ liệu

Chốt trong ngày 1–2 trước khi viết repository. Hợp đồng theo kế hoạch TaskFlow:

- `categories`: `id`, `name`, `color`, `icon`.
- `tasks`: `id`, `title`, `description`, `category_id`, `priority` (0 thấp, 1 vừa, 2 cao), `due_date` (ISO 8601), `remind_before`, `is_done`, `created_at`, `completed_at`.
- Thống nhất nullability, timezone của `due_date`, cách xử lý task không có category và cách xóa category (đặt `category_id = NULL`).
- Database mới có version/migration riêng; không đổi hoặc dùng bảng `cart_items` làm bảng tasks.

## 3. Kế hoạch ngày 1–21

### Ngày 1 — kiểm kê và xác nhận phạm vi (cùng làm)

- Chạy app labs, ghi lại luồng auth/products/cart/orders và xác nhận build baseline.
- Chốt **TaskFlow quản lý công việc**; dùng ảnh Habit Tracker làm tham chiếu hình ảnh, không đổi domain.
- SV-A liệt kê luồng tạo → xem → sửa → hoàn thành/xóa công việc.
- SV-B liệt kê trang chủ, danh mục, thống kê, cài đặt, drawer và các route.
- Quyết định phần auth/shop nào ẩn hoặc tách khỏi entry flow; không xóa code/dữ liệu gốc khi chưa cần.
- **Bàn giao:** danh sách P0/P1/P2, chủ sở hữu file và người review.

### Ngày 2 — schema và tích hợp nền (cùng làm)

- Chốt schema `tasks`/`categories`, route, query/provider contract và cách dùng ngày giờ.
- SV-A chốt API repository: CRUD, danh sách theo ngày/trạng thái, tìm kiếm/lọc, hoàn thành.
- SV-B chốt API category, truy vấn thống kê và settings.
- Nối route và providers mới vào GoRouter/MultiProvider hiện tại; chuyển entry/navigation khỏi shop.
- Chỉ thêm packages còn thiếu nếu được thống nhất: notification/timezone, `fl_chart` hoặc lịch. Không thêm lại provider/router/sqlite/path/preferences/intl đã có.
- **Bàn giao:** app chạy sau tích hợp; schema/API và quyền sở hữu file được ghi trong commit.

### Ngày 3 — dữ liệu SQLite

- **SV-A:** tạo `Task` model và `TaskRepository` CRUD, map ngày ISO/null.
- **SV-B:** tạo `Category` model/repository CRUD; phối hợp database service riêng với schema hai bảng.
- **Cùng làm:** review database version, index, foreign key và seed categories mặc định.
- **Bàn giao:** có thể tạo/đọc task và category; dữ liệu không nằm trong bảng cart.

### Ngày 4 — Provider và cài đặt

- **SV-A:** `TaskProvider` tải/thêm/sửa/xóa/hoàn thành, loading/error và cập nhật danh sách.
- **SV-B:** `CategoryProvider` CRUD; `SettingsProvider` lưu theme và thời gian nhắc mặc định qua preferences.
- **Bàn giao:** thay đổi state hiện lên UI; category/settings tồn tại sau khi mở lại app.

### Ngày 5 — trang chủ và hệ thống giao diện

- **SV-A:** dựng trang chủ TaskFlow theo cảm hứng ảnh: lời chào/ngày, nút thêm, chip lọc, nhóm Hôm nay/Ngày mai/Trong tuần, tiến độ hoàn thành.
- **SV-B:** định nghĩa palette pastel, typography, spacing, card/button tokens trong ThemeData hiện có; điều chỉnh drawer cho Công việc, Danh mục, Thống kê, Cài đặt.
- **Bàn giao:** ảnh trang chủ/drawer; trạng thái task thể hiện bằng chữ/icon ngoài màu.

### Ngày 6 — form công việc và danh mục

- **SV-A:** form thêm/sửa: tiêu đề, mô tả, category, hạn ngày/giờ, ưu tiên, nhắc trước; validate và lưu thật.
- **SV-B:** grid danh mục theo ảnh: card màu/icon, tên, số task; dialog thêm/sửa/xóa có xác nhận.
- **Bàn giao:** form đọc categories từ repository; xóa category đưa liên kết task về null.

### Ngày 7 — chi tiết và cài đặt

- **SV-A:** màn chi tiết, sửa/xóa/đánh dấu hoàn thành, kết quả điều hướng trả về danh sách.
- **SV-B:** màn cài đặt theme sáng/tối và giờ nhắc mặc định; kiểm tra persist.
- **Cả hai:** review chéo, ghi checkpoint tuần 1 và ảnh.
- **Gate tuần 1:** CRUD/persistence task và category; trang chủ, form, chi tiết, danh mục, cài đặt chạy.

### Ngày 8 — tìm kiếm và thống kê truy vấn

- **SV-A:** tìm kiếm tiêu đề, lọc theo category/trạng thái/ưu tiên; nút xóa lọc.
- **SV-B:** `StatsRepository` đọc SQLite trực tiếp: tổng, hoàn thành, chưa hoàn thành/quá hạn, tiến độ theo tuần; xử lý database rỗng.
- **Bàn giao:** số liệu đối chiếu được với dữ liệu mẫu.

### Ngày 9 — notification và màn thống kê

- **SV-A:** tích hợp notification service, quyền runtime, timezone và đặt reminder theo due date.
- **SV-B:** `StatsProvider`, cards tổng quan, loading/error/empty states.
- **Cả hai:** kiểm tra tương thích Android; lên lịch thử trên thiết bị thật.

### Ngày 10 — nối vòng đời task và biểu đồ

- **SV-A:** thêm/sửa/xóa/hoàn thành phải tạo/cập nhật/hủy reminder đúng; tránh notification trùng hoặc nhắc task đã xong.
- **SV-B:** biểu đồ tuần bằng `fl_chart` nếu đã thêm dependency; hiển thị số liệu có nghĩa và nhãn dễ đọc.
- **Bàn giao:** reminder khớp trạng thái task; biểu đồ dựa trên SQLite thật.

### Ngày 11 — tương tác và trạng thái màn hình

- **SV-A:** Dismissible hoặc menu xóa có xác nhận, hoàn tác/feedback; empty state cho danh sách rỗng.
- **SV-B:** polish loading/error/empty, dialog, drawer và chuyển trang.
- **Cả hai:** review PR chéo và sửa regression trước việc phụ.

### Ngày 12 — responsive và so với ảnh

- **SV-A:** kiểm tra trang chủ/form/chi tiết ở màn hẹp/rộng; danh sách + chi tiết hai pane khi phù hợp.
- **SV-B:** kiểm tra grid category và biểu đồ; điều chỉnh cột/padding/card theo kích thước.
- **Cả hai:** chụp ảnh app, so với ảnh demo ở bố cục/màu, lập danh sách chỉnh sửa ưu tiên.

### Ngày 13 — lịch công việc và tích hợp giao điểm

- **SV-A:** thêm màn chọn ngày/lịch công việc nếu package/thời gian cho phép; đảm bảo chọn ngày lọc đúng task.
- **SV-B:** hỗ trợ route/lịch hoặc hoàn thiện stats/settings; chỉ làm lịch khi P0/P1 ổn.
- **Cả hai:** kiểm tra category trong form, xóa category, báo cáo stats và dark mode.

### Ngày 14 — tích hợp tuần 2 (cùng làm)

- Merge PR vào nhánh ổn định; xử lý lỗi build/route/database trước.
- Chạy luồng: tạo category → tạo task có hạn/nhắc → sửa → hoàn thành → xem thống kê → đổi theme.
- Tạo bug list P0/P1/P2 kèm người xử lý và hạn.
- **Gate tuần 2:** luồng chính chạy trên emulator; không mất dữ liệu, crash hoặc reminder lỗi nghiêm trọng.

### Ngày 15 — sửa lỗi theo vùng

- **SV-A:** sửa task, tìm kiếm/lọc và reminder theo bug list.
- **SV-B:** sửa category, stats, settings, theme/navigation.
- **Cả hai:** review regression sau mỗi PR sửa lỗi.

### Ngày 16 — thiết bị thật và nhận diện

- **SV-A:** thử notification foreground/background; ghi Android version, quyền và kết quả.
- **SV-B:** đổi tên/icon/splash nếu phạm vi yêu cầu; kiểm tra theme/drawer trên thiết bị.
- **Cả hai:** không thêm feature/dependency mới nếu có nguy cơ ảnh hưởng build.

### Ngày 17 — APK cài thử

- **SV-A:** chạy lại CRUD, lọc, hoàn thành và reminder trên APK.
- **SV-B:** kiểm tra categories, thống kê, settings, persistence và responsive trên APK.
- **Cả hai:** build/cài APK theo yêu cầu môn, lưu artifact và commit.

### Ngày 18 — báo cáo cá nhân

- **SV-A:** viết model/schema task, CRUD, lọc, reminder; chụp màn phần mình.
- **SV-B:** viết category, stats, settings, theme/navigation; chụp màn phần mình.
- Ghi rõ đóng góp, cách kiểm tra và giới hạn thực tế.

### Ngày 19 — ghép báo cáo

- Cùng ghép kiến trúc, schema, phân công, kết quả, ảnh và hướng phát triển.
- Đối chiếu tiêu chí môn học; bổ sung bằng chứng thiếu.
- Xác nhận báo cáo dùng đúng phiên bản app và APK.

### Ngày 20 — demo và hỏi đáp chéo

- Tập demo 5–7 phút bằng dữ liệu ổn định.
- SV-A giải thích categories/stats/settings; SV-B giải thích tasks/reminders/database.
- Sửa lỗi demo chặn và đóng băng phạm vi.

### Ngày 21 — nghiệm thu và nộp

- Cùng chạy checklist cuối; kiểm tra APK, báo cáo, commit/tag và vị trí nộp.
- Demo end-to-end và xác nhận mỗi người hiểu phần của người kia.
- Ghi commit cuối, người xác nhận và thời điểm nộp trong `checkpoint.md`.

## 4. Nhịp làm việc hằng ngày

1. Đầu ngày: cập nhật nhánh ổn định, xác nhận task và người review.
2. Trong ngày: chỉ làm vùng sở hữu; file chung đi qua PR tích hợp.
3. Cuối ngày: format, xem diff, chạy kiểm tra phù hợp, commit nhỏ, cập nhật checkpoint.
4. Họp nhanh 10 phút: hôm qua, hôm nay, điểm nghẽn; báo nguy cơ trễ ngay khi phát hiện.

```text
Ngày / Sinh viên:
Task và trạng thái:
Commit/PR:
Đã chạy trên / kết quả:
Ảnh hoặc bằng chứng:
Vướng mắc / cần hỗ trợ:
Việc tiếp theo:
```

## 5. Nguyên tắc tích hợp

- `main.dart`, `pubspec.yaml`, database entry và drawer là vùng chung; thống nhất người sửa trước mỗi PR.
- Không tạo `app.dart`, router, provider tree hoặc Flutter project mới khi codebase đã có composition tương ứng.
- Không tái sử dụng PocketBase products/orders hoặc bảng `cart_items` cho TaskFlow.
- Đổi schema cần cả hai đồng ý, database version/migration rõ ràng; không xóa database để né migration.
- Mức lỗi: P0 app không chạy/mất dữ liệu; P1 luồng chính hỏng; P2 chức năng phụ/UI; P3 polish.
