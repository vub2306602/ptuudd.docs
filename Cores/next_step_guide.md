# Next-step guide — hướng dẫn làm việc từng bước

> Tài liệu thao tác hằng ngày cho hai sinh viên. Kế hoạch nguồn: [phan-cong-3-tuan.md](phan-cong-3-tuan.md); mốc nghiệm thu: [checkpoint.md](checkpoint.md).

## Bước 0 — chuẩn bị khởi động

1. Điền tên/MSSV và xác nhận quyền truy cập repository.
2. Mở thư mục Flutter `26-27hk1-ct48401-project-vub2306602` làm working directory.
3. Ghi phiên bản Flutter/Dart, thiết bị mục tiêu và ngày bắt đầu 21 ngày.
4. Chạy app hiện tại để xác nhận baseline: scaffold counter mặc định.
5. Tạo task cho đầu ra tuần 1 và gắn đúng người sở hữu.

## Ngày 1–2 — dựng khung (cùng làm)

1. Thống nhất dependencies cần thiết: router, provider, SQLite, path, shared preferences, local notifications/timezone, chart, date formatting; thêm vào `pubspec.yaml` một lần.
2. Thiết kế database helper, schema `categories`/`tasks`, version và dữ liệu danh mục mặc định.
3. Tạo cấu trúc theo kế hoạch. Màn placeholder nằm trong feature của người sở hữu.
4. Khai báo route `/tasks`, `/tasks/new`, `/tasks/:id`, `/categories`, `/stats`, `/settings` và shell; ghi cách truyền ID/extra.
5. Đăng ký provider trong app composition; implementation tối thiểu phải compile.
6. Chạy formatter/analyzer/build phù hợp với môi trường; sửa lỗi bộ khung trước khi chia nhánh.
7. Cả hai review schema và commit `chore: skeleton-done`; ghi file chung đóng băng.

**Kết quả bắt buộc:** app khởi động được và mở route tạm. Nếu chưa đạt, tiếp tục sửa khung.

## Quy trình hằng ngày từ ngày 3

1. Cập nhật nhánh ổn định theo quy ước nhóm.
2. Làm một task nhỏ trong đúng vùng sở hữu.
3. Trước commit: format file đã sửa, xem diff, chạy kiểm tra phù hợp với thay đổi.
4. Commit nêu hành vi, tránh thông điệp chung chung như `update`.
5. Mở PR khi thay đổi review độc lập được; người kia phản hồi sớm.
6. Cập nhật checkpoint với bằng chứng chạy, điểm nghẽn, việc kế tiếp.

Không sửa trực tiếp vùng của bạn học. Nếu cần sửa file chung, mở PR riêng, nêu lý do và thống nhất trước khi merge.

## Trình tự công việc SV-A

### Tuần 1

1. Định nghĩa `Task` theo schema; ánh xạ SQLite và xử lý null/date.
2. Viết `TaskRepository` CRUD và truy vấn danh sách.
3. Viết `TaskProvider` với trạng thái tải/lỗi, CRUD và hoàn thành.
4. Làm danh sách, empty state, lọc cơ bản và `TaskTile`.
5. Làm form thêm/sửa có validation, chọn ngày/giờ, ưu tiên và lưu dữ liệu.
6. Làm chi tiết task, route nhận ID và trả kết quả khi thay đổi.

### Tuần 2

1. Bổ sung tìm kiếm/lọc; không rải logic SQL trong widget.
2. Cài notification service: khởi tạo, quyền, timezone và lịch nhắc.
3. Nối đặt/hủy/cập nhật notification với thêm/sửa/xóa/hoàn thành task.
4. Thêm xóa vuốt có xác nhận; chọn cách hoàn tác/xác nhận phù hợp.
5. Làm layout rộng cho danh sách + chi tiết; đọc danh mục theo database contract.
6. Thử trên thiết bị thật sớm và ghi giới hạn notification theo OS.

### Tuần 3

1. Sửa lỗi phần mình theo mức độ và tái kiểm tra luồng liên quan.
2. Thử notification trên thiết bị thật.
3. Hỗ trợ build/cài APK và ghi vị trí artifact.
4. Viết phần báo cáo Công việc/Thông báo, chuẩn bị demo và hỏi đáp chéo.

## Trình tự công việc SV-B

### Tuần 1

1. Định nghĩa `Category` và `CategoryRepository` khớp schema.
2. Làm CRUD và `CategoryProvider`; khi xóa, cập nhật `tasks.category_id` về null.
3. Làm `SettingsProvider`, lưu theme/thời gian nhắc mặc định bằng preferences.
4. Hoàn thiện theme sáng/tối, màu semantic và shell/bottom navigation.
5. Làm màn danh mục bằng grid/dialog và màn cài đặt.
6. Xây entry/splash flow theo kiến trúc đã thống nhất.

