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
| Ngày 1–2 | Chốt hợp đồng dữ liệu, dependencies, khung app, route, Provider, database; ứng dụng chạy | ☐ | ☐ | |
| Ngày 7 | CRUD và màn lõi chạy với SQLite; báo cáo tuần 1 | ☐ | ☐ | |
| Ngày 14 | Ghép luồng chính, hoàn thiện chức năng, chạy trên emulator | ☐ | ☐ | |
| Ngày 17 | Sửa lỗi, cấu hình ứng dụng, APK chạy trên thiết bị | ☐ | ☐ | |
| Ngày 21 | Demo, báo cáo, kiểm tra cuối và nộp | ☐ | ☐ | |

## Checkpoint 0 — Khởi động và kiểm kê hiện trạng

- [ ] Cả hai clone cùng repository và chạy được Flutter scaffold hiện tại.
- [ ] Điền tên, MSSV, kênh liên lạc, giờ họp ngắn và người tích hợp.
- [ ] Xác nhận phiên bản Flutter/Dart và thiết bị/emulator mục tiêu.
- [ ] Ghi nhận baseline: `lib/main.dart` là counter demo; `pubspec.yaml` mới có Flutter và `cupertino_icons`; chưa có router, provider, SQLite hay feature TaskFlow.
- [ ] Chốt ngày bắt đầu/kết thúc thật cho 21 ngày; ngày trong kế hoạch là ngày tương đối.

**Biên bản:** Ngày ____ · Người ghi ____ · Commit nền ____ · Vướng mắc ____

## Checkpoint 1 — Ngày 2: đóng bộ khung

- [ ] `pubspec.yaml` có dependency đã thống nhất; `pub get` thành công.
- [ ] Có `app.dart`, `core/router`, `core/database`, theme và cấu trúc `features/`.
- [ ] Schema `tasks`/`categories`, quy tắc xóa danh mục và hợp đồng model được cả hai duyệt.
- [ ] Route và Provider tối thiểu được đăng ký; màn placeholder điều hướng được.
- [ ] Ứng dụng build/run được sau khi khởi tạo khung.
- [ ] Tạo commit `chore: skeleton-done`; ghi các file chung đã đóng băng.
- [ ] Mỗi người tạo branch riêng và nắm quyền sở hữu file.

**Gate:** Chưa bắt đầu phát triển độc lập nếu app chưa chạy hoặc hợp đồng dữ liệu chưa thống nhất.

**Biên bản:** Ngày ____ · Commit ____ · Link PR ____ · Quyết định schema ____ · Vướng mắc ____

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
