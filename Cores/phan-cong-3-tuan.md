# PHÂN CÔNG DỰ ÁN TRONG 3 TUẦN

> Dự án Flutter trong thư mục `26-27hk1-ct48401-project-vub2306602`.
> Thành viên: **A — Thắng**, **B — Vũ**. Kế hoạch 21 ngày dưới đây được điều chỉnh theo mã nguồn hiện tại.

## 1. Hiện trạng và phạm vi

- Ứng dụng hiện vẫn là Flutter counter mẫu trong `lib/main.dart`.
- Các thư mục và một số file của `core/`, `features/tasks/`, `features/categories/`, `features/statistics/`, `features/settings/` đã được tạo; phần chức năng chưa được triển khai hoàn chỉnh.
- `pubspec.yaml` hiện mới có Flutter và `cupertino_icons`; router, state management, lưu trữ và các thư viện tính năng cần được bổ sung.
- Phạm vi đề xuất là ứng dụng quản lý công việc (TaskFlow): công việc, danh mục, thống kê và cài đặt. Ảnh Habit Tracker trong tài liệu thiết kế chỉ là tham khảo; streak, điểm thưởng, đăng nhập và bạn bè không nằm trong phạm vi bắt buộc.
- Mục tiêu cuối: app chạy được, lưu dữ liệu cục bộ, hoàn thành luồng công việc chính, có bản Android để demo và báo cáo. Nếu yêu cầu môn học hoặc thời gian thực tế khác, hai bạn thống nhất điều chỉnh trước khi triển khai.

## 2. Phân công theo thành viên

### A — Thắng: Công việc và nhắc việc

| Phạm vi | File/thư mục dự kiến | Đầu ra |
|---|---|---|
| Model và truy cập dữ liệu công việc | `lib/features/tasks/data/task.dart`, `task_repository.dart` | Model khớp hợp đồng dữ liệu; CRUD và truy vấn công việc |
| Trạng thái công việc | `lib/features/tasks/providers/task_provider.dart` | Tải, thêm, sửa, xóa, hoàn thành, tìm kiếm/lọc; có trạng thái loading/lỗi phù hợp |
| Giao diện công việc | `lib/features/tasks/ui/` (tạo các thư mục/file cần thiết) | Danh sách, form thêm/sửa, chi tiết, trạng thái rỗng và xác nhận xóa |
| Nhắc việc | `lib/features/tasks/notifications/notification_service.dart` | Đặt, cập nhật và hủy thông báo theo vòng đời công việc; xử lý quyền trên thiết bị mục tiêu |
| Tích hợp | Route và widget thuộc tính năng công việc | Kết nối màn hình với provider/repository; kiểm tra luồng tạo đến hoàn thành công việc |

### B — Vũ: Danh mục, thống kê, cài đặt và khung ứng dụng

| Phạm vi | File/thư mục dự kiến | Đầu ra |
|---|---|---|
| Model và truy cập dữ liệu danh mục | `lib/features/categories/data/category.dart`, `category_repository.dart` | CRUD danh mục; xử lý công việc tham chiếu danh mục bị xóa |
| Trạng thái danh mục | `lib/features/categories/providers/category_provider.dart` | Tải, thêm, sửa, xóa và cung cấp danh mục cho giao diện |
| Cài đặt | `lib/features/settings/providers/settings_provider.dart`, `lib/features/settings/ui/` | Lưu/đọc tùy chọn sáng/tối và thời gian nhắc mặc định |
| Thống kê | `lib/features/statistics/data/stats_repository.dart`, `providers/stats_provider.dart`, `ui/` | Số liệu tổng quan từ dữ liệu công việc; biểu đồ chỉ triển khai sau khi luồng cốt lõi ổn định |
| Khung ứng dụng | `lib/app.dart`, `lib/core/router/app_router.dart`, `lib/core/database/database_helper.dart` | Composition root, điều hướng, khởi tạo và nâng version cơ sở dữ liệu |
| Giao diện dùng chung | Theme, điều hướng/shell và cài đặt app | Theme sáng/tối nhất quán, navigation giữa các khu vực |

