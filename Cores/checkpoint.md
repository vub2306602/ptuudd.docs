# Checkpoint dự án TaskFlow trong 3 tuần

> Theo dõi tiến độ, chất lượng và phối hợp của hai sinh viên trong 21 ngày. Kế hoạch nguồn: [phan-cong-3-tuan.md](phan-cong-3-tuan.md).

## Cách cập nhật

- Hai sinh viên cập nhật cuối mỗi ngày làm việc; chỉ đánh dấu `[x]` khi có bằng chứng chạy được hoặc commit/PR.
- Mỗi checkpoint ghi ngày thực tế, người cập nhật, commit/PR, kết quả chạy, lỗi còn lại và việc tiếp theo.
- Nếu trễ mốc, ghi nguyên nhân và điều chỉnh phạm vi; không đánh dấu hoàn tất khi chưa đạt.
- Điền tên thật thay cho nhãn SV-A/SV-B ở buổi khởi động.

## Bảng theo dõi tổng quan

| Mốc | Mục tiêu | SV-A | SV-B | Bằng chứng / ghi chú |
|---|---|---|---|---|
| Ngày 1–2 | Chốt schema TaskFlow, tách luồng bán hàng, nối màn mới vào router/provider hiện có | ☐ | ☐ | |
| Ngày 7 | CRUD và màn lõi chạy với SQLite; báo cáo tuần 1 | ☐ | ☐ | |
| Ngày 14 | Ghép luồng chính, hoàn thiện chức năng, chạy trên emulator | ☐ | ☐ | |
| Ngày 17 | Sửa lỗi, cấu hình ứng dụng, APK chạy trên thiết bị | ☐ | ☐ | |
| Ngày 21 | Demo, báo cáo, kiểm tra cuối và nộp | ☐ | ☐ | |

## Hiện trạng codebase đã có (không giao làm lại)

Codebase labs `../26-27hk1-ct48401-labs-thangb2306582` đã có Flutter project Android/iOS, `lib/models`, `lib/services`, `lib/ui`, auth/products/cart/orders, Provider, GoRouter, theme, drawer, SQLite riêng cho cart, cùng `path` và `shared_preferences`. Phần mới còn thiếu: model/service/UI Task, Category, schema/database riêng, route/provider cho domain mới và dependencies notification/chart nếu được chọn.

## Checkpoint 0 — Khởi động và kiểm kê hiện trạng

- [ ] Hai sinh viên mở codebase labs và chạy được app hiện tại.
- [ ] Điền tên, MSSV, kênh liên lạc, giờ họp ngắn và người tích hợp.
- [ ] Ghi phiên bản Flutter/Dart, thiết bị/emulator và ngày bắt đầu 21 ngày.
- [ ] Xác nhận module hiện tại là auth/products/cart/orders; chốt phần hạ tầng giữ lại và phần bán hàng sẽ tách/gỡ.
- [ ] TaskFlow đã được chọn; mockup Habit Tracker chỉ dùng làm tham khảo giao diện.

**Biên bản:** Ngày ____ · Người ghi ____ · Commit nền ____ · Vướng mắc ____

## Checkpoint 1 — Ngày 2: chuyển tiếp nền có sẵn

- [x] Flutter setup, Provider, GoRouter, theme, drawer, `path`, `sqflite`, `shared_preferences`, `intl` đã có; không tạo/cài lại.
- [ ] Schema TaskFlow được chốt; database nghiệp vụ tách biệt với `cart_items`.
- [ ] Nối route mới vào GoRouter và đăng ký provider trong MultiProvider hiện hữu.
- [ ] Tách luồng products/cart/orders khỏi app đích theo quyết định nhóm; auth chỉ giữ nếu cần.
- [ ] Chỉ thêm dependency còn thiếu đã thống nhất (notifications/timezone/chart/lịch).
- [ ] App build/run được sau chuyển tiếp; ghi file chung và commit tích hợp nền.
- [ ] Mỗi sinh viên tạo branch riêng.

**Gate:** Feature bắt đầu sau khi app vẫn chạy, domain/schema và quyền sửa file chung đã được chốt.

## Checkpoint 2 — Ngày 7: kết thúc tuần 1

### SV-A — Công việc và thông báo

- [ ] Model `Task` ánh xạ đúng schema.
- [ ] `TaskRepository` đọc/thêm/sửa/xóa SQLite.
- [ ] `TaskProvider` tải, thêm, sửa, xóa và đánh dấu hoàn thành.
- [ ] Danh sách, form thêm/sửa, chi tiết có luồng điều hướng cơ bản.
- [ ] Dữ liệu vẫn còn sau khi tắt/mở lại ứng dụng.

