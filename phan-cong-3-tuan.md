# KẾ HOẠCH 3 TUẦN: 2 SINH VIÊN LÀM ĐỘC LẬP (TASKFLOW)

> Bổ sung cho `project.md`. Thời gian: **21 ngày**.
> Nguyên tắc: **chia theo tính năng (vertical slice)**. Mỗi người tự làm trọn một nhóm tính năng, từ giao diện, điều hướng, trạng thái đến SQLite. Hai người **không sửa chung file** nên không xung đột, và **cả hai đều code đủ mọi tầng**.

---

## 1. Vì sao chia theo tính năng thay vì theo tầng

| Cách cũ (chia theo tầng) | Cách mới (chia theo tính năng) |
|---|---|
| Người này làm UI, người kia làm dữ liệu | Mỗi người làm cả UI + dữ liệu cho phần của mình |
| SV-A phải chờ SV-B (phải dùng mock data) | Không phải chờ nhau, mỗi người có dữ liệu thật ngay |
| Dễ sửa chung file → xung đột Git | Mỗi người một thư mục riêng → gần như không xung đột |
| Một người chỉ biết UI, người kia chỉ biết CSDL | Cả hai đều làm widget, điều hướng, state, SQLite → trả lời vấn đáp được cả 5 tiêu chí |

---

## 2. Phân chia tính năng

### 🟦 SV-A: Tính năng **Công việc** + **Thông báo**

| Hạng mục | Nội dung |
|---|---|
| Màn hình (3) | Danh sách công việc, Thêm/Sửa công việc, Chi tiết công việc |
| Dữ liệu | Model `Task`, bảng `tasks` (CRUD), `TaskRepository` |
| Trạng thái | `TaskProvider` (tải, thêm, sửa, xóa, hoàn thành, lọc, tìm kiếm) |
| Điều hướng | Các route `/task/*`: truyền `id` / `extra`, nhận kết quả trả về, `CustomTransitionPage` |
| Thông báo | `NotificationService` (đặt/hủy/cập nhật nhắc nhở theo vòng đời công việc) |
| Responsive | Danh sách + chi tiết song song trên màn hình rộng |
| Triển khai | Build APK, cài và chạy thử trên thiết bị thật |

### 🟩 SV-B: Tính năng **Danh mục**, **Thống kê**, **Cài đặt**

| Hạng mục | Nội dung |
|---|---|
| Màn hình (4) | Splash, Quản lý danh mục (`GridView`), Thống kê (`fl_chart`), Cài đặt |
| Dữ liệu | Model `Category`, bảng `categories` (CRUD), `CategoryRepository`, `StatsRepository` (truy vấn tổng hợp), `shared_preferences` |
| Trạng thái | `CategoryProvider`, `SettingsProvider`, `StatsProvider` |
| Điều hướng | Khung `ShellRoute` + `BottomNavigationBar`, các route `/categories`, `/stats`, `/settings`, hiệu ứng chuyển trang |
| Giao diện chung | Theme sáng/tối, bảng màu (cung cấp cho cả nhóm) |
| Responsive | Lưới danh mục và biểu đồ thích ứng màn hình |
| Tùy biến | Đổi tên app, `flutter_launcher_icons`, `flutter_native_splash` |

> **Cân bằng khối lượng:** SV-A làm 3 màn hình lớn có nhiều logic (form, thông báo, lọc). SV-B làm 4 màn hình nhẹ hơn cộng khung ứng dụng, theme và tùy biến. Nếu tuần 2 SV-B xong sớm, nhận thêm màn **Lịch** (`table_calendar`) để giảm tải cho SV-A.

---

## 3. Cấu trúc thư mục và quyền sở hữu

