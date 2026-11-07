# Chiến lược triển khai TaskFlow trong 3 tuần

> Dựa trên [kế hoạch phân công 3 tuần](phan-cong-3-tuan.md) và kiểm kê repository hiện tại. Đây là kế hoạch triển khai, không phải mô tả tính năng đã hoàn thành.

## 1. Hiện trạng và mục tiêu

Repository Flutter hiện có scaffold counter mặc định trong `26-27hk1-ct48401-project-vub2306602/lib/main.dart`. `pubspec.yaml` chưa khai báo thư viện ngoài ngoài `cupertino_icons`; chưa có router, state management, SQLite, model hay feature TaskFlow. Tuần đầu phải dành thời gian dựng nền.

Mục tiêu cuối 21 ngày: ứng dụng quản lý công việc chạy trên Android, lưu dữ liệu cục bộ, có danh mục, nhắc việc, thống kê, cài đặt sáng/tối, APK cài thử, báo cáo và demo. Tên sản phẩm trong tài liệu gốc là TaskFlow; nhóm có thể chốt tên khác.

## 2. Nguyên tắc tổ chức

1. **Chia theo vertical slice:** mỗi sinh viên sở hữu model/repository/provider/UI của nhóm tính năng.
2. **Một chủ sở hữu cho mỗi file:** SV-A sở hữu `features/tasks/`; SV-B sở hữu `features/categories/`, `features/statistics/`, `features/settings/`.
3. **Đóng băng vùng tích hợp sau ngày 2:** `pubspec.yaml`, `main.dart`, `app.dart`, router, database helper và schema. Mọi thay đổi sau đó cần PR tích hợp có cả hai đồng thuận.
4. **Tích hợp thường xuyên:** PR nhỏ, cập nhật nhánh ổn định hằng ngày, review chéo; không đợi đến ngày 14 mới ghép.
5. **Bằng chứng thay cho báo cáo cảm tính:** mỗi mốc có commit/PR, ảnh hoặc kết quả chạy trên emulator/thiết bị.
6. **Ưu tiên luồng chạy được:** hoãn hiệu ứng/trang Lịch nếu CRUD, nhắc việc, lưu trữ hoặc build chưa ổn.

## 3. Phân công và đầu ra

| Vai trò | Phạm vi sở hữu | Đầu ra bắt buộc |
|---|---|---|
| SV-A — Công việc, nhắc việc | `features/tasks/`; Task model/repository/provider; danh sách, form, chi tiết; tìm kiếm/lọc; notification service; responsive | CRUD SQLite, trạng thái task, nhắc theo vòng đời, route task, tài liệu và demo |
| SV-B — Danh mục, thống kê, cài đặt | `features/categories/`, `features/statistics/`, `features/settings/`; Category CRUD; thống kê SQLite; theme/cài đặt; shell/navigation; tùy biến app | Category CRUD, số liệu/biểu đồ, dark mode bền vững, điều hướng, icon/splash nếu khả thi, tài liệu và demo |
| Cả hai | Bộ khung ngày 1–2, schema, tích hợp, review, sửa lỗi tích hợp, báo cáo, demo | App chạy sau mỗi lần merge; hợp đồng giao tiếp được ghi rõ |

### Điểm giao tiếp

- SV-A đọc bảng `categories` trong form, không phụ thuộc code `CategoryProvider` của SV-B.
- SV-B truy vấn SQL trực tiếp cho thống kê từ `tasks`, không gọi `TaskProvider`.
- SV-A dùng `Theme.of(context)`, không mã hóa màu cố định.
- Khi xóa danh mục, cập nhật `tasks.category_id = NULL` trong thao tác nhất quán.
- Chốt kiểu dữ liệu, tên cột, nullability và định dạng ngày trước khi viết repository.

## 4. Kế hoạch theo tuần

### Tuần 1 — nền tảng và luồng cốt lõi (ngày 1–7)

- Ngày 1–2: kiểm kê môi trường, thêm dependencies, dựng database/schema, router, providers, theme và placeholder. Chạy app; commit bộ khung rồi khóa vùng chung.
- Ngày 3–4: mỗi người làm model, repository SQLite và provider của mình.
- Ngày 5–7: hoàn thành màn lõi và điều hướng. SV-A ưu tiên danh sách/form/chi tiết; SV-B ưu tiên shell/theme/danh mục/cài đặt.
- Mốc cuối tuần: cả hai có dữ liệu thật, persistence qua lần khởi động, PR và báo cáo tuần.

