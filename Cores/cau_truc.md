# Cấu trúc dự án

Tài liệu này mô tả cấu trúc dự án Flutter TaskFlow dựa trên mã nguồn hiện có
trong `26-27hk1-ct48401-project-vub2306602/lib` và các tài liệu kế hoạch trong
thư mục `Cores`.

## 1. Trạng thái hiện tại

Mã nguồn và kế hoạch cần được phân biệt rõ:

- `lib/main.dart` hiện là ứng dụng Flutter mẫu có bộ đếm (`Flutter Demo`), chưa
  phải giao diện TaskFlow.
- `lib/app.dart` cùng các file trong `core/` và `features/` đã có trong cấu trúc
  thư mục nhưng hiện đang rỗng (0 byte). Chúng là các vị trí dự kiến để triển
  khai kiến trúc và chức năng được mô tả trong tài liệu `Cores`.
- `pubspec.yaml` hiện chỉ khai báo Flutter và `cupertino_icons`; các thư viện
  router, quản lý trạng thái, SQLite, lưu tùy chọn, biểu đồ và thông báo chưa
  được khai báo.
- Vì vậy, các chức năng dưới đây là **vai trò dự kiến theo kế hoạch**, không có
  nghĩa là đã được triển khai hoặc chạy được.

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
│   └── router/
│       └── app_router.dart
└── features/
    ├── categories/
    │   ├── data/
    │   │   ├── category.dart
    │   │   └── category_repository.dart
    │   └── providers/
    │       └── category_provider.dart
    ├── settings/
    │   └── providers/
    │       └── settings_provider.dart
    ├── statistics/
    │   ├── data/
    │   │   └── stats_repository.dart
    │   └── providers/
    │       └── stats_provider.dart
    └── tasks/
        ├── data/
        │   ├── task.dart
        │   └── task_repository.dart
        ├── notifications/
        │   └── notification_service.dart
        └── providers/
            └── task_provider.dart
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
| `lib/main.dart` | Điểm vào ứng dụng, gọi `runApp`. **Hiện tại:** khởi chạy `MyApp` mẫu với màn hình bộ đếm. **Dự kiến:** chuyển sang khởi tạo cấu hình và hiển thị app composition trong `app.dart`. |
| `lib/app.dart` | Thành phần gốc của ứng dụng. Dự kiến khai báo MaterialApp, theme sáng/tối, router và đăng ký/cung cấp các provider dùng chung. **Hiện tại:** file rỗng. |

### Hạ tầng dùng chung — `lib/core/`

| File | Chức năng dự kiến |
|---|---|
| `lib/core/database/database_helper.dart` | Khởi tạo và quản lý SQLite; định nghĩa phiên bản, schema các bảng `tasks`/`categories`, dữ liệu mặc định và migration khi schema thay đổi. Là đầu mối dùng chung cho repository. **Hiện tại:** file rỗng. |
| `lib/core/router/app_router.dart` | Khai báo các đường dẫn và điều hướng giữa các màn hình. Kế hoạch đề cập các route như danh sách/tạo/chi tiết công việc, danh mục, thống kê và cài đặt; truyền ID hoặc dữ liệu cần thiết giữa màn hình. **Hiện tại:** file rỗng. |

### Công việc — `lib/features/tasks/`

| File | Chức năng dự kiến |
|---|---|
| `lib/features/tasks/data/task.dart` | Model `Task`, biểu diễn dữ liệu một công việc và chuyển đổi giữa đối tượng Dart với bản ghi SQLite; xử lý trường tùy chọn và ngày/giờ. |
| `lib/features/tasks/data/task_repository.dart` | Tầng truy cập dữ liệu công việc: tải danh sách, thêm, sửa, xóa, truy vấn/lọc và cập nhật trạng thái hoàn thành qua SQLite. SQL không nên đặt trong widget. |
| `lib/features/tasks/providers/task_provider.dart` | Quản lý trạng thái và nghiệp vụ công việc cho giao diện: tải dữ liệu, loading/error, CRUD, hoàn thành, tìm kiếm/lọc và thông báo thay đổi cho UI. |
| `lib/features/tasks/notifications/notification_service.dart` | Đóng gói thao tác thông báo cục bộ: khởi tạo, quyền, timezone và lên lịch/hủy/cập nhật nhắc việc theo vòng đời công việc. Cần xử lý khác biệt quyền và giới hạn theo hệ điều hành. |

### Danh mục — `lib/features/categories/`

| File | Chức năng dự kiến |
|---|---|
| `lib/features/categories/data/category.dart` | Model `Category` và chuyển đổi dữ liệu danh mục giữa Dart/SQLite. Danh mục có thể cung cấp tên, màu, biểu tượng và mã định danh theo schema nhóm thống nhất. |
| `lib/features/categories/data/category_repository.dart` | Tầng truy cập dữ liệu danh mục: đọc, thêm, sửa, xóa danh mục. Khi xóa, cần đảm bảo các công việc liên quan có `category_id` được đặt về `NULL` theo hợp đồng dữ liệu. |
| `lib/features/categories/providers/category_provider.dart` | Giữ trạng thái danh mục và cung cấp thao tác tải/CRUD cho giao diện quản lý danh mục; báo trạng thái loading/error phù hợp. |

### Cài đặt — `lib/features/settings/`

| File | Chức năng dự kiến |
|---|---|
| `lib/features/settings/providers/settings_provider.dart` | Quản lý tùy chọn ứng dụng như theme sáng/tối và thời gian nhắc mặc định; đọc/lưu tùy chọn bằng cơ chế lưu trữ đã được nhóm chọn để cài đặt còn sau khi mở lại app. |

### Thống kê — `lib/features/statistics/`

| File | Chức năng dự kiến |
|---|---|
| `lib/features/statistics/data/stats_repository.dart` | Tổng hợp số liệu từ SQLite, chủ yếu truy vấn bảng `tasks` theo hợp đồng schema; cung cấp dữ liệu tổng quan/tuần và xử lý trường hợp chưa có dữ liệu. |
| `lib/features/statistics/providers/stats_provider.dart` | Tải và quản lý trạng thái dữ liệu thống kê cho màn hình; cung cấp loading/error/empty state và dữ liệu cho các thành phần số liệu/biểu đồ. |

> Danh sách file hiện chưa có các màn hình/widget giao diện riêng. Các màn hình
> danh sách, form, chi tiết, quản lý danh mục, thống kê và cài đặt là phần sẽ cần
> được bổ sung khi triển khai UI; không nên hiểu các file provider/repository
> hiện tại là đã bao gồm giao diện.

## 5. Tài liệu trong `Docs/ptuudd.docs/Cores`

| File | Vai trò |
|---|---|
| `cau_truc.md` | Tài liệu này: tổng quan cấu trúc dự án và chức năng các file `lib`, kèm phân biệt trạng thái mã nguồn với kế hoạch. |
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