# Cấu trúc dự án

Tài liệu này mô tả cấu trúc dự án Flutter TaskFlow dựa trên mã nguồn hiện có
trong `26-27hk1-ct48401-project-vub2306602/lib` và các tài liệu kế hoạch trong
thư mục `Cores`.

## 1. Trạng thái hiện tại

Mã nguồn và kế hoạch cần được phân biệt rõ:

- `lib/main.dart` tải settings đã lưu và gọi app TaskFlow; nếu tải preferences
  thất bại, lỗi được ghi nhận và app vẫn mở để người dùng xem/thử tải lại ở màn
  Cài đặt. `lib/app.dart` lắp ghép theme, router và provider.
- `lib/core/database/database_helper.dart` đã tạo SQLite version 1 với hai bảng
  theo [`schema.md`](./schema.md); model/repository/provider danh mục, thống kê
  và cài đặt đã được triển khai, đăng ký trong app.
- `pubspec.yaml` hiện khai báo `sqflite`, `path`, `provider`,
  `shared_preferences`, `go_router`, `flutter_local_notifications`,
  `flutter_timezone` và `timezone`. Biểu đồ tuần dùng widget Flutter thuần,
  không cần package biểu đồ ngoài.
- Router đã có các route chính; dashboard/danh sách, form và chi tiết task hiện
  được nối với TaskProvider/TaskRepository/SQLite. Màn danh mục hỗ trợ CRUD;
  cài đặt lưu theme/thời gian nhắc mặc định. `StatsRepository` tổng hợp dữ liệu
  SQLite; `StatsProvider` và màn tổng quan đã nối tổng số, đã hoàn thành, chưa
  hoàn thành, cùng loading/error/retry và trạng thái rỗng. Biểu đồ tuần đã
  được triển khai bằng Flutter thuần. Local notification đã nối vào vòng đời
  Task, đang chờ kiểm thử trên thiết bị.
- Database được mở khi repository danh mục, task hoặc thống kê được gọi; CRUD
  danh mục đã nối vào giao diện. Màn có loading, empty, error/retry và xác nhận
  trước khi xóa.
- Các test hiện có bao phủ cài đặt, danh mục, quy tắc khóa ngoại và thống kê
  ở repository/provider/giao diện. Sau khi
  dashboard/form/chi tiết được nối dữ liệu thật, `widget_test.dart` còn kỳ vọng
  nội dung dashboard và route task placeholder cũ; cần cập nhật trước khi dùng
  làm bằng chứng nghiệm thu phần Task.

### Hợp đồng tích hợp và trạng thái triển khai

#### Schema SQLite

DDL SQLite đầy đủ, quy ước kiểu dữ liệu và chính sách khóa ngoại được duy trì
trong [`schema.md`](./schema.md). Model `Task`/`Category` và repository cần
dùng thống nhất tên cột trong tài liệu đó, chuyển đổi qua `fromMap`/`toMap`.

#### Dependencies

Các package nền tảng đã chốt/được thêm cho MVP:

| Package | Mục đích |
|---|---|
| `sqflite` | Đã thêm; lưu trữ SQLite trên thiết bị |
| `path` | Đã thêm; tạo đường dẫn file database |
| `provider` | Đã thêm; cung cấp ChangeNotifier cho UI |
| `go_router` | Đã thêm; điều hướng giữa các route chính |
| `shared_preferences` | Đã thêm; lưu theme và thời gian nhắc mặc định |
| `flutter_local_notifications` | Đã thêm; lập lịch/hủy nhắc việc cục bộ trên thiết bị |
| `flutter_timezone` | Đã thêm; đọc timezone hiện tại của thiết bị |
| `timezone` | Đã thêm; chuyển thời điểm nhắc sang lịch địa phương để lên lịch |

Dependency local notification/timezone đã được chọn cho nhắc việc. Dependency
biểu đồ để lại đến khi triển khai thống kê.

#### Routes

Router `go_router` đã được triển khai với tên/path sau:

| Tên route | Path | Ý nghĩa |
|---|---|---|
| `tasks` | `/tasks` | Dashboard/danh sách công việc, route khởi đầu |
| `task-create` | `/tasks/new` | Form tạo công việc |
| `task-detail` | `/tasks/:id` | Chi tiết công việc theo ID |
| `task-edit` | `/tasks/:id/edit` | Form sửa công việc theo ID |
| `categories` | `/categories` | Quản lý danh mục |
| `statistics` | `/statistics` | Thống kê |
| `settings` | `/settings` | Cài đặt |