> `lib/main.dart` chỉ giữ vai trò entry point và gọi app. Thay thế counter mẫu trong ngày 1–2; B chịu trách nhiệm tích hợp khung, A cung cấp màn hình công việc đầu tiên. Thay đổi file dùng chung cần được trao đổi và review bởi cả hai.

### Đầu việc cụ thể của A — Thắng

1. **Ngày 1–2 — chốt giao diện tích hợp:** thống nhất với Vũ tên cột `tasks`, route công việc, các trường của form và cách màn hình gọi provider. Ghi rõ API cần dùng trước khi hai bên làm riêng.
2. **Model — `lib/features/tasks/data/task.dart`:** tạo `Task` với các trường theo bảng `tasks`; có chuyển đổi `fromMap`/`toMap`; xử lý đúng `id`, ngày giờ dạng ISO 8601 và các trường có thể null.
3. **Repository — `lib/features/tasks/data/task_repository.dart`:** triển khai lấy danh sách/chi tiết, thêm, cập nhật, xóa và đánh dấu hoàn thành bằng database helper của Vũ; không viết SQL trong widget.
4. **Provider — `lib/features/tasks/providers/task_provider.dart`:** gọi repository; cung cấp danh sách và trạng thái loading/lỗi; cập nhật giao diện sau thêm/sửa/xóa/hoàn thành; thực hiện tìm kiếm/lọc từ dữ liệu đã tải hoặc repository.
5. **Danh sách:** tạo màn danh sách công việc trong `lib/features/tasks/ui/`; hiển thị ngày đến hạn, danh mục, mức ưu tiên và trạng thái; có empty state, thao tác hoàn thành, mở chi tiết và đường dẫn sang form thêm.
6. **Form thêm/sửa:** tạo form có kiểm tra tiêu đề bắt buộc; chọn danh mục từ provider/API danh mục đã thống nhất; chọn ngày/giờ, mức ưu tiên và thời gian nhắc; lưu mới hoặc cập nhật rồi phản hồi kết quả cho màn trước.
7. **Chi tiết:** tạo màn xem thông tin công việc theo ID; cho phép mở sửa, hoàn thành và xóa có xác nhận; xử lý trường hợp ID không tồn tại.
8. **Tìm kiếm/lọc:** bổ sung tìm theo tiêu đề và lọc tối thiểu theo trạng thái hoàn thành, danh mục hoặc ngày đến hạn; có cách xóa bộ lọc để trở về danh sách đầy đủ.
9. **Nhắc việc:** triển khai `lib/features/tasks/notifications/notification_service.dart`; xin quyền khi cần; đặt lịch khi tạo/cập nhật, hủy khi xóa/hoàn thành hoặc khi bỏ nhắc; dùng ID thông báo ổn định theo task.
10. **Kiểm thử và bàn giao:** kiểm tra CRUD, validation, dữ liệu rỗng/null, lọc và vòng đời nhắc việc; sửa lỗi trong phạm vi mình; gửi cho Vũ danh sách API/dependencies cần và hướng dẫn demo luồng tạo → sửa → nhắc → hoàn thành.

**Nghiệm thu phần A:** có thể tạo công việc, đóng/mở lại app mà dữ liệu vẫn còn, xem/sửa/xóa/hoàn thành công việc; form đọc được danh mục; thao tác nhắc việc không để lại thông báo lỗi thời.

### Đầu việc cụ thể của B — Vũ

