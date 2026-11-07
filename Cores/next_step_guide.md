# Next-step guide — hướng dẫn làm việc từng bước

> Tài liệu thao tác hằng ngày cho hai sinh viên. Kế hoạch nguồn: [phan-cong-3-tuan.md](phan-cong-3-tuan.md); mốc nghiệm thu: [checkpoint.md](checkpoint.md).

## Bước 0 — mở đúng codebase

1. Dùng `26-27hk1-ct48401-labs-thangb2306582` làm điểm xuất phát; không dùng project counter scaffold.
2. Điền tên/MSSV, quyền truy cập, phiên bản Flutter/Dart, thiết bị và ngày bắt đầu 21 ngày.
3. Chạy app labs hiện tại; ghi nhận luồng auth/products/cart/orders.
4. Đánh dấu hạ tầng giữ lại (Provider, GoRouter, theme, drawer, SQLite/path/preferences) và module bán hàng sẽ gỡ/tách.
5. Chốt domain đích, schema mới, task tuần 1 và người sở hữu trước khi sửa.

## Ngày 1–2 — chuyển tiếp codebase labs (cùng làm)

1. Kiểm kê `lib/main.dart`: GoRouter, theme và MultiProvider đang nằm chung; `lib/ui/shared/app_drawer.dart` là drawer hiện có.
2. Xác nhận `lib/services/cart_sqlite_service.dart` chỉ lưu `cart_items`; không dùng làm database chung hay đổi bảng cart thành bảng nghiệp vụ.
3. Chốt domain và schema mới; tạo database service riêng cho Task/Habit và Category.
4. Chốt phần auth/bán hàng cần gỡ khỏi entry flow. Nối route mới vào GoRouter và provider mới vào MultiProvider hiện có; không tạo router/provider tree thứ hai.
5. Chỉ bổ sung dependency chưa có và đã thống nhất; không thêm lại `go_router`, `provider`, `path`, `sqflite`, `shared_preferences`, `intl`.
6. Chạy formatter/analyzer/build phù hợp; xác nhận app chạy sau chuyển tiếp và tạo commit nền.

**Kết quả:** app labs đã được chuyển hướng; không tạo lại Flutter project, `app.dart` hay placeholder scaffold.

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

1. Viết `StatsRepository` bằng truy vấn SQLite tổng hợp, đọc `tasks` trực tiếp.
2. Xác định ý nghĩa số liệu và xử lý dữ liệu rỗng.
3. Làm `StatsProvider`, màn tổng quan và biểu đồ theo tuần.
4. Thêm loading/error/empty states, responsive cho grid/biểu đồ.
5. Chỉ nhận màn Lịch nếu P0/P1 đạt checkpoint và cả nhóm đồng ý.

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