Route chi tiết và sửa nhận `id` của task; trang chi tiết/form xử lý trường hợp
không tìm thấy ID bằng trạng thái lỗi và đường quay lại.

#### Entry point

`lib/main.dart` tải settings đã lưu rồi khởi động ứng dụng; khi tải settings
thất bại, lỗi được báo cáo và ứng dụng vẫn chạy với giá trị mặc định để màn Cài
đặt có thể hiển thị lỗi/thử tải lại. `lib/app.dart` là composition root chứa
cấu hình `MaterialApp.router`, theme và provider cấp ứng dụng. Counter mẫu đã được thay bằng entry point TaskFlow; `widget_test.dart`
kiểm tra dashboard và điều hướng tới các khu vực chính.

## 2. Cấu trúc tổng quan

```text
CT484_PTUDDD/
├── 26-27hk1-ct48401-project-vub2306602/  # Mã nguồn ứng dụng Flutter
│   ├── android/                           # Cấu hình và mã tích hợp Android
│   ├── ios/                               # Cấu hình và mã tích hợp iOS
│   ├── lib/                               # Mã Dart của ứng dụng
│   ├── test/                              # Kiểm thử tự động
│   ├── analysis_options.yaml              # Quy tắc phân tích Dart
│   ├── pubspec.yaml                       # Cấu hình package, SDK, dependencies
│   ├── pubspec.lock                       # Phiên bản dependencies đã khóa
│   └── README.md                          # Thông tin dự án (hiện còn mẫu)
└── Docs/
    └── ptuudd.docs/
        ├── Cores/                         # Kế hoạch, hướng dẫn và đặc tả
        └── anh/                           # Ảnh tham khảo giao diện
```

### Vai trò các thư mục cấp dự án

| Thư mục / file | Chức năng |
|---|---|
| `android/` | Cấu hình Gradle, manifest và phần tích hợp riêng của Android; dùng khi chạy hoặc build ứng dụng Android. |
| `ios/` | Cấu hình Xcode, plist và phần tích hợp riêng của iOS. |
| `lib/` | Chứa mã Dart của ứng dụng. Các chức năng TaskFlow dự kiến được chia trong `core/` và `features/`. |
| `test/` | Chứa unit test/widget test. Hiện có `widget_test.dart`; cần cập nhật kiểm thử theo ứng dụng thực tế khi các tính năng được triển khai. |
| `analysis_options.yaml` | Bật và cấu hình các quy tắc lint/analyzer cho Dart. |
| `pubspec.yaml` | Khai báo tên package, phiên bản SDK, dependencies, assets và cấu hình Flutter. |
| `pubspec.lock` | Ghi phiên bản dependency cụ thể được giải quyết để các môi trường cài đặt nhất quán. |
| `README.md` | Tài liệu giới thiệu và hướng dẫn dự án; nội dung hiện tại vẫn là thông tin mẫu. |
| `Docs/ptuudd.docs/Cores/` | Tài liệu hóa mục tiêu, phân công, quy trình, checkpoint, thiết kế và cấu trúc dự án. |
| `Docs/ptuudd.docs/anh/` | Nơi lưu ảnh tham khảo giao diện được nhắc đến trong đặc tả thiết kế. |

## 3. Cấu trúc thư mục `lib`

```text
lib/
├── main.dart
├── app.dart
├── core/
│   ├── database/
│   │   └── database_helper.dart
│   ├── router/
│   │   ├── app_pages.dart
│   │   └── app_router.dart
│   └── theme/
│       └── app_theme.dart
└── features/
    ├── categories/
    │   ├── data/
    │   │   ├── category.dart
    │   │   └── category_repository.dart
    │   ├── ui/
    │   │   └── categories_page.dart
    │   └── providers/
    │       └── category_provider.dart
    ├── settings/
    │   └── providers/
    │       └── settings_provider.dart
    ├── statistics/
    │   ├── data/
    │   │   └── stats_repository.dart
    │   ├── providers/
    │   │   └── stats_provider.dart
    │   └── ui/
    │       └── weekly_task_chart.dart
    └── tasks/
        ├── data/
        │   ├── task.dart
        │   └── task_repository.dart
        ├── notifications/
        │   └── notification_service.dart  # local notification theo reminder_at
        ├── providers/
        │   └── task_provider.dart
        └── ui/
            ├── tasks_page.dart
            ├── task_form_page.dart
            └── task_detail_page.dart
```