1. **Ngày 1–2 — nền tảng dự án:** chốt với Thắng schema, tên route, dependencies và cách cung cấp database helper. Cập nhật dependencies đã thống nhất trong `pubspec.yaml`; chạy `flutter pub get` và xử lý lỗi cấu hình nếu có.
2. **Entry point và composition:** sửa `lib/main.dart` để khởi chạy ứng dụng thay cho counter; hoàn thiện `lib/app.dart` để cấu hình `MaterialApp`, theme, router và đăng ký provider cần dùng. Không tự triển khai logic task thay Thắng.
3. **Database — `lib/core/database/database_helper.dart`:** tạo/mở SQLite, tạo hai bảng theo hợp đồng, đặt version ban đầu và cung cấp kết nối dùng chung; bảo đảm khởi tạo idempotent và có hướng migration khi đổi schema.
4. **Điều hướng — `lib/core/router/app_router.dart`:** cấu hình route cho danh sách, tạo/sửa/chi tiết task, danh mục, thống kê và cài đặt; route chi tiết nhận ID; các màn chưa sẵn sàng được dùng placeholder tạm để app vẫn chạy.
5. **Danh mục model/repository:** hoàn thiện `lib/features/categories/data/category.dart` và `category_repository.dart`; triển khai CRUD, đọc danh sách cho form task và xử lý xóa danh mục bằng cách đặt `tasks.category_id` về null.
6. **Danh mục provider/UI:** hoàn thiện `category_provider.dart`; tạo màn grid/list danh mục trong `lib/features/categories/ui/`; thêm/sửa/xóa có validation và xác nhận xóa; hiển thị trạng thái rỗng/loading/lỗi.
7. **Cài đặt:** hoàn thiện `settings_provider.dart` và UI trong `lib/features/settings/ui/`; lưu theme sáng/tối và thời gian nhắc mặc định bằng cơ chế lưu trữ đã thống nhất; sau khi khởi động lại app, cài đặt vẫn được giữ.
8. **Theme và shell:** tạo theme dùng chung sáng/tối và điều hướng tới các khu vực chính; dùng token màu/kiểu chữ nhất quán, không buộc Thắng dùng màu hard-code trong màn task.
9. **Thống kê:** sau khi repository task và schema được ổn định, hoàn thiện `stats_repository.dart`, `stats_provider.dart` và UI trong `lib/features/statistics/ui/`; hiển thị ít nhất tổng số, đã hoàn thành, chưa hoàn thành; dữ liệu rỗng không gây lỗi. Biểu đồ là phần bổ sung nếu đã có package và còn thời gian.
10. **Tích hợp và bàn giao:** kiểm tra các route, database, provider và CRUD danh mục cùng phần task của Thắng; build/cài thử Android; chuẩn bị hướng dẫn chạy app, ghi lỗi còn lại và phần báo cáo kiến trúc/danh mục/thống kê/cài đặt.

**Nghiệm thu phần B:** app mở được từ `main.dart`, điều hướng tới các khu vực; SQLite tạo được schema; CRUD danh mục hoạt động và form task lấy được danh mục; cài đặt được lưu; thống kê phản ánh dữ liệu thực tế khi task đã tích hợp.

## 3. Quy ước phối hợp và hợp đồng

### Phần làm chung trong ngày 1–2

1. Xác nhận domain TaskFlow, phạm vi, giao diện tham khảo, phiên bản Flutter/Dart và thiết bị demo.
2. Thống nhất schema, tên route, API giữa repository/provider và cấu trúc thư mục trước khi chia nhánh làm riêng.
3. Vũ tích hợp dependencies vào `pubspec.yaml` sau khi cả hai thống nhất danh sách; không tự thêm package trùng lặp ở từng nhánh.
4. Vũ dựng app khởi động được với route/màn hình tạm; Thắng xác nhận route và API cần cho luồng công việc.
5. Cả hai chạy kiểm tra bộ khung và ghi lại cách chạy app, cách tích hợp thay đổi.

### Hợp đồng dữ liệu tối thiểu

Hai bạn phải chốt tên cột và kiểu dữ liệu trong ngày 1–2. Đề xuất ban đầu:

**`categories`**

| Cột | Kiểu | Ghi chú |
|---|---|---|
| `id` | INTEGER, khóa chính tự tăng | |
| `name` | TEXT, bắt buộc | Tên danh mục |
| `color` | INTEGER, có thể null | Giá trị màu |
| `icon` | TEXT, có thể null | Tên/mã icon |

**`tasks`**