### Tuần 2 — hoàn chỉnh và tích hợp (ngày 8–14)

- SV-A hoàn thành lọc/tìm kiếm, vòng đời thông báo, xóa có xác nhận, responsive và đọc danh mục.
- SV-B hoàn thành truy vấn thống kê, provider/biểu đồ, trạng thái rỗng/lỗi, responsive; chỉ làm Lịch nếu phần bắt buộc ổn.
- Ngày 14: ghép code, kiểm tra luồng end-to-end, phân loại lỗi và chốt việc còn lại.
- Mốc cuối tuần: luồng bắt buộc chạy trên emulator, không lỗi chặn mất dữ liệu hoặc tạo/hoàn thành task.

### Tuần 3 — ổn định, phát hành thử và nộp (ngày 15–21)

- Ngày 15–17: sửa lỗi, thử notification trên thiết bị thật, cấu hình tên/icon/splash, build và cài APK.
- Ngày 18–19: mỗi người viết phần báo cáo; cùng ghép báo cáo, chụp màn hình, đối chiếu yêu cầu.
- Ngày 20: tập demo và hỏi đáp chéo; mỗi người giải thích kiến trúc, schema, luồng chính.
- Ngày 21: đóng băng tính năng, build cuối, kiểm tra checklist, nộp artifact/báo cáo.

## 5. Quy trình Git và giao tiếp

- `main` luôn giữ trạng thái ổn định có thể chạy.
- Nhánh gợi ý: `feature/tasks-*` cho SV-A; `feature/categories-*`, `feature/stats-*`, `feature/settings-*` cho SV-B; thay đổi khung dùng `chore/skeleton-*` và cả hai review.
- Mỗi PR tập trung một thay đổi, nêu mục tiêu, file chính, cách chạy/kiểm tra, ảnh nếu có, lỗi còn lại.
- Người còn lại review trước merge; tác giả phản hồi và cập nhật PR.
- Commit rõ hành vi, ví dụ `feat(tasks): add task form`, `feat(stats): add weekly summary`.
- Họp 10 phút/ngày; mỗi người commit tối thiểu một lần mỗi hai ngày như kế hoạch gốc.

## 6. Ưu tiên và xử lý chậm tiến độ

### P0 — bắt buộc

App chạy; schema/database; Task CRUD và persistence; Category CRUD; điều hướng cơ bản; hoàn thành task; build Android; báo cáo và demo.

### P1 — mục tiêu chính

Nhắc việc cục bộ; tìm kiếm/lọc; thống kê; dark mode; empty/error states; responsive cơ bản; icon/splash.

### P2 — chỉ làm khi P0/P1 ổn

Màn Lịch, animation phức tạp, biểu đồ mở rộng, tinh chỉnh không ảnh hưởng khả dụng.

Nếu có nguy cơ trễ, báo ngay trong checkpoint. Giảm P2 trước; tiếp theo giới hạn P1 ở mức demo được; không bỏ P0. Ghi rõ người nhận, phạm vi, mốc mới và tác động.

## 7. Rủi ro và ứng phó

| Rủi ro | Cách giảm thiểu |
|---|---|
| Scaffold hiện tại nhưng kế hoạch giả định đã có kiến trúc | Kiểm tra ngày 1; dựng bộ khung trước khi chia nhánh feature |
| Xung đột file chung | Chốt route/provider/schema/dependencies ngày 1–2; review mọi thay đổi tiếp theo |
| Thư viện/cấu hình khó tương thích | Chạy `pub get` và build sớm; chọn phiên bản phù hợp SDK; tránh nâng major tùy tiện |
| Thông báo bị giới hạn bởi Android/quyền runtime | Xin quyền và thử thiết bị thật từ ngày 9, lặp lại ngày 16; ghi kết quả theo OS |
| Đổi schema làm mất dữ liệu | Chốt schema; thay đổi cần cả hai đồng ý, tăng database version và có migration |
| Tích hợp muộn | PR nhỏ từ tuần 1, review chéo, checkpoint ghép ngày 14 |
| Một người quá tải | Dời Lịch/P2; chuyển phần mở rộng thống kê hoặc hỗ trợ tài liệu với chủ sở hữu rõ |

## 8. Định nghĩa hoàn thành

Hạng mục xong khi code đã merge, chạy trong app, dữ liệu/điều hướng liên quan hoạt động, có ghi nhận kiểm tra, lỗi chặn được ghi nhận và người kia hiểu cách dùng/hợp đồng của nó. Mốc chi tiết ở [checkpoint.md](checkpoint.md).