### Ý nghĩa các tầng

- **`main.dart`** là điểm bắt đầu tiến trình Flutter.
- **`app.dart`** dự kiến lắp ghép ứng dụng: MaterialApp, theme, router và các
  provider cấp ứng dụng.
- **`core/`** chứa hạ tầng dùng chung, không thuộc riêng một chức năng nghiệp
  vụ: điều hướng và truy cập cơ sở dữ liệu.
- **`features/`** chia mã theo chức năng nghiệp vụ. Mỗi feature dự kiến giữ model
  và truy cập dữ liệu ở `data/`, trạng thái ứng dụng ở `providers/`; phần giao
  diện sẽ được bổ sung trong feature khi triển khai.
- Luồng dữ liệu dự kiến: **Giao diện → Provider → Repository → SQLite hoặc nơi
  lưu trữ tương ứng**. NotificationService làm việc với dịch vụ thông báo của
  thiết bị.

## 4. Chức năng dự kiến của từng file trong `lib`

### File khởi động và cấu hình ứng dụng

| File | Chức năng |
|---|---|
| `lib/main.dart` | Điểm vào ứng dụng; tải settings và gọi `runApp(TaskFlowApp(...))`. Nếu tải preferences lỗi, báo cáo qua `FlutterError` rồi tiếp tục chạy để SettingsPage có thể hiển thị lỗi/thử tải lại. |
| `lib/app.dart` | Composition root; khai báo `MaterialApp.router`, theme sáng/tối và đăng ký `CategoryProvider`/`StatsProvider`/`SettingsProvider`/`TaskProvider`. **Hiện tại:** đã triển khai. |

### Hạ tầng dùng chung — `lib/core/`

| File | Chức năng dự kiến |
|---|---|
| `lib/core/database/database_helper.dart` | Khởi tạo và quản lý SQLite; định nghĩa version 1 và schema hai bảng theo [`schema.md`](./schema.md), bật khóa ngoại. **Hiện tại:** đã triển khai tạo/mở database và schema; migration cho các version tương lai chưa được bổ sung. |
| `lib/core/router/app_router.dart` | Khai báo route/name cho dashboard, tạo/sửa/chi tiết task, danh mục, thống kê và cài đặt; route task nhận ID. **Hiện tại:** các route task mở `TasksPage`, `TaskFormPage` và `TaskDetailPage`. |
| `lib/core/router/app_pages.dart` | Shell điều hướng drawer/bottom bar và màn thống kê/cài đặt; route trang chủ dùng `TasksPage`. |
| `lib/core/theme/app_theme.dart` | Palette pastel và theme Material 3 sáng/tối dùng chung. **Hiện tại:** đã triển khai theo định hướng ảnh mockup. |

### Công việc — `lib/features/tasks/`

| File | Chức năng và trạng thái |
|---|---|
| `lib/features/tasks/data/task.dart` | Model `Task` khớp schema SQLite, ánh xạ `fromMap`/`toMap`, xử lý ngày ISO 8601 và trường nullable. **Hiện tại:** đã triển khai. |
| `lib/features/tasks/data/task_repository.dart` | Đọc danh sách/chi tiết, thêm, sửa, xóa, đánh dấu hoàn thành và lọc qua SQLite; không đặt SQL trong widget. **Hiện tại:** đã triển khai. |
| `lib/features/tasks/providers/task_provider.dart` | Điều phối tải/CRUD/hoàn thành, lọc, số lời nhắc và đồng bộ notification theo vòng đời task. **Hiện tại:** đã triển khai và đăng ký trong app. |
| `lib/features/tasks/ui/tasks_page.dart` | Danh sách theo nhóm hạn, tìm theo tên, lọc trạng thái/danh mục/ngày, xóa vuốt có xác nhận, empty/error state và bố cục rộng dạng danh sách + chi tiết. **Hiện tại:** đã nối provider. |
| `lib/features/tasks/ui/task_form_page.dart` | Form tạo/sửa, validation tiêu đề, ghi chú, ngày/giờ, ưu tiên, danh mục và thời điểm nhắc theo cài đặt. **Hiện tại:** đã nối provider. |
| `lib/features/tasks/ui/task_detail_page.dart` | Chi tiết theo ID, hoàn thành/bỏ hoàn thành, sửa, xóa có xác nhận và ID không tồn tại. **Hiện tại:** đã nối provider. |
| `lib/features/tasks/notifications/notification_service.dart` | Khởi tạo, xin quyền khi cần, lấy timezone thiết bị và lên/hủy local notification theo ID task ổn định. **Hiện tại:** đã nối tạo/sửa/xóa/hoàn thành/mở lại và đồng bộ reminder đã lưu lúc mở app; chưa thử notification trên thiết bị thật. |