| Cột | Kiểu | Ghi chú |
|---|---|---|
| `id` | INTEGER, khóa chính tự tăng | |
| `title` | TEXT, bắt buộc | Tên công việc |
| `description` | TEXT, có thể null | |
| `category_id` | INTEGER, có thể null | Tham chiếu `categories.id` |
| `priority` | INTEGER | Thấp/trung bình/cao; thống nhất quy ước số |
| `due_date` | TEXT, có thể null | ISO 8601 |
| `remind_before` | INTEGER, có thể null | Số phút nhắc trước |
| `is_done` | INTEGER | 0/1 |
| `created_at` | TEXT | ISO 8601 |
| `completed_at` | TEXT, có thể null | ISO 8601 |

Vũ quản lý schema và version trong `database_helper.dart`; Thắng triển khai model/repository theo hợp đồng đã chốt. Không đổi schema giữa chừng nếu chưa thống nhất migration. Khi xóa danh mục, đặt `category_id = NULL` cho công việc liên quan trong cùng thao tác dữ liệu phù hợp.

### Nguyên tắc tránh xung đột

- Mỗi người ưu tiên sửa các file trong phạm vi được giao; không sửa đồng thời cùng một file.
- Không đóng băng `app.dart`, router hay database nếu còn thiếu tích hợp cần thiết. Thay đổi file chung được trao đổi trước, review bởi người còn lại và kiểm tra lại app sau khi merge.
- Không để widget tự thực hiện SQL; giao diện gọi provider, provider gọi repository.
- Thống kê đọc dữ liệu qua repository riêng, không phụ thuộc trực tiếp vào `TaskProvider`.
- Thắng sử dụng theme và API danh mục đã thống nhất; không tạo dữ liệu danh mục riêng trong form công việc.
- Có thể dùng Git branch/PR nếu repository đã được cấu hình; nếu chưa, thiết lập Git và cách chia nhánh trong ngày 1–2. Không ghi nhận commit/PR như đầu ra bắt buộc nếu nhóm chưa có remote.

## 4. Kế hoạch 21 ngày

### Tuần 1 — Dựng nền và hoàn thành chức năng cơ bản (ngày 1–7)

#### A — Thắng

- **Ngày 1–2:** thống nhất với Vũ schema `tasks`, route và API; xác định trường hợp thêm/sửa/hoàn thành/xóa cần hỗ trợ.
- **Ngày 3:** hoàn thiện `lib/features/tasks/data/task.dart` và `task_repository.dart`; kiểm tra chuyển đổi dữ liệu và CRUD với SQLite.
- **Ngày 4:** hoàn thiện `lib/features/tasks/providers/task_provider.dart`; cung cấp thao tác tải, thêm, sửa, xóa và hoàn thành.
- **Ngày 5:** làm màn danh sách công việc trong `lib/features/tasks/ui/`; hiển thị danh sách, empty state và nút mở form.
- **Ngày 6:** làm form thêm/sửa; kiểm tra tiêu đề, cho chọn hạn/ngày giờ, ưu tiên và danh mục.
- **Ngày 7:** làm màn chi tiết; nối danh sách → chi tiết → sửa/xóa; chạy thử luồng tạo và cập nhật công việc.

**Bàn giao cuối tuần 1:** tạo, xem, sửa, xóa và hoàn thành được công việc; dữ liệu lưu qua lần khởi động lại; các màn task gọi provider/repository, không thao tác SQL trực tiếp.

#### B — Vũ

- **Ngày 1–2:** thống nhất schema `categories`/`tasks`, dependencies và tên route; cập nhật dependencies trong `pubspec.yaml`; thay counter mẫu bằng entry point gọi app.
- **Ngày 3:** hoàn thiện `lib/core/database/database_helper.dart` để tạo/mở SQLite và hai bảng; hoàn thiện `category.dart` và `category_repository.dart`.
- **Ngày 4:** hoàn thiện `category_provider.dart`; bắt đầu `settings_provider.dart` để đọc/lưu theme và thời gian nhắc mặc định.
- **Ngày 5:** hoàn thiện theme cơ bản và `lib/core/router/app_router.dart`; tạo route cho task, danh mục, thống kê và cài đặt; route chưa làm xong dùng màn tạm.
- **Ngày 6:** làm màn CRUD danh mục trong `lib/features/categories/ui/`; thêm/sửa/xóa và xác nhận trước khi xóa.
- **Ngày 7:** làm màn cài đặt cơ bản; hoàn thiện `lib/app.dart`; chạy thử app, route và dữ liệu danh mục; bảo đảm xóa danh mục không làm hỏng công việc liên quan.

