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

### Báo cáo công việc tuần 1 — đối chiếu repository ngày 10/11/2026

> Người ghi: SV-A (Thắng, theo phân công). Đây là bản tổng hợp trạng thái có thể
> xác nhận từ mã nguồn và tài liệu hiện có, không phải xác nhận rằng các công việc
> chưa có trong repository đã được thực hiện. Tiêu chí chi tiết lấy từ
> [phan-cong-3-tuan.md](./phan-cong-3-tuan.md), trình tự từ
> [next_step_guide.md](./next_step_guide.md), hợp đồng dữ liệu từ
> [schema.md](./schema.md), kiến trúc hiện tại từ [cau_truc.md](./cau_truc.md)
> và các yêu cầu nghiệm thu từ [tieuchi.md](./tieuchi.md).

#### Phần nền tảng và tích hợp đã có trong mã nguồn

- `pubspec.yaml` khai báo `sqflite`, `path`, `provider`, `shared_preferences`
  và `go_router`.
- Entry point TaskFlow, composition root, theme Material 3 sáng/tối và router
  cho các khu vực chính đã có. Route công việc hiện mở danh sách, form tạo/sửa
  và trang chi tiết đã nối với provider.
- `DatabaseHelper` tạo SQLite version 1 với hai bảng `categories` và `tasks`,
  bật khóa ngoại và dùng `ON DELETE SET NULL` cho `tasks.category_id`.
- Phần SV-B đã có model/repository/provider/UI CRUD danh mục và provider lưu
  theme cùng thời gian nhắc mặc định. Màn thống kê hiện vẫn là giao diện số liệu
  mẫu; chưa có repository/provider thống kê thực.

#### Phần SV-A — Công việc và nhắc việc

| Đầu việc tuần 1 | Trạng thái theo repository | Ghi chú |
|---|---|---|
| Chốt schema, route và API tích hợp | Đã làm | Triển khai theo `schema.md` và API repository/provider trong `phan-cong-3-tuan.md`; giữ nguyên route đã khai báo. |
| Model `Task` theo schema | Đã làm | `task.dart` ánh xạ đủ trường, null/date ISO 8601, trạng thái hoàn thành và priority 1–3. |
| `TaskRepository` CRUD SQLite | Đã làm | `task_repository.dart` đọc danh sách/chi tiết, thêm, sửa, xóa, cập nhật hoàn thành và lọc theo trạng thái/danh mục/ngày. |
| `TaskProvider` tải/CRUD/hoàn thành | Đã làm | `task_provider.dart` quản lý tasks, loading/error, CRUD và bộ lọc; ném lại lỗi cho UI. |
| Danh sách và trạng thái rỗng | Đã làm một phần theo tuần 1 | `TasksPage` nối SQLite qua provider, giữ lọc trạng thái cơ bản, empty/error/retry và `TaskTile`; tìm kiếm/lọc danh mục đầy đủ được chuyển sang tuần 2 theo phân công. |
| Form thêm/sửa và validation | Đã làm | Form kiểm tra tiêu đề, ghi chú, hạn ngày/giờ, ưu tiên, danh mục và thời điểm nhắc dựa trên cài đặt mặc định. |
| Chi tiết, hoàn thành, xóa theo ID | Đã làm | Màn chi tiết tải theo ID, xử lý ID không tồn tại, sửa, hoàn thành/bỏ hoàn thành và xóa có xác nhận. |
| Lưu task qua lần khởi động | Đã triển khai, chưa xác minh | Repository dùng SQLite chung; chưa chạy app để xác nhận dữ liệu sau khi đóng/mở lại. |
| Notification service | Chưa làm — thuộc tuần 2 | `notification_service.dart` vẫn rỗng; form chỉ lưu `reminder_at`, chưa lên lịch thông báo hệ điều hành. |

**Kết quả kiểm tra:** đã chạy `dart format` cho các file Dart thay đổi và
`flutter analyze`; kết quả **No issues found**. Chưa chạy test suite, build hoặc
app trên thiết bị, nên persistence qua lần khởi động và runtime chưa được xác
nhận. Widget test hiện có vẫn kỳ vọng dashboard và task placeholder cũ; chưa
cập nhật/chạy lại trong lần này. Không thấy bằng chứng commit/PR riêng cho phần
SV-A trong tài liệu đang có.

#### Việc cần hoàn thành tiếp theo của SV-A

1. Chạy formatter/analyzer khi Dart CLI hoạt động bình thường; sửa mọi lỗi biên
   dịch hoặc lint phát hiện được.
2. Cập nhật test widget/repository vốn còn kỳ vọng UI placeholder, rồi kiểm tra
   CRUD, validation, trường nullable, lọc và persistence.
3. Sau khi luồng CRUD task ổn định, chốt package và triển khai local notification
   theo kế hoạch tuần 2; hiện form chỉ lưu giá trị `reminder_at`.

**Biên bản cập nhật:** 10/11/2026 · Người ghi: SV-A (Thắng) · Các đầu ra mã
nguồn cốt lõi tuần 1 đã được triển khai; `flutter analyze` đạt · Chưa xác nhận
app chạy/persistence bằng test hoặc thiết bị · Commit/PR: chưa có thông tin trong
repository · Notification được chuyển sang tuần 2 theo kế hoạch.

#### Rà soát phạm vi theo tuần — 10/11/2026