### Tuần 2

1. `StatsRepository` tổng hợp tổng số/đã hoàn thành/chưa hoàn thành/tỷ lệ hoàn thành và thống kê số task đến hạn từng ngày trong tuần từ SQLite.
2. Tuần thống kê chạy từ thứ Hai đến Chủ nhật; ngày và trạng thái rỗng đều có số liệu bằng 0. Vì schema chưa có `completed_at`, không diễn giải task hoàn thành theo ngày đến hạn là task được hoàn thành trong ngày đó.
3. `StatsProvider`, màn tổng quan và biểu đồ tuần đã nối SQLite; biểu đồ dùng Flutter thuần và ghi rõ số liệu là trạng thái hiện tại theo ngày đến hạn.
4. Loading/error/empty cho danh mục, thống kê và cài đặt đã được rà soát.
   Responsive grid/biểu đồ cũng đã được kiểm tra bằng widget test ở các chiều
   rộng hẹp, tại ngưỡng đổi số cột và trên màn rộng; chưa kiểm tra responsive
   thủ công trên emulator ở nhiều kích thước.
5. Đã kiểm tra trên Android emulator việc xóa danh mục có task sử dụng: task
   vẫn tồn tại và `category_id` về `NULL`; theme/thời gian nhắc vẫn còn sau
   force-stop và khởi động lại app. Test lưu preferences qua provider mới cũng
   đạt.
6. Chỉ nhận màn Lịch nếu P0/P1 đạt checkpoint và cả nhóm đồng ý.

### Tuần 3

1. Sửa lỗi danh mục/thống kê/cài đặt và thử dữ liệu rỗng lẫn dữ liệu thật.
2. Cấu hình tên app/icon/splash theo nền tảng mục tiêu; kiểm tra build.
3. Dọn code trong vùng sở hữu, viết báo cáo và chuẩn bị demo/hỏi đáp chéo.

## Tích hợp và xử lý lỗi

- Tích hợp từng PR nhỏ vào nhánh ổn định; sau merge chạy app và mở route bị ảnh hưởng.
- Nếu conflict ở file chung, hai tác giả xem diff và thống nhất, không tự ghi đè.
- Nếu build hỏng sau merge, tìm commit/PR liên quan, báo ngay và sửa trước feature mới.
- Nếu lỗi schema, dừng thay đổi liên quan và thống nhất migration; không xóa database để né migration.
- Mức độ: P0 app không chạy/mất dữ liệu; P1 luồng chính hỏng; P2 chức năng phụ/UI; P3 cải tiến.
- Báo cáo kiểm thử tích hợp Ngày 14 và danh sách lỗi hiện tại nằm trong
  [checkpoint.md](checkpoint.md) và [bug.md](bug.md). Debug APK build được,
  analyzer đạt; test suite hiện có 4 failure trong `test/widget_test.dart`.
- Việc kế tiếp: sửa overflow ở viewport nhỏ, cập nhật hoặc thay các widget test
  còn kỳ vọng placeholder/đang timeout; xác minh riêng notification và sửa task
  trên thiết bị. Không xem các timeout của widget test là lỗi runtime cho tới
  khi tái hiện được bằng luồng ứng dụng.

## Chuẩn bị demo cuối

1. Khởi động app với dữ liệu demo đã định trước.
2. Tạo/chọn danh mục, tạo task có hạn và nhắc, sửa task, đánh dấu hoàn thành.
3. Xác nhận notification theo kịch bản và quyền thiết bị.
4. Mở thống kê và giải thích nguồn số liệu; đổi theme, đóng/mở app để chứng minh lưu cài đặt.
5. Trình bày kiến trúc/schema và luồng từ UI qua provider/repository tới SQLite.
6. Cả hai tập trả lời câu hỏi về phần đối phương.

## Mẫu báo cáo PR

```text
Mục tiêu:
Phạm vi / file chính:
Cách chạy hoặc kiểm tra:
Kết quả / bằng chứng:
Ảnh hoặc video (nếu là UI):
Rủi ro hoặc phần chưa xong:
Người review:
```


## Đặc tả giao diện theo ảnh demo

Thiết kế màn hình theo [thiet-ke-giao-dien.md](thiet-ke-giao-dien.md), đối chiếu các ảnh gốc trong [anh/](anh/). Ảnh mô tả một Habit Tracker trong khi kế hoạch chức năng đang là TaskFlow; hãy giữ rõ ánh xạ và không thêm streak/điểm thưởng/đăng nhập vào phạm vi bắt buộc nếu nhóm chưa chốt domain và thời gian.