### SV-B — Danh mục, thống kê, cài đặt

- [ ] Model `Category`, `CategoryRepository` CRUD SQLite.
- [ ] `CategoryProvider`, `SettingsProvider` hoạt động; cài đặt được lưu.
- [ ] Theme sáng/tối và shell/navigation đã có.
- [ ] Màn danh mục, cài đặt và entry/splash flow hiển thị cơ bản.
- [ ] Danh mục vẫn còn sau khi tắt/mở lại ứng dụng.

### Cả nhóm

- [ ] Mỗi người mở PR nhỏ, có mô tả, ảnh/chứng cứ chạy và người kia review.
- [ ] Nộp báo cáo tuần 1: hoàn tất, chưa hoàn tất, lỗi, kế hoạch bù.
- [ ] Không sửa trái phép vào vùng sở hữu của người kia.

**Biên bản tuần 1:** Ngày ____ · SV-A ____ · SV-B ____ · Build ____ · PR ____ · Điều chỉnh phạm vi ____

## Checkpoint 3 — Ngày 14: kết thúc tuần 2

- [ ] Tìm kiếm/lọc công việc và trạng thái rỗng/lỗi hoạt động.
- [ ] Nhắc việc được tạo/cập nhật/hủy theo thao tác thêm/sửa/xóa/hoàn thành.
- [ ] Thống kê đọc SQLite và hiển thị số liệu/biểu đồ hợp lý với dữ liệu mẫu.
- [ ] Form công việc đọc danh mục từ bảng `categories`; xóa danh mục đặt `category_id` liên quan về `NULL`.
- [ ] Dark mode và cài đặt còn sau khi khởi động lại.
- [ ] Responsive cơ bản được kiểm tra ở kích thước hẹp và rộng.
- [ ] Hai phần đã tích hợp; luồng chính chạy trên emulator.
- [ ] Có bug list với mức độ, người xử lý và hạn sửa.

**Gate:** Không vào tuần 3 khi còn lỗi chặn tạo/sửa/hoàn thành công việc hoặc mất dữ liệu.

**Biên bản tuần 2:** Ngày ____ · Commit tích hợp ____ · Lỗi P0/P1 ____ · Kế hoạch xử lý ____

## Checkpoint 4 — Ngày 17: bản cài thử

- [ ] Đã sửa lỗi chặn và kiểm tra lại tính năng bị ảnh hưởng.
- [ ] Tên app, icon và splash đã cập nhật nếu nằm trong phạm vi nền tảng đã chốt.
- [ ] Build APK thành công; lưu đường dẫn artifact và commit.
- [ ] Cài trên thiết bị thật, kiểm tra SQLite và quyền thông báo.
- [ ] Thử thông báo foreground/background; ghi giới hạn theo phiên bản Android.
- [ ] Không còn crash đã biết mà chưa được ghi nhận.

**Biên bản:** Thiết bị/Android ____ · Build ____ · Kết quả ____ · Lỗi còn lại ____

## Checkpoint 5 — Ngày 21: nghiệm thu và nộp

- [ ] Demo end-to-end: tạo danh mục → tạo công việc → nhắc việc → hoàn thành → xem thống kê.
- [ ] Mỗi người trình bày phần mình và trả lời câu hỏi về phần của người kia.
- [ ] Báo cáo có kiến trúc, schema, chức năng, phân công, ảnh chụp, giới hạn và hướng phát triển.
- [ ] Repository ổn định; commit/PR có lịch sử rõ.
- [ ] APK cuối, hướng dẫn cài/chạy và tài liệu được lưu đúng nơi nộp.
- [ ] Cả hai kiểm tra phiên bản cuối và xác nhận đã nộp.

**Biên bản nghiệm thu:** Ngày ____ · Commit/tag ____ · Artifact ____ · Người xác nhận ____

## Mẫu cập nhật hằng ngày

```text
Ngày:
Sinh viên:
Hôm qua đã làm:
Hôm nay sẽ làm:
Commit/PR hoặc ảnh/video minh chứng:
Đã chạy/kiểm tra trên:
Đang vướng:
Cần người kia hỗ trợ:
Trạng thái: đúng tiến độ / có nguy cơ trễ / trễ
```


## Đặc tả giao diện theo ảnh demo

Thiết kế màn hình theo [thiet-ke-giao-dien.md](thiet-ke-giao-dien.md), đối chiếu các ảnh gốc trong [anh/](anh/). TaskFlow là domain chính; ảnh Habit Tracker chỉ tham khảo bố cục/màu sắc. Không thêm habit logs, streak, điểm thưởng hoặc đăng nhập vào phạm vi bắt buộc.
