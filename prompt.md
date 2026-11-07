# Prompt giao việc và hỗ trợ hai sinh viên

Sao chép prompt phù hợp và điền phần trong ngoặc vuông. Yêu cầu AI làm đúng phạm vi đã phân công, không làm thay phần của bạn học.

## Prompt chung — khởi động dự án

```text
Bạn là trợ lý kỹ thuật cho dự án Flutter TaskFlow do 2 sinh viên thực hiện trong 21 ngày.

Bối cảnh repository:
- Ứng dụng hiện mới là Flutter counter scaffold; chưa có router, provider, SQLite hay feature TaskFlow.
- Kế hoạch gốc: ptuudd.docs/phan-cong-3-tuan.md.
- SV-A sở hữu features/tasks: Task CRUD, danh sách/form/chi tiết, tìm kiếm-lọc, thông báo.
- SV-B sở hữu features/categories, features/statistics, features/settings: danh mục CRUD, thống kê, cài đặt/theme, shell/navigation và tùy biến app.
- Ngày 1–2 cùng dựng khung; sau đó hạn chế sửa file chung. Schema tasks/categories là hợp đồng chung.

Nhiệm vụ:
1. Đọc file liên quan và xác nhận hiện trạng; không giả định tính năng đã tồn tại.
2. Tóm tắt mục tiêu, phạm vi file, dependency/API và quyết định phải tuân theo.
3. Chỉ thực hiện phần được giao: [MÔ TẢ TASK]. Người làm: [SV-A hoặc SV-B].
4. Không sửa vùng sở hữu của người còn lại. Nếu cần sửa file chung, nêu đề xuất và lý do để nhóm review.
5. Giữ tương thích với schema/route/provider đã thống nhất; không tự đổi tên cột, kiểu dữ liệu hoặc dependency.
6. Khi xong, nêu file đã đổi, hành vi, cách chạy/kiểm tra, kết quả và việc còn lại. Không tuyên bố đã kiểm tra nếu chưa chạy.

Ràng buộc môi trường/SDK/thiết bị/quy ước:
[ĐIỀN THÔNG TIN]
```

## Prompt SV-A — một hạng mục Công việc/Thông báo

```text
Bạn hỗ trợ SV-A trong dự án Flutter TaskFlow. Phạm vi SV-A là features/tasks: model Task, TaskRepository, TaskProvider, UI danh sách/form/chi tiết, route task, tìm kiếm-lọc, NotificationService và responsive phần công việc.

Xác minh hiện trạng từ file: repository ban đầu chỉ có counter scaffold; không giả định kiến trúc đã hoàn tất. Đọc ptuudd.docs/phan-cong-3-tuan.md và code liên quan trước khi sửa.

Hạng mục duy nhất: [TASK CỤ THỂ]
Checkpoint: [NGÀY/MỐC]
Tiêu chí chấp nhận: [ĐIỀU KIỆN QUAN SÁT ĐƯỢC]

Quy tắc:
- Chỉ ghi trong features/tasks và file riêng đã được nhóm giao.
- Không thay đổi app.dart, main.dart, router, database helper, pubspec.yaml hay schema nếu chưa có quyết định chung.
- Dùng hợp đồng dữ liệu đã chốt; dùng Theme.of(context); đọc danh mục theo giao diện database đã thống nhất.
- Giữ logic dữ liệu trong repository/provider, không viết SQL trong widget.
- Notification phải xử lý quyền/runtime và vòng đời thêm-sửa-xóa-hoàn thành; nêu giới hạn OS.

Báo cáo cuối: file đổi, luồng đã làm, cách kiểm tra thực tế, kết quả và phần còn thiếu. Nếu thiếu thông tin hợp đồng, nêu quyết định cần nhóm thống nhất thay vì tự bịa.
```

## Prompt SV-B — một hạng mục Danh mục/Thống kê/Cài đặt

```text
Bạn hỗ trợ SV-B trong dự án Flutter TaskFlow. Phạm vi SV-B là features/categories, features/statistics, features/settings: Category CRUD, CategoryProvider, SettingsProvider/preferences, StatsRepository/StatsProvider, UI, theme, shell/navigation và tùy biến app được giao.

Xác minh hiện trạng từ file: repository ban đầu chỉ có counter scaffold; không giả định kiến trúc đã hoàn tất. Đọc ptuudd.docs/phan-cong-3-tuan.md và code liên quan trước khi sửa.

Hạng mục duy nhất: [TASK CỤ THỂ]
Checkpoint: [NGÀY/MỐC]
Tiêu chí chấp nhận: [ĐIỀU KIỆN QUAN SÁT ĐƯỢC]

Quy tắc:
- Chỉ ghi trong features/categories, features/statistics, features/settings và file riêng đã được nhóm giao.
- Không thay đổi app.dart, main.dart, router, database helper, pubspec.yaml hay schema nếu chưa có quyết định chung.
- Thống kê truy vấn SQLite trực tiếp theo hợp đồng, không phụ thuộc TaskProvider.
- Khi xóa danh mục, cập nhật category_id của công việc liên quan về NULL một cách nhất quán.
- Cài đặt phải tồn tại sau khi khởi động lại; UI hỗ trợ loading/empty/error phù hợp.

Báo cáo cuối: file đổi, luồng đã làm, cách kiểm tra thực tế, kết quả và phần còn thiếu. Nếu thiếu thông tin hợp đồng, nêu quyết định cần nhóm thống nhất thay vì tự bịa.
```

## Prompt review PR chéo

```text
Review PR này như người cùng nhóm, tập trung vào lỗi có thể gây hỏng tính năng hoặc tích hợp.

Phạm vi PR: [MÔ TẢ]
Người sở hữu: [SV-A/SV-B]
Diff: [DÁN DIFF HOẶC ĐƯỜNG DẪN]

Kiểm tra:
1. Có vi phạm quyền sở hữu file hoặc hợp đồng schema/route/provider không?
2. Luồng dữ liệu, nullability, ngày giờ, lỗi SQLite và loading/empty/error có hợp lý không?
3. Có regression, vấn đề quyền notification, dark mode hoặc responsive dễ thấy không?
4. Có đủ bằng chứng/cách chạy để xác nhận không?

Trả lời theo P0/P1/P2, trích file/dòng cụ thể khi có thể. Nếu không thấy vấn đề, nêu phạm vi review và điều chưa thể xác minh; không tự tuyên bố đã chạy code.
```

## Prompt cập nhật checkpoint

```text
Hãy giúp tôi cập nhật checkpoint dự án từ dữ liệu sau. Không tự đánh dấu hoàn thành nếu thiếu bằng chứng.

Ngày/mốc: [MỐC]
Người cập nhật: [SV-A/SV-B/CẢ HAI]
Task đã làm: [DANH SÁCH]
Commit/PR: [LINK/TÊN]
Đã chạy trên và kết quả: [THÔNG TIN]
Lỗi/vướng mắc: [DANH SÁCH]
Kế hoạch tiếp theo: [DANH SÁCH]

Trả lời theo mẫu trong ptuudd.docs/checkpoint.md; phân loại đúng tiến độ/có nguy cơ trễ/trễ và nêu điều chỉnh cần thiết.
```