```
lib/
├── main.dart                     ← 🔒 CHUNG (đóng băng sau ngày 2)
├── app.dart                      ← 🔒 CHUNG (đóng băng sau ngày 2)
├── core/                         ← 🔒 CHUNG (đóng băng sau ngày 2)
│   ├── router/app_router.dart        # khai báo SẴN tất cả route
│   ├── database/database_helper.dart # tạo SẴN cả 2 bảng
│   └── theme/                        # SV-B hoàn thiện giá trị màu
└── features/
    ├── tasks/                    ← 🟦 CHỈ SV-A sửa
    │   ├── data/ (task.dart, task_repository.dart)
    │   ├── providers/task_provider.dart
    │   ├── notifications/notification_service.dart
    │   └── ui/ (screens/, widgets/)
    ├── categories/               ← 🟩 CHỈ SV-B sửa
    │   ├── data/ (category.dart, category_repository.dart)
    │   ├── providers/category_provider.dart
    │   └── ui/
    ├── statistics/               ← 🟩 CHỈ SV-B sửa
    │   ├── data/stats_repository.dart
    │   ├── providers/stats_provider.dart
    │   └── ui/
    └── settings/                 ← 🟩 CHỈ SV-B sửa
        ├── providers/settings_provider.dart
        └── ui/
```

**Quy tắc vàng:**
1. Chỉ sửa file trong thư mục `features/` **của mình**.
2. Muốn sửa file 🔒 CHUNG → báo người kia, làm một PR nhỏ riêng và **cả hai đồng ý** mới merge.
3. Được **đọc** dữ liệu của người kia nhưng **chỉ ghi** vào bảng của mình.

---

## 4. Bước chung ở ngày 1-2: dựng "bộ khung" rồi đóng băng

Đây là bước **duy nhất** hai người làm chung. Làm xong thì mỗi người tách ra làm riêng, và đây cũng là nguồn xung đột chính nên phải làm kỹ.

- [ ] Tạo repo GitHub, project Flutter, thống nhất quy tắc commit
- [ ] **`pubspec.yaml`: thêm TẤT CẢ thư viện cần dùng một lần** (`go_router`, `provider`, `sqflite`, `path`, `shared_preferences`, `flutter_local_notifications`, `timezone`, `fl_chart`, `intl`, ...), tránh sau này hai người cùng sửa file này
- [ ] `database_helper.dart`: tạo sẵn **cả hai bảng** (`tasks`, `categories`), thêm dữ liệu danh mục mặc định
- [ ] `app_router.dart`: khai báo **tất cả route** trỏ tới màn hình tạm (`Placeholder`), mỗi màn hình tạm nằm trong file của người sở hữu
- [ ] `app.dart`: đăng ký sẵn **toàn bộ Provider** (`MultiProvider`) bằng lớp rỗng; mỗi người sau đó chỉ viết nội dung bên trong lớp của mình
- [ ] `main.dart`: gọi sẵn `NotificationService.init()` (lớp rỗng của SV-A)
- [ ] Hai người cùng viết `Task` và `Category` (tên cột, kiểu dữ liệu) theo bảng ở mục 6

Sau ngày 2: **commit "skeleton-done", đóng băng các file 🔒 CHUNG.**

---

## 5. Lịch theo ngày (mỗi cột làm độc lập)

### 📅 TUẦN 1: Dựng nền và chức năng lõi (ngày 1-7)

| Ngày | 🟦 SV-A (Công việc) | 🟩 SV-B (Danh mục / Thống kê / Cài đặt) |
|---|---|---|
| 1-2 | **Cùng nhau:** dựng bộ khung (mục 4) | |
| 3 | `Task`, `TaskRepository` (CRUD SQLite) | `Category`, `CategoryRepository` (CRUD SQLite) |
| 4 | `TaskProvider` (tải/thêm/sửa/xóa/hoàn thành) | `CategoryProvider`, `SettingsProvider` (`shared_preferences`) |
| 5 | Màn Danh sách (`ListView`, `TaskTile`, tab lọc) | Theme sáng/tối, Splash, khung `BottomNavigationBar` + `ShellRoute` |
| 6 | Màn Thêm/Sửa (form, DatePicker, TimePicker) | Màn Danh mục (`GridView`, dialog thêm/sửa/xóa) |
| 7 | Màn Chi tiết + truyền dữ liệu qua route | Màn Cài đặt (bật/tắt dark mode, thời gian nhắc mặc định) |

**🎯 Cuối tuần 1:** mỗi người có tính năng của mình chạy với dữ liệu thật. **Nộp báo cáo tiến độ.**

### 📅 TUẦN 2: Hoàn thiện tính năng (ngày 8-14)