**Bàn giao cuối tuần 1:** app khởi động được; SQLite tạo đúng hai bảng; danh mục CRUD được; cài đặt theme/thời gian nhắc được lưu; các route chính mở được.

### Tuần 2 — Hoàn thiện tính năng và tích hợp (ngày 8–14)

#### A — Thắng

- **Ngày 8:** bổ sung tìm kiếm theo tên và lọc công việc theo trạng thái/danh mục/ngày; có thao tác xóa bộ lọc.
- **Ngày 9:** triển khai khởi tạo `notification_service.dart`, xử lý quyền thông báo/timezone theo package và nền tảng đã chốt.
- **Ngày 10:** nối thông báo với tạo/sửa/xóa/hoàn thành công việc; cập nhật hoặc hủy lịch nhắc để không còn thông báo cũ.
- **Ngày 11:** hoàn thiện xác nhận xóa và hiển thị lỗi/loading/rỗng ở các màn công việc.
- **Ngày 12:** kiểm tra bố cục trên kích thước màn hình mục tiêu; chỉnh giao diện danh sách, form và chi tiết.
- **Ngày 13:** kiểm tra form lấy danh mục từ nguồn dữ liệu chung; thử các trường hợp thiếu hạn, không có danh mục và bỏ nhắc.
- **Ngày 14:** cùng Vũ tích hợp toàn app; sửa lỗi luồng công việc và ghi lại giới hạn thông báo nếu thiết bị chưa hỗ trợ kiểm thử.

**Bàn giao cuối tuần 2:** luồng công việc hoàn chỉnh có tìm kiếm/lọc; nhắc việc được đặt/cập nhật/hủy đúng theo thao tác; không còn lỗi chặn luồng tạo đến hoàn thành.

#### B — Vũ

- **Ngày 8:** chốt các chỉ số thống kê và truy vấn trong `lib/features/statistics/data/stats_repository.dart`, đọc dữ liệu từ SQLite.
- **Ngày 9:** hoàn thiện `stats_provider.dart` và màn thống kê tổng quan: tổng số, đã hoàn thành, chưa hoàn thành.
- **Ngày 10:** thêm biểu đồ tuần nếu dependencies và dữ liệu đã sẵn sàng; nếu chưa, ưu tiên hiển thị số liệu chính xác.
- **Ngày 11:** hoàn thiện loading/error/empty state cho danh mục, thống kê và cài đặt; sửa lỗi theme hoặc điều hướng.
- **Ngày 12:** kiểm tra responsive cho lưới danh mục và màn thống kê.
- **Ngày 13:** thử xóa danh mục đang được công việc sử dụng; xác nhận `category_id` được xử lý đúng; kiểm tra cài đặt sau khi khởi động lại app.
- **Ngày 14:** cùng Thắng chạy thử app từ đầu đến cuối, tích hợp các nhánh/phần việc và lập danh sách lỗi theo mức độ.

**Bàn giao cuối tuần 2:** thống kê lấy số liệu thật từ SQLite; danh mục/cài đặt/điều hướng ổn định; các màn có trạng thái dữ liệu rỗng và lỗi phù hợp.

### Tuần 3 — Kiểm thử, hoàn thiện và báo cáo (ngày 15–21)

#### A — Thắng

- **Ngày 15:** sửa lỗi trong task/provider/repository; kiểm tra dữ liệu rỗng, công việc không hạn, cập nhật và xóa.
- **Ngày 16:** thử thông báo trên thiết bị thật nếu có; ghi lại quyền cần cấp và kết quả theo từng trường hợp.
- **Ngày 17:** phối hợp build/cài thử Android; xử lý lỗi thuộc phần task/notification.
- **Ngày 18:** viết phần báo cáo về model, CRUD, provider, giao diện công việc, nhắc việc và kết quả kiểm thử.
- **Ngày 19:** chuẩn bị dữ liệu demo và ảnh minh chứng cho tạo/sửa/hoàn thành công việc, tìm kiếm/lọc và nhắc việc.
- **Ngày 20:** tập demo phần công việc; giải thích luồng UI → provider → repository → SQLite và hỏi đáp chéo với Vũ.
- **Ngày 21:** kiểm tra lại task trên bản cuối; cùng Vũ hoàn tất demo và nộp báo cáo.

