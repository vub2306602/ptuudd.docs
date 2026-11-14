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