| Ngày | 🟦 SV-A | 🟩 SV-B |
|---|---|---|
| 8 | Lọc + tìm kiếm (trong `TaskProvider`) | `StatsRepository`: truy vấn SQL tổng hợp (đọc bảng `tasks`) |
| 9 | `NotificationService`: khởi tạo, xin quyền, đặt thông báo | `StatsProvider` + màn Thống kê (số liệu tổng quan) |
| 10 | Gắn thông báo vào thêm/sửa/xóa/hoàn thành công việc | Biểu đồ `fl_chart` (tiến độ theo tuần) |
| 11 | Hiệu ứng chuyển trang tùy biến, `Dismissible` + xác nhận xóa | Hiệu ứng chuyển trang tùy biến, trạng thái rỗng/lỗi các màn của mình |
| 12 | Responsive: danh sách + chi tiết 2 cột trên màn hình rộng | Responsive: lưới danh mục, thống kê |
| 13 | Dropdown danh mục trong form (đọc từ bảng `categories`) | (Nếu rảnh) màn Lịch `table_calendar` |
| 14 | **Cùng nhau:** ghép, chạy thử toàn bộ, lập danh sách lỗi | |

**🎯 Cuối tuần 2:** đủ chức năng, chạy trọn vẹn trên máy ảo.

### 📅 TUẦN 3: Hoàn thiện, triển khai, báo cáo (ngày 15-21)

| Ngày | 🟦 SV-A | 🟩 SV-B |
|---|---|---|
| 15 | Sửa lỗi phần Công việc / Thông báo | Sửa lỗi phần Danh mục / Thống kê / Cài đặt |
| 16 | Kiểm thử thông báo trên thiết bị thật | Đổi tên app, icon (`flutter_launcher_icons`), splash native |
| 17 | Build APK, cài và chạy thử trên thiết bị thật | Dọn code, chú thích, đặt tên nhất quán |
| 18 | Viết báo cáo: tính năng Công việc, thông báo | Viết báo cáo: danh mục, thống kê, cài đặt, tùy biến |
| 19 | **Cùng nhau:** ghép báo cáo, chụp màn hình, đối chiếu tiêu chí | |
| 20 | **Cùng nhau:** tập demo, hỏi đáp chéo (mỗi người giải thích code của người kia) | |
| 21 | **Cùng nhau:** kiểm tra lần cuối, **nộp báo cáo hoàn chỉnh** | |

---

## 6. Hợp đồng dữ liệu (chốt ngày 1-2, không đổi sau đó)

### Bảng `categories`

| Cột | Kiểu | Ghi chú |
|---|---|---|
| id | INTEGER PK AUTOINCREMENT | |
| name | TEXT NOT NULL | |
| color | INTEGER | Mã màu |
| icon | TEXT | Tên biểu tượng |

### Bảng `tasks`

| Cột | Kiểu | Ghi chú |
|---|---|---|
| id | INTEGER PK AUTOINCREMENT | |
| title | TEXT NOT NULL | |
| description | TEXT | |
| category_id | INTEGER | Tham chiếu `categories.id` |
| priority | INTEGER | 0: thấp, 1: trung bình, 2: cao |
| due_date | TEXT (ISO 8601) | |
| remind_before | INTEGER | Số phút nhắc trước |
| is_done | INTEGER | 0/1 |
| created_at | TEXT | |
| completed_at | TEXT | |

### Điểm giao nhau duy nhất giữa hai phần

| Điểm giao | Ai ghi | Ai đọc | Cách xử lý để không phụ thuộc |
|---|---|---|---|
| Danh mục trong form công việc | SV-B | SV-A | Danh mục mặc định được tạo sẵn ở bộ khung; SV-A đọc bằng truy vấn riêng `SELECT * FROM categories`, không import code của SV-B |
| Số liệu thống kê | SV-A (công việc) | SV-B | SV-B tự viết truy vấn SQL trong `StatsRepository`, **không** gọi `TaskProvider` |
| Dark mode | SV-B (`SettingsProvider`) | SV-A | SV-A chỉ dùng `Theme.of(context)`, **không** viết màu cố định trong code |
| Xóa danh mục đang có công việc | SV-B | | Khi xóa danh mục, SV-B đặt `category_id = NULL` cho các công việc liên quan bằng một câu lệnh SQL (đã thỏa thuận trước) |

---

## 7. Quy ước Git để tránh xung đột

```
main                    ← chỉ chứa bản ổn định, luôn chạy được
├── feature/tasks-*     ← SV-A
└── feature/settings-*  ← SV-B (categories-*, stats-*, ...)
```