### Danh mục — `lib/features/categories/`

| File | Chức năng dự kiến |
|---|---|
| `lib/features/categories/data/category.dart` | Model `Category` và chuyển đổi dữ liệu danh mục giữa Dart/SQLite. Theo schema, model có mã định danh, tên, màu tùy chọn và thời điểm tạo. **Hiện tại:** đã triển khai model cùng `fromMap`/`toMap`. |
| `lib/features/categories/data/category_repository.dart` | Tầng truy cập dữ liệu danh mục: đọc, thêm, sửa, xóa danh mục. Khi xóa, khóa ngoại đặt `category_id` của task về `NULL`. **Hiện tại:** đã triển khai CRUD; `category_repository_test.dart` xác nhận task được giữ lại và model đọc lại có `categoryId == null`. |
| `lib/features/categories/providers/category_provider.dart` | Giữ trạng thái danh mục, cờ đã tải thành công và cung cấp thao tác tải/CRUD; báo loading/error, ném lại lỗi cho caller. **Hiện tại:** đã triển khai và đăng ký trong app. |
| `lib/features/categories/ui/categories_page.dart` | Hiển thị lưới danh mục pastel; phân biệt tải đầu, rỗng, lỗi đọc danh mục và lỗi tải task liên quan; có thử lại, CRUD và xác nhận xóa. **Hiện tại:** đã nối SQLite và route `/categories`; grid giữ bề rộng thẻ mục tiêu khoảng 220 px, tối đa 4 cột; widget test kiểm tra kích thước 320–1080 px. |

### Cài đặt — `lib/features/settings/`

| File | Chức năng dự kiến |
|---|---|
| `lib/features/settings/providers/settings_provider.dart` | Quản lý `ThemeMode` và thời gian nhắc mặc định (số phút trước hạn, mặc định 15 phút); đọc/lưu bằng `shared_preferences`, báo loading/error và ném lại lỗi để caller xử lý. **Hiện tại:** đã triển khai và đăng ký vào app; settings được xác nhận còn sau cold-start trên Android emulator và khi tạo provider mới. |

`SettingsPage` trong `lib/core/router/app_pages.dart` cho phép chọn theme
hệ thống/sáng/tối và thời gian nhắc trước hạn; màn đã nối `SettingsProvider`,
có loading/error và thao tác tải lại. Không có empty state dạng danh sách vì
đây là form các lựa chọn cài đặt cố định.

### Thống kê — `lib/features/statistics/`

| File | Chức năng dự kiến |
|---|---|
| `lib/features/statistics/data/stats_repository.dart` | **Đã triển khai truy vấn SQLite:** tổng số, đã hoàn thành, chưa hoàn thành, tỷ lệ hoàn thành và số task đến hạn/đang hoàn thành theo từng ngày từ thứ Hai đến Chủ nhật; ngày không có task trả về 0. Không có `completed_at`, nên số liệu tuần không thể xác định ngày task thực sự được hoàn thành. |
| `lib/features/statistics/providers/stats_provider.dart` | Tải tổng quan và thống kê tuần từ `StatsRepository`, quản lý loading/error, giữ dữ liệu tổng số/đã hoàn thành/chưa hoàn thành cùng bảy ngày và ném lại lỗi cho màn hình xử lý. **Đã triển khai và đăng ký trong app.** |
| `lib/features/statistics/ui/weekly_task_chart.dart` | Biểu đồ cột xếp chồng theo bảy ngày, tách task đến hạn đang hoàn thành/chưa hoàn thành; hiển thị trạng thái rỗng và diễn giải giới hạn `completed_at`. **Đã triển khai bằng Flutter thuần, không thêm dependency.** |