**Bàn giao cuối tuần 3:** phần công việc ổn định trên bản demo; có báo cáo, ảnh minh chứng và kịch bản trình bày.

#### B — Vũ

- **Ngày 15:** sửa lỗi database, category, settings, statistics, router và app composition; kiểm tra dữ liệu rỗng và lưu trữ sau khởi động lại.
- **Ngày 16:** kiểm tra theme sáng/tối, điều hướng, CRUD danh mục và xóa danh mục có task tham chiếu.
- **Ngày 17:** phối hợp build/cài thử Android; sửa lỗi cấu hình/build; chỉ làm icon/splash nếu các luồng bắt buộc đã ổn định.
- **Ngày 18:** viết phần báo cáo về kiến trúc, schema/database, danh mục, thống kê, cài đặt và điều hướng.
- **Ngày 19:** chuẩn bị dữ liệu demo và ảnh minh chứng cho danh mục, thống kê, theme và các màn chính.
- **Ngày 20:** tập demo phần mình; giải thích database/router/provider và hỏi đáp chéo với Thắng.
- **Ngày 21:** kiểm tra lại app từ entry point đến các màn; cùng Thắng hoàn tất demo và nộp báo cáo.

**Bàn giao cuối tuần 3:** app tích hợp build/cài chạy được trên thiết bị mục tiêu; phần nền tảng và các màn của Vũ ổn định, có báo cáo và hướng dẫn demo.

## 5. Ưu tiên và điều chỉnh phạm vi

1. **P0 — bắt buộc:** app chạy; CRUD công việc và danh mục; lưu cục bộ; hoàn thành công việc; điều hướng cơ bản; cài đặt tối thiểu; kiểm tra và demo được.
2. **P1 — làm sau P0:** nhắc việc trên thiết bị thật, tìm kiếm/lọc đầy đủ, thống kê/biểu đồ, responsive, tinh chỉnh giao diện.
3. **P2 — chỉ làm khi còn thời gian và được cả hai đồng ý:** màn Lịch, icon/splash tùy chỉnh và các hiệu ứng bổ sung.
4. Streak, điểm thưởng, đăng nhập, bạn bè và tính năng Habit Tracker không thuộc phạm vi hiện tại.

Nếu tiến độ chậm, ưu tiên giữ app chạy ổn định và dữ liệu không mất; rút gọn biểu đồ hoặc tính năng trang trí trước, không bỏ kiểm thử luồng chính.

## 6. Checklist nghiệm thu

### Ngày 2

- [ ] Đã xác nhận phạm vi TaskFlow, tên thành viên, schema và cách phối hợp.
- [ ] Dependencies cần thiết được thống nhất; app chạy từ entry point mới.
- [ ] Có route/màn hình tạm và cách tích hợp các nhánh/phần việc.

### Cuối tuần 1

- [ ] Công việc và danh mục có model/repository/provider hoạt động.
- [ ] Có màn danh sách, form công việc, danh mục và cài đặt cơ bản.
- [ ] Dữ liệu còn sau khi đóng và mở lại app.

### Cuối tuần 2

- [ ] Luồng tạo/sửa/hoàn thành/xóa công việc và CRUD danh mục chạy xuyên suốt.
- [ ] Tìm kiếm/lọc, nhắc việc và thống kê đã được kiểm tra hoặc có ghi rõ giới hạn.
- [ ] Không còn lỗi chặn khởi động hoặc thao tác dữ liệu chính.

### Cuối tuần 3

- [ ] Build/cài thử được trên thiết bị mục tiêu; có kịch bản demo.
- [ ] Báo cáo và ảnh minh chứng phản ánh đúng tính năng đã hoàn thành.
- [ ] Thắng và Vũ đều hiểu luồng chính, biết giải thích phần của mình và phần tích hợp.
