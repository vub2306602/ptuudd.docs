# Prompt giao việc trên codebase labs

Dùng prompt này trong repository `26-27hk1-ct48401-labs-thangb2306582`. Project đã có sẵn Flutter setup, Android/iOS, Provider, GoRouter, theme, drawer, models/services/ui, SQLite cho cart, cùng `path` và `shared_preferences`. Đây là app bán hàng; code đích chưa có tính năng TaskFlow hoặc Category.

## Prompt giao một task cho SV-A hoặc SV-B

```text
Bạn là trợ lý lập trình cho app di động nhóm 2 sinh viên, làm trong 21 ngày.

Codebase hiện tại là dự án Flutter labs bán hàng. Đã có Flutter setup, Android/iOS, Provider, GoRouter, theme, drawer, `lib/models`, `lib/services`, `lib/ui`, `path`, `sqflite`, `shared_preferences`, `intl`. `main.dart` chứa router/theme/MultiProvider. SQLite cart ở `cart_sqlite_service.dart` chỉ phục vụ bảng cart_items. Chưa có Task, Category hay database nghiệp vụ chung. Chưa có local notifications/timezone/chart.

Trước khi sửa:
1. Đọc README, pubspec, main.dart và các file liên quan; xác nhận trạng thái code thực tế.
2. Đọc tài liệu trong `project/ptuudd.docs/Cores/` (phan-cong-3-tuan.md, thiet-ke-giao-dien.md, next_step_guide.md); repo hiện tại là thư mục labs.
3. Không tạo lại Flutter project, router, provider tree hoặc dependencies đã có. Không dùng cart database làm schema cho domain mới.
4. Domain đã chốt là TaskFlow quản lý công việc; ảnh Habit Tracker chỉ làm tham khảo giao diện. Làm đúng sở hữu SV-A/SV-B.

Task duy nhất: [MÔ TẢ TASK]
Người sở hữu: [SV-A hoặc SV-B]
Checkpoint: [NGÀY/MỐC]
Tiêu chí chấp nhận: [ĐIỀU KIỆN QUAN SÁT ĐƯỢC]

Quy tắc:
- Chỉ sửa vùng của người sở hữu. File `main.dart`, `pubspec.yaml`, drawer và database entry là vùng tích hợp chung; nếu cần sửa, giải thích diff và gom vào thay đổi tích hợp.
- Tái sử dụng Provider/GoRouter/theme hiện có; thêm route/provider mới vào composition hiện tại.
- Chỉ thêm dependency chưa có sau khi xác nhận gói cần thiết và tương thích.
- Không tuyên bố đã chạy kiểm tra nếu chưa chạy.

Kết thúc bằng danh sách file đổi, hành vi, cách kiểm tra/kết quả và việc còn lại.
```

## Prompt review PR

```text
Review diff sau trên codebase labs đã có Provider, GoRouter, theme, drawer và SQLite chỉ cho cart.

Người sở hữu: [SV-A/SV-B]
Task: [MÔ TẢ]
Diff/file: [DÁN DIFF HOẶC ĐƯỜNG DẪN]

Kiểm tra regression, quyền sở hữu file, tích hợp route/provider, schema/database mới có bị lẫn với cart_items không, loading/empty/error, ngày giờ/thông báo/theme/responsive nếu liên quan. Nêu lỗi P0/P1/P2 kèm file/dòng; ghi phần chưa thể xác minh và không tự nhận đã chạy app.
```

## Prompt cập nhật checkpoint

```text
Cập nhật `ptuudd.docs/Cores/checkpoint.md` từ dữ liệu dưới đây. Codebase nền đã có Flutter, Provider, GoRouter, theme, drawer, SQLite cart, path và shared_preferences; không ghi các phần này là việc còn phải dựng.

Mốc/ngày: [MỐC]
Người cập nhật: [SV-A/SV-B/CẢ HAI]
Task đã làm: [DANH SÁCH]
Commit/PR: [LINK/TÊN]
Đã chạy trên và kết quả: [THÔNG TIN]
Lỗi/vướng mắc: [DANH SÁCH]
Việc tiếp theo: [DANH SÁCH]

Chỉ đánh dấu xong khi có bằng chứng; phân loại đúng tiến độ/có nguy cơ trễ/trễ.
```

## Đặc tả giao diện theo ảnh demo

Thiết kế màn hình theo [thiet-ke-giao-dien.md](thiet-ke-giao-dien.md), đối chiếu các ảnh gốc trong [anh/](anh/). TaskFlow là domain chính; ảnh Habit Tracker chỉ tham khảo bố cục/màu sắc. Không thêm habit logs, streak, điểm thưởng hoặc đăng nhập vào phạm vi bắt buộc.