- Mỗi tính năng một branch, tạo Pull Request, **người còn lại duyệt** rồi mới merge.
- Mỗi sáng chạy `git pull origin main` để cập nhật trước khi làm.
- Commit nhỏ, thông điệp rõ ràng: `feat(tasks): add task form`, `feat(stats): add weekly chart`.
- **Mỗi người commit ít nhất 1 lần mỗi 2 ngày** để có lịch sử đóng góp rõ ràng.
- Họp nhanh 10 phút mỗi ngày: hôm qua làm gì, hôm nay làm gì, đang vướng gì.

---

## 8. Đối chiếu tiêu chí: cả hai đều chạm đủ 5 tiêu chí

| Tiêu chí | Điểm | 🟦 SV-A làm | 🟩 SV-B làm |
|---|---|---|---|
| Widget, giao diện (≥ 6 trang) | 3 | 3 màn lớn: form, danh sách, chi tiết; `ListView`, `Dismissible`, pickers | 4 màn: `GridView`, biểu đồ, switch/cài đặt, splash |
| Điều hướng | 2 | Route `/task/*`, truyền `id`/`extra`, nhận kết quả | `ShellRoute`, route danh mục/thống kê/cài đặt, hiệu ứng chuyển trang |
| Trạng thái và kiến trúc | 2 | `TaskProvider` | `CategoryProvider`, `SettingsProvider`, `StatsProvider` |
| Lưu trữ dữ liệu | 2 | CRUD bảng `tasks` (SQLite) | CRUD bảng `categories` (SQLite) + `shared_preferences` |
| Tùy biến, triển khai | 1 | Build APK, chạy thiết bị thật | Đổi tên app, icon, splash |
| Thông báo cục bộ (thuộc tiêu chí giao diện) | | ✅ | |
| Responsive (thuộc tiêu chí giao diện) | | ✅ phần của mình | ✅ phần của mình |

---

## 9. Rủi ro và cách xử lý

| Rủi ro | Cách xử lý |
|---|---|
| Hai người cùng sửa `pubspec.yaml` | Thêm toàn bộ thư viện ở ngày 1; cần thêm sau thì báo nhau và làm PR riêng |
| Hai người cùng sửa `app_router.dart` / `app.dart` | Khai báo sẵn tất cả ở bộ khung rồi đóng băng |
| Đổi cấu trúc bảng giữa chừng | Chốt bảng ở ngày 1-2; muốn đổi phải có cả hai đồng ý, tăng `version` CSDL và xóa dữ liệu máy ảo |
| SV-B xong sớm | Nhận thêm màn **Lịch** hoặc hỗ trợ viết unit test, tài liệu |
| SV-A bị quá tải | Chuyển màn Lịch/thống kê nâng cao sang SV-B, rút gọn lọc nâng cao |
| Thông báo lỗi trên Android mới | Xin quyền `POST_NOTIFICATIONS` và quyền báo thức chính xác; thử trên thiết bị thật sớm (ngày 9, 16) |
| Một người không hiểu phần người kia | Review PR bắt buộc, hỏi đáp chéo ngày 20 |

---

## 10. Checklist

**Ngày 2 (bộ khung)**
- [ ] `pubspec.yaml` có đủ thư viện
- [ ] Tất cả route, Provider, bảng CSDL đã khai báo sẵn
- [ ] App chạy được với các màn hình tạm
- [ ] Đóng băng file chung, mỗi người tạo branch riêng

**Tuần 1**
- [ ] Mỗi người CRUD SQLite cho bảng của mình
- [ ] Mỗi người có Provider chạy đúng
- [ ] ≥ 5 màn hình dựng xong
- [ ] Nộp báo cáo tiến độ

**Tuần 2**
- [ ] Thông báo cục bộ hoạt động
- [ ] Lọc, tìm kiếm, thống kê, dark mode
- [ ] Hiệu ứng chuyển trang, responsive cơ bản
- [ ] Ghép hai phần chạy trọn vẹn

**Tuần 3**
- [ ] Đổi tên app, icon, splash
- [ ] Build APK, chạy thiết bị thật
- [ ] Mỗi người có đủ commit trên GitHub
- [ ] Mỗi người giải thích được toàn bộ dự án
- [ ] Nộp báo cáo hoàn chỉnh