- Giữ lại các luồng Task CRUD, giao diện trang chủ/danh sách và bộ lọc trạng thái cơ bản thuộc tuần 1.
- Đã lùi tìm kiếm và lọc danh mục đầy đủ sang tuần 2. Các truy vấn hỗ trợ vẫn có trong repository/provider nhưng chưa được đưa lên giao diện tuần 1.
- Đã gỡ các màn Lịch và Nhật ký cùng route/menu tương ứng; nút Lịch trên trang chủ chỉ thông báo kế hoạch tuần 2.
- Thống kê thật/biểu đồ được lùi sang tuần 2; trang hiện tại vẫn là mẫu. Notification chưa lên lịch và tiếp tục thuộc tuần 2.
- Cập nhật trang danh sách theo trạng thái: ở **Cần làm** dùng lời nhắc “Bắt đầu từ việc nhỏ!” và icon checklist; ở **Hoàn thành** dùng lời động viên cùng icon hoàn tất. Cả hai chế độ giữ thanh tiến độ và ẩn chip Danh mục/Lịch; chế độ **Tất cả** giữ nội dung hiện tại.
- Thêm nút mũi tên quay lại ở các trang con; nếu không có trang trước thì quay về trang Công việc.
- Kiểm tra gần nhất sau các thay đổi giao diện: `flutter analyze --no-pub` đạt, không có lỗi phân tích. Chưa chạy test hoặc build trong các lần chỉnh UI này.
- Ghi chú này mô tả việc điều chỉnh mã nguồn trong lần rà soát, không đánh dấu nghiệm thu tuần 1 hoặc tuần 2.

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

### Báo cáo công việc Tuần 2 — SV-A (Thắng) — đối chiếu repository 14/11/2026

> Phạm vi đối chiếu: các đầu việc SV-A trong `phan-cong-3-tuan.md`, trình tự
> Tuần 2 trong `next_step_guide.md`, yêu cầu notification trong `tieuchi.md` và
> hợp đồng `reminder_at` trong `schema.md`. Trạng thái dưới đây dựa trên code và
> kết quả analyzer/build hiện có; chưa xem là nghiệm thu trên thiết bị.

| Đầu việc Tuần 2 của SV-A | Trạng thái | Bằng chứng / giới hạn |
|---|---|---|
| Tìm kiếm theo tên | Đã triển khai | `TasksPage` lọc tiêu đề từ dữ liệu hiện có. |
| Lọc trạng thái, danh mục, ngày đến hạn và xóa bộ lọc | Đã triển khai | Bộ lọc gọi `TaskProvider`/`TaskRepository`; thao tác xóa bộ lọc trở về danh sách đầy đủ. Chưa chạy kiểm thử tương tác. |
| Local notification, quyền và timezone | Đã triển khai trong code | `NotificationService` khởi tạo plugin/timezone, xin quyền khi có lời nhắc cần đặt và lên lịch notification theo `reminder_at`. Android dùng lịch inexact để không yêu cầu quyền exact alarm; Android manifest khai báo receiver khôi phục lịch sau khởi động. |
| Đồng bộ vòng đời thông báo | Đã nối trong provider | Tạo/sửa đặt hoặc cập nhật notification; xóa/hủy; hoàn thành/hủy; mở lại task đặt lại. ID notification dùng ID SQLite của task. Lời nhắc cũ được đồng bộ khi provider tải dữ liệu lần đầu. |
| Xóa vuốt có xác nhận | Đã triển khai | Vuốt task mở xác nhận; lỗi xóa được báo qua SnackBar. Trang chi tiết vẫn có xác nhận xóa. |
| Bố cục màn rộng | Đã triển khai trong code | Màn danh sách chuyển sang danh sách + chi tiết khi đủ rộng; form/chi tiết giới hạn bề rộng để dễ đọc. Chưa kiểm tra trực quan trên kích thước thiết bị. |
| Form không hạn/không danh mục/bỏ nhắc | Đã giữ hỗ trợ | Các trường vẫn tùy chọn; bỏ hạn sẽ tắt lời nhắc, bỏ danh mục lưu `NULL`. Chưa chạy đủ trường hợp runtime trong lượt này. |

**Kiểm tra đã chạy:** `flutter pub get` thành công; `flutter analyze --no-pub`
đạt **No issues found**; `flutter build apk --debug` thành công tại
`build/app/outputs/flutter-apk/app-debug.apk`.

**Chưa kiểm chứng:** chưa chạy test suite, chưa cài/chạy trên emulator hoặc thiết
bị thật, chưa xác nhận permission prompt và notification khi app foreground,
background, sau reboot hay khi người dùng từ chối quyền. Vì Android dùng lịch
inexact, thời điểm hiển thị có thể trễ; giới hạn riêng của thiết bị/OS cần được
ghi sau khi thử ở Tuần 3. Các mục nghiệm thu Tuần 2 ở trên vẫn để unchecked cho
đến khi có xác nhận chạy thực tế. Thống kê thuộc SV-B và không nằm trong báo cáo
hoàn thành SV-A này.

**Việc tiếp theo của SV-A ở Tuần 3:** thử notification trên thiết bị thật, kiểm
tra CRUD với task rỗng/không hạn và trường hợp quyền bị từ chối; ghi lại giới hạn
OS, chuẩn bị dữ liệu demo và báo cáo phần Công việc/Thông báo.

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

Thiết kế màn hình theo [thiet-ke-giao-dien.md](thiet-ke-giao-dien.md), đối chiếu các ảnh gốc trong [anh/](anh/). Ảnh mô tả một Habit Tracker trong khi kế hoạch chức năng đang là TaskFlow; hãy giữ rõ ánh xạ và không thêm streak/điểm thưởng/đăng nhập vào phạm vi bắt buộc nếu nhóm chưa chốt domain và thời gian.
