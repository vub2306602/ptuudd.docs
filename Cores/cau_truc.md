# Cấu trúc dự án

Tài liệu này mô tả cấu trúc dự án Flutter TaskFlow dựa trên mã nguồn hiện có
trong `26-27hk1-ct48401-project-vub2306602/lib` và các tài liệu kế hoạch trong
thư mục `Cores`.

## 1. Trạng thái hiện tại

Mã nguồn và kế hoạch cần được phân biệt rõ:

- `lib/main.dart` hiện vẫn là ứng dụng Flutter mẫu có bộ đếm (`Flutter Demo`),
  chưa phải giao diện TaskFlow; `lib/app.dart` đang rỗng.
- Các file trong `lib/core/` và `lib/features/` đã được tạo nhưng hiện rỗng
  (0 byte). Đây mới là vị trí dự kiến để triển khai kiến trúc và chức năng.
- `pubspec.yaml` hiện có Flutter và `cupertino_icons` trong dependencies;
  `provider`, `go_router`, `sqflite`, `path` và `shared_preferences` chưa được
  khai báo. Các package biểu đồ và thông báo cũng chưa được chọn/cài đặt.
- Chưa có schema SQLite hoặc route thực tế được triển khai. Schema trong
  [`schema.md`](./schema.md) và route bên dưới là **đề xuất hợp đồng tích hợp
  Ngày 1–2**, cần hai thành viên xác nhận trước khi code; không phải trạng thái
  hệ thống hiện tại.
- `test/widget_test.dart` vẫn kiểm thử counter mẫu, nên cần được thay bằng kiểm
  thử phù hợp sau khi entry point chuyển sang app TaskFlow.

### Hợp đồng tích hợp đề xuất cho Ngày 1–2

#### Schema SQLite

DDL SQLite đầy đủ, quy ước kiểu dữ liệu và chính sách khóa ngoại được duy trì
trong [`schema.md`](./schema.md). Model `Task`/`Category` và repository cần
dùng thống nhất tên cột trong tài liệu đó, chuyển đổi qua `fromMap`/`toMap`.

#### Dependencies

Đây là bộ package đề xuất cho MVP, chưa được thêm vào project:

| Package | Mục đích |
|---|---|
| `sqflite` | Lưu trữ SQLite trên thiết bị |
| `path` | Tạo đường dẫn file database |
| `provider` | Quản lý state và cung cấp provider cho UI |
| `go_router` | Khai báo và điều hướng route |
| `shared_preferences` | Lưu cài đặt đơn giản như theme/thời gian nhắc mặc định |

Thống nhất bộ package và phiên bản tương thích trước khi cập nhật
`pubspec.yaml`; sau đó chạy `flutter pub get` để cập nhật `pubspec.lock`.
Dependency thông báo và biểu đồ có thể được chọn khi bắt đầu triển khai các
chức năng đó, không cần thêm chỉ để dựng entry point.

#### Routes

Đề xuất dùng `go_router`; tên/path cần được A và B dùng thống nhất:

| Tên route | Path | Ý nghĩa |
|---|---|---|
| `tasks` | `/tasks` | Danh sách công việc, route khởi đầu |
| `task-create` | `/tasks/new` | Tạo công việc |
| `task-detail` | `/tasks/:id` | Chi tiết công việc |
| `task-edit` | `/tasks/:id/edit` | Sửa công việc |
| `categories` | `/categories` | Quản lý danh mục |
| `statistics` | `/statistics` | Thống kê |
| `settings` | `/settings` | Cài đặt |

Route chi tiết và sửa nhận `id` của task. Trong khi màn hình thật chưa sẵn
sàng, dùng placeholder để các route vẫn mở được.

#### Entry point

`lib/main.dart` chỉ khởi động ứng dụng, còn `lib/app.dart` là composition root
chứa cấu hình `MaterialApp.router`, theme và provider cấp ứng dụng. Mục tiêu
sau khi triển khai:

```dart
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const TaskFlowApp());
}
```

Sau khi đổi entry point, xóa counter mẫu khỏi ứng dụng và thay đổi
`widget_test.dart` để kiểm tra khung app/route thay vì hành vi tăng counter.

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
| `lib/main.dart` | Điểm vào ứng dụng. **Hiện tại:** khởi chạy `MyApp` mẫu với màn hình bộ đếm. **Dự kiến:** gọi `runApp(const TaskFlowApp())` từ `app.dart`; giữ file này làm entry point mỏng. |
| `lib/app.dart` | Thành phần gốc/composition root của ứng dụng. Dự kiến khai báo `MaterialApp.router`, theme sáng/tối, router và đăng ký/cung cấp các provider dùng chung. **Hiện tại:** file rỗng. |

### Hạ tầng dùng chung — `lib/core/`

| File | Chức năng dự kiến |
|---|---|
| `lib/core/database/database_helper.dart` | Khởi tạo và quản lý SQLite; định nghĩa phiên bản, schema hai bảng theo hợp đồng ở mục 1, bật khóa ngoại và migration khi schema thay đổi. Là đầu mối dùng chung cho repository. **Hiện tại:** file rỗng; schema chưa được triển khai. |
| `lib/core/router/app_router.dart` | Khai báo các đường dẫn/name theo bảng Routes ở mục 1; truyền ID cho route chi tiết/sửa và dùng placeholder cho màn chưa có. **Hiện tại:** file rỗng; router chưa được triển khai. |

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
| `lib/features/categories/data/category.dart` | Model `Category` và chuyển đổi dữ liệu danh mục giữa Dart/SQLite. Theo schema đề xuất, model có mã định danh, tên, màu tùy chọn và thời điểm tạo; nếu bổ sung biểu tượng thì cần cập nhật hợp đồng schema. |
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