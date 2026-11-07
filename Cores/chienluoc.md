# Chiến lược triển khai TaskFlow trong 3 tuần

> Dựa trên [kế hoạch phân công 3 tuần](phan-cong-3-tuan.md) và kiểm kê repository hiện tại. Đây là kế hoạch triển khai, không phải mô tả tính năng đã hoàn thành.

## 1. Hiện trạng và mục tiêu

Codebase để kế thừa là `../26-27hk1-ct48401-labs-thangb2306582`, không phải project counter scaffold. Labs đã có Flutter Android/iOS, `models/services/ui`, Provider, GoRouter, theme, drawer, SQLite riêng cho giỏ hàng, cùng `path` và `shared_preferences`. Đây là ứng dụng bán hàng: chưa có TaskFlow, Category, database/schema chung hay tính năng đích. `flutter_local_notifications`, `timezone`, `fl_chart` chưa có. Không tạo project/router/provider mới; tách luồng bán hàng và bổ sung các tính năng TaskFlow còn thiếu. `main.dart` đang chứa router, theme và MultiProvider.

Mục tiêu 21 ngày: chuyển codebase labs thành TaskFlow quản lý công việc; ảnh Habit Tracker chỉ cung cấp cảm hứng về bố cục, màu sắc và thẻ tiến độ; TaskFlow lưu trữ cục bộ, có danh mục, nhắc, thống kê/cài đặt theo phạm vi, APK cài thử, báo cáo và demo.

## 2. Nguyên tắc tổ chức

1. **Chia theo vertical slice:** mỗi sinh viên sở hữu model/service/provider/UI của nhóm tính năng trong cấu trúc models/services/ui hiện có.
2. **Một chủ sở hữu cho mỗi file:** SV-A sở hữu model/service và `ui/tasks/`; SV-B sở hữu category/statistics/settings trong `ui/` cùng service tương ứng.
3. **Đóng băng vùng tích hợp sau ngày 2:** `main.dart`, `pubspec.yaml`, drawer, database entry và schema. Không tạo `app.dart`/router riêng trừ khi nhóm thống nhất refactor.
4. **Tích hợp thường xuyên:** PR nhỏ, cập nhật nhánh ổn định hằng ngày, review chéo; không đợi đến ngày 14 mới ghép.
5. **Bằng chứng thay cho báo cáo cảm tính:** mỗi mốc có commit/PR, ảnh hoặc kết quả chạy trên emulator/thiết bị.
6. **Ưu tiên luồng chạy được:** hoãn hiệu ứng/trang Lịch nếu CRUD, nhắc việc, lưu trữ hoặc build chưa ổn.

## 3. Phân công và đầu ra

| Vai trò | Phạm vi sở hữu | Đầu ra bắt buộc |
|---|---|---|
| SV-A — Công việc, nhắc việc | Model/service/provider và `ui/tasks/`; danh sách/trang chủ, form, chi tiết, tìm kiếm/lọc, notification, responsive | CRUD SQLite, trạng thái mục, nhắc theo vòng đời, tài liệu và demo |
| SV-B — Danh mục, thống kê, cài đặt | Category CRUD; thống kê SQLite; theme/cài đặt; điều hướng/drawer; tùy biến app | Category CRUD, số liệu/biểu đồ, dark mode, menu điều hướng, tài liệu và demo |
| Cả hai | Chuyển tiếp nền labs ngày 1–2, schema, tích hợp, review, báo cáo, demo | App chạy sau merge; hợp đồng dữ liệu rõ ràng |

### Điểm giao tiếp

- SV-A đọc bảng `categories` trong form, không phụ thuộc code `CategoryProvider` của SV-B.
- SV-B truy vấn SQL trực tiếp cho thống kê từ `tasks`, không gọi `TaskProvider`.
- SV-A dùng `Theme.of(context)`, không mã hóa màu cố định.
- Khi xóa danh mục, cập nhật `tasks.category_id = NULL` trong thao tác nhất quán.
- Chốt kiểu dữ liệu, tên cột, nullability và định dạng ngày trước khi viết repository.

## 4. Kế hoạch theo tuần

### Tuần 1 — chuyển nền và chức năng lõi (ngày 1–7)

- Ngày 1–2: chạy code labs, xác định phần bán hàng/auth cần tách, schema và quyền sở hữu; nối màn mới vào GoRouter/MultiProvider hiện có. Không dựng lại project/router/provider.
- Ngày 3–4: mỗi người làm model, service/repository SQLite và provider của phần mình.
- Ngày 5–7: hoàn thành màn lõi. SV-A ưu tiên trang chủ/danh sách, form, chi tiết; SV-B ưu tiên shell/theme, danh mục và cài đặt.
- Cuối tuần: dữ liệu thật, persistence sau khởi động, PR và báo cáo.

### Tuần 2 — hoàn thiện tính năng

- SV-A hoàn thành tìm kiếm/lọc, vòng đời thông báo, xóa có xác nhận, responsive và đọc danh mục.
- SV-B hoàn thành truy vấn thống kê, provider/biểu đồ, trạng thái rỗng/lỗi, responsive; chỉ làm Lịch nếu phần bắt buộc ổn.
- Ngày 14: tích hợp, chạy luồng end-to-end, lập bug list.

### Tuần 3 — ổn định, triển khai và báo cáo

- Ngày 15–17: sửa lỗi, thử notification trên thiết bị thật, cấu hình tên/icon/splash, build/cài APK.
- Ngày 18–19: viết và ghép báo cáo, chụp màn hình, đối chiếu yêu cầu.
- Ngày 20: tập demo và hỏi đáp chéo.
- Ngày 21: build cuối, kiểm tra checklist, nộp.

## 5. Quy trình Git và giao tiếp

- `main` luôn giữ trạng thái ổn định có thể chạy.
- Nhánh gợi ý: `feature/tasks-*` cho SV-A; `feature/categories-*`, `feature/stats-*`, `feature/settings-*` cho SV-B; thay đổi khung dùng `chore/skeleton-*` và cả hai review.
- Mỗi PR tập trung một thay đổi, nêu mục tiêu, file chính, cách chạy/kiểm tra, ảnh nếu có, lỗi còn lại.
- Người còn lại review trước merge; tác giả phản hồi và cập nhật PR.
- Commit rõ hành vi, ví dụ `feat(tasks): add task form`, `feat(stats): add weekly summary`.
- Họp 10 phút/ngày; mỗi người commit tối thiểu một lần mỗi hai ngày như kế hoạch gốc.

## 6. Ưu tiên và xử lý chậm tiến độ

### P0 — bắt buộc

App labs chạy sau chuyển tiếp; schema/database domain mới; Task CRUD và persistence; Category CRUD; điều hướng cơ bản; build Android; báo cáo và demo.

### P1 — mục tiêu chính

Nhắc việc cục bộ; tìm kiếm/lọc; thống kê; dark mode; empty/error states; responsive cơ bản; icon/splash.

### P2 — chỉ làm khi P0/P1 ổn

Màn Lịch, animation phức tạp, biểu đồ mở rộng, tinh chỉnh không ảnh hưởng khả dụng.

Nếu có nguy cơ trễ, báo ngay trong checkpoint. Giảm P2 trước; tiếp theo giới hạn P1 ở mức demo được; không bỏ P0. Ghi rõ người nhận, phạm vi, mốc mới và tác động.

## 7. Rủi ro và ứng phó

| Rủi ro | Cách giảm thiểu |
|---|---|
| Code labs có kiến trúc nhưng thuộc domain bán hàng | Giữ hạ tầng chung; tách products/cart/orders và xây domain mới, không nhầm dữ liệu shop với TaskFlow |
| Xung đột file chung | Chốt route/provider/schema/dependencies ngày 1–2; review mọi thay đổi tiếp theo |
| Thư viện/cấu hình khó tương thích | Chạy `pub get` và build sớm; chọn phiên bản phù hợp SDK; tránh nâng major tùy tiện |
| Thông báo bị giới hạn bởi Android/quyền runtime | Xin quyền và thử thiết bị thật từ ngày 9, lặp lại ngày 16; ghi kết quả theo OS |
| Đổi schema làm mất dữ liệu | Chốt schema; thay đổi cần cả hai đồng ý, tăng database version và có migration |
| Tích hợp muộn | PR nhỏ từ tuần 1, review chéo, checkpoint ghép ngày 14 |
| Một người quá tải | Dời Lịch/P2; chuyển phần mở rộng thống kê hoặc hỗ trợ tài liệu với chủ sở hữu rõ |

## 8. Định nghĩa hoàn thành

Hạng mục xong khi code đã merge, chạy trong app, dữ liệu/điều hướng liên quan hoạt động, có ghi nhận kiểm tra, lỗi chặn được ghi nhận và người kia hiểu cách dùng/hợp đồng của nó. Mốc chi tiết ở [checkpoint.md](checkpoint.md).


## Đặc tả giao diện theo ảnh demo

Thiết kế màn hình theo [thiet-ke-giao-dien.md](thiet-ke-giao-dien.md), đối chiếu các ảnh gốc trong [anh/](anh/). TaskFlow là domain chính; ảnh Habit Tracker chỉ tham khảo bố cục/màu sắc. Không thêm habit logs, streak, điểm thưởng hoặc đăng nhập vào phạm vi bắt buộc.