> `app_pages.dart` giữ shell, thống kê và cài đặt; giao diện task và danh mục
> nằm trong các feature tương ứng. Thẻ thống kê đổi 2/3 cột theo chiều rộng;
> widget test kiểm tra hàng thẻ và biểu đồ ở kích thước 320–1024 px, không phát
> hiện overflow. Task và category đã có luồng CRUD SQLite; repository, provider,
> màn tổng quan và biểu đồ tuần đã nối SQLite. Biểu đồ phản ánh trạng thái hiện
> tại theo ngày đến hạn, không có lịch sử thời điểm hoàn thành. Local
> notification đã tích hợp nhưng chưa kiểm thử trên thiết bị.

## 5. Tài liệu trong `Docs/ptuudd.docs/Cores`

| File | Vai trò |
|---|---|
| `cau_truc.md` | Tài liệu này: tổng quan cấu trúc dự án và chức năng các file `lib`, kèm phân biệt trạng thái mã nguồn với kế hoạch. |
| `tieuchi.md` | Tiêu chí đánh giá/nghiệm thu TaskFlow, yêu cầu triển khai và nguyên tắc làm cơ sở cho các thay đổi tiếp theo. |
| `schema.md` | DDL SQLite và quy ước dữ liệu dự kiến cho hai bảng `categories` và `tasks`; hiện là đề xuất, chưa triển khai trong app. |
| `chienluoc.md` | Chiến lược triển khai TaskFlow trong ba tuần, nguyên tắc kiến trúc, phân công, mức ưu tiên, rủi ro và tiêu chí hoàn thành. |
| `phan-cong-3-tuan.md` | Kế hoạch phân công công việc theo vai trò và thời gian ba tuần. |
| `next_step_guide.md` | Hướng dẫn thao tác theo ngày/tuần, trình tự dựng khung và phát triển, tích hợp, xử lý lỗi và chuẩn bị demo. |
| `checkpoint.md` | Danh sách mốc nghiệm thu, checklist, bằng chứng cần ghi nhận và mẫu cập nhật tiến độ. |
| `thiet-ke-giao-dien.md` | Đặc tả phong cách, ánh xạ màn hình từ ảnh tham khảo sang TaskFlow, component dùng chung và yêu cầu responsive. Tài liệu lưu ý mockup có ý tưởng Habit Tracker, còn phạm vi kế hoạch hiện tại là TaskFlow. |
| `prompt.md` | Các prompt mẫu để giao việc, hỗ trợ từng vai trò, review PR và cập nhật checkpoint mà không giả định chức năng đã được triển khai. |

## 6. Phạm vi chức năng của ứng dụng theo kế hoạch

Các nhóm chức năng mục tiêu của TaskFlow:

1. **Công việc:** tạo, xem, sửa, xóa, tìm kiếm/lọc và đánh dấu hoàn thành.
2. **Danh mục:** tạo và quản lý danh mục, gán danh mục cho công việc.
3. **Nhắc việc:** thông báo cục bộ theo ngày/giờ của công việc.
4. **Thống kê:** tổng quan và thống kê theo tuần dựa trên dữ liệu công việc.
5. **Cài đặt:** theme sáng/tối và tùy chọn nhắc mặc định.
6. **Điều hướng:** chuyển giữa các khu vực chính của ứng dụng.

Các ý tưởng như streak, điểm thưởng, tài khoản/đăng nhập hoặc mạng xã hội trong
ảnh tham khảo không phải chức năng bắt buộc của phạm vi TaskFlow hiện tại; cần
được nhóm thống nhất trước khi đưa vào sản phẩm.

## 7. Ghi chú triển khai và cập nhật tài liệu

- Thống nhất schema, kiểu dữ liệu, nullability và route trước khi nối các feature.
- Repository chịu trách nhiệm truy cập dữ liệu; Provider điều phối trạng thái;
  giao diện không nên tự thực hiện SQL.
- Thay đổi schema cần có migration và cập nhật phiên bản database, không xóa dữ
  liệu để né migration.
- Khi thêm file UI hoặc thay đổi cấu trúc thư mục, cập nhật cây thư mục và bảng
  chức năng trong tài liệu này để phản ánh mã nguồn thật.
