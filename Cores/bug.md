# Bug list — kiểm thử tích hợp Ngày 14

Ngày kiểm thử: 14/11/2026  
Phạm vi: TaskFlow trên Android emulator API 37, Flutter widget tests, analyzer
và debug APK build. Branch `vu`, HEAD `a42960b` (merge PR#4 của Thắng).

Mức độ: P0 = app không chạy/mất dữ liệu; P1 = luồng chính hỏng; P2 = lỗi UI,
chức năng phụ hoặc kiểm thử cản trở phát hành; P3 = cải tiến.

| ID | Mức | Mô tả và bằng chứng | Trạng thái / việc tiếp theo |
|---|---|---|---|
| DAY14-UI-01 | P2 | `flutter test` ghi nhận `RenderFlex overflowed by 194 pixels` ở `TasksPage` trong test dashboard với viewport có chiều cao rất thấp. Dashboard hiển thị bình thường trên emulator đã dùng; chưa tái hiện trên kích thước thiết bị thực tế nhỏ. Đây là vấn đề co giãn giao diện ở constraint thấp, chưa phải bằng chứng app tràn trên thiết bị thông thường. | Cần tái hiện với viewport nhỏ có chủ đích; điều chỉnh bố cục/scroll nếu vẫn tràn. |
| DAY14-TEST-01 | P2 | `test/widget_test.dart`: test dashboard không qua; nguyên nhân quan sát được gồm constraint thấp và overflow trên, nhưng cần chạy lại để xác nhận assertion thất bại cụ thể. | Cập nhật test theo dashboard hiện tại, đặt kích thước màn hình phù hợp và xác nhận lại. |
| DAY14-TEST-02 | P2 | Test điều hướng route `/tasks/42` và `/tasks/42/edit` timeout tại `pumpAndSettle`; các route test còn mong đợi placeholder cũ trong khi ứng dụng hiện có luồng task thật. Chưa xác minh đây là lỗi điều hướng runtime. | Viết lại test theo route/behavior hiện tại và tránh chờ settle vô hạn. |
| DAY14-TEST-03 | P2 | Test settings timeout tại `pumpAndSettle` trong `test/widget_test.dart`. Settings đã được xác nhận lưu theme tối và nhắc 30 phút qua cold-start bằng kiểm thử emulator Ngày 13; timeout test không chứng minh cài đặt lỗi. | Cập nhật test cho UI/provider hiện tại; xử lý animation hoặc chờ trạng thái cụ thể. |
| DAY14-TEST-04 | P2 | Test CRUD danh mục timeout tại `pumpAndSettle` trong `test/widget_test.dart`. CRUD danh mục và xóa danh mục có task đã có test/repository evidence riêng; timeout chưa được tái hiện ngoài harness này. | Chạy test tập trung, cập nhật thao tác finder/chờ UI và xác nhận lại. |

## Kết quả tổng kiểm tra

- `flutter test`: **27 passed, 4 failed**; bốn failure được liệt kê phía trên,
  chưa có lỗi runtime tương ứng được xác nhận.
- `flutter analyze --no-pub`: **No issues found**.
- `flutter build apk --debug`: thành công; artifact:
  `build/app/outputs/flutter-apk/app-debug.apk`.
- Emulator: tạo task, hoàn thành, xác nhận task trong bộ lọc hoàn thành và số
  liệu tổng quan cập nhật đúng; xóa task kiểm thử sau đó. Không phát hiện lỗi
  chặn luồng này.
- Chưa xác nhận notification thực tế, chỉnh sửa task end-to-end hoặc kiểm thử
  trên thiết bị Android vật lý. Không ghi nhận lỗi P0/P1 đã tái hiện trong phạm
  vi kiểm thử này.

Không commit hoặc push các thay đổi kiểm thử/tài liệu này.

## Cập nhật xử lý Tuần 3 — 20/11/2026

Đối chiếu lại repository sau các thay đổi SV-A:

| Mã lỗi Ngày 14 | Trạng thái mới | Kết quả |
|---|---|---|
| DAY14-UI-01 | Đã sửa | Empty state của `TasksPage` dùng vùng cuộn; test viewport 800×600 không còn lỗi layout. |
| DAY14-TEST-01 | Đã sửa | Dashboard test dùng kích thước mục tiêu, repository giả và lời nhắc hiện tại; 39/39 test suite đạt. |
| DAY14-TEST-02 | Đã sửa | Widget test kiểm tra route tạo/chi tiết/sửa theo màn hình thật; việc tải task khỏi `initState` tránh notify provider giữa lúc build. |
| DAY14-TEST-03 | Đã sửa | Test settings chạy với repository giả và pump theo khoảng hữu hạn; lưu theme/thời gian nhắc tiếp tục đạt. |
| DAY14-TEST-04 | Đã sửa | Test tích hợp danh mục dùng repository giả; finder khớp nội dung thẻ có tên và số task trên cùng dòng. |

Kiểm tra sau sửa: `flutter test --reporter compact` **39 passed**;
`flutter analyze --no-pub` **No issues found**; `flutter build apk --debug`
thành công. Đã cài APK và mở app trên thiết bị Android 16/API 36 đang kết nối.
Quyền thông báo đang được cấp. Chưa kiểm tra được notification phát thực tế:
Android từ chối thao tác chạm tự động qua `adb` do thiếu `INJECT_EVENTS`, nên
các điều kiện foreground/background, từ chối quyền, thời điểm nhắc và hành vi
đến hạn vẫn cần thử trực tiếp trên thiết bị.

## Cập nhật Ngày 15 — 21/11/2026

- Đã thêm kiểm thử cold-reopen SQLite cho task và category.
- Đã thêm migration hook `onUpgrade` cho database version 1; version hiện tại
  vẫn không xóa dữ liệu khi mở lại và migration thật sẽ được thêm khi schema
  tăng lên.
- Kiểm tra tuần tự sau thay đổi:
  `flutter test -j 1 --reporter compact` — **41/41 test passed**;
  `flutter analyze --no-pub` — **No issues found**.

## Cập nhật Ngày 16 — 21/11/2026

- Widget test xác nhận chuyển theme tối sang sáng và ngược lại, cùng điều hướng
  qua các route shell chính.
- Widget test xác nhận luồng thêm/sửa/xóa danh mục.
- Repository test xác nhận khóa ngoại bật và xóa danh mục có task tham chiếu
  không xóa task; `category_id` trở về `NULL`.
- Kiểm tra tuần tự sau thay đổi:
  `flutter test -j 1 --reporter compact` — toàn bộ test suite passed;
  `flutter analyze --no-pub` — **No issues found**.

## Cập nhật Ngày 17 — 21/11/2026

- Android manifest đã đặt tên app `TaskFlow` và thêm quyền thông báo rung.
- Splash và launcher icon đã dùng branding TaskFlow thay scaffold mặc định.
- `flutter build apk --debug` — thành công.
- APK đã cài bằng `adb install -r` và mở được trên Samsung Galaxy A12
  (SM-A125F); process app đang chạy sau launch.
- App process: `com.example.ct484project`.
- Đã lưu ảnh màn hình:
  `build/taskflow-day17.png`.
- Còn giới hạn: notification phát thực tế, foreground/background, từ chối quyền
  và thời điểm đến hạn vẫn chưa kiểm chứng trực tiếp trên thiết bị.

## Cập nhật Ngày 18 — 21/11/2026

- Đã tạo và hoàn thiện `bao_cao_so_luoc.md`.
- Báo cáo đã mô tả kiến trúc UI/Provider/Repository/SQLite, schema hai bảng,
  công việc/danh mục, thống kê, cài đặt, điều hướng, Android và kiểm thử.
- Báo cáo phân tách rõ chức năng đã kiểm chứng khỏi giới hạn chưa xác nhận
  notification và demo end-to-end.

## Cập nhật Ngày 19 — 21/11/2026

- Đã thêm `du_lieu_demo.sql` với 4 danh mục, 5 công việc và dữ liệu thống kê
  demo tương ứng.
- Đã thêm test dữ liệu demo trong `navigation_theme_test.dart`.
- Full suite hiện tại: **42/42 test passed**.
- Analyzer: **No issues found**.
- Giữ nguyên giới hạn: chưa có bộ ảnh thật riêng cho danh mục, thống kê và
  cài đặt; `taskflow-day17.png` là ảnh thiết bị thật duy nhất hiện có.
