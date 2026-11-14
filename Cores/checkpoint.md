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
- [x] Thống kê đọc SQLite và hiển thị số liệu/biểu đồ hợp lý với dữ liệu mẫu.
- [x] Form công việc đọc danh mục từ bảng `categories`; xóa danh mục đặt `category_id` liên quan về `NULL`.
- [x] Dark mode và cài đặt còn sau khi khởi động lại.
- [x] Responsive cơ bản được kiểm tra ở kích thước hẹp và rộng bằng widget test.
- [x] Hai phần đã tích hợp; luồng tạo → hoàn thành → thống kê → xóa task kiểm thử chạy trên emulator.
- [x] Có bug list với mức độ, người xử lý và hạn sửa.

**Gate:** Không vào tuần 3 khi còn lỗi chặn tạo/sửa/hoàn thành công việc hoặc mất dữ liệu.

**Biên bản tuần 2:** Ngày ____ · Commit tích hợp ____ · Lỗi P0/P1 ____ · Kế hoạch xử lý ____

### Báo cáo Ngày 8 — SV-B (Vũ) — đối chiếu repository 14/11/2026

> Đây là trạng thái tại thời điểm bàn giao Ngày 8; phần provider và màn tổng
> quan đã được tiếp tục trong báo cáo Ngày 9 bên dưới.

- Đã triển khai `StatsRepository` đọc trực tiếp bảng `tasks`: tổng số task,
  số đã hoàn thành, số chưa hoàn thành, tỷ lệ hoàn thành và số task đến hạn/
  đang hoàn thành theo từng ngày từ thứ Hai đến Chủ nhật.
- Tuần không có dữ liệu vẫn trả đủ bảy ngày với số đếm bằng 0; task không có
  hạn không được tính vào thống kê tuần. Schema hiện không có `completed_at`,
  nên biểu đồ tuần phản ánh trạng thái hiện tại theo ngày đến hạn, không phải
  ngày task thực sự được hoàn thành.
- Đã thêm `test/stats_repository_test.dart`; cả bốn test SQLite FFI về dữ liệu
  rỗng, tổng quan, ranh giới tuần và tuần không có task đều đạt. `flutter
  analyze --no-pub` trên repository và test đạt **No issues found**.
- Chạy toàn bộ `flutter test`: 13 test đạt, gồm cả bốn test thống kê; bốn test
  widget hiện có thất bại do còn kỳ vọng nội dung/route placeholder cũ và gặp
  lỗi layout/`pumpAndSettle` trên giao diện hiện tại. Đây là test UI ngoài phạm
  vi Ngày 8; cần cập nhật ở đầu việc tích hợp/kiểm thử riêng.
- Ở thời điểm này, đây mới là phần repository; `StatsProvider` và màn thống kê
  chưa nối repository.

### Báo cáo Ngày 9 — SV-B (Vũ) — đối chiếu repository 14/11/2026

- Đã triển khai `StatsProvider`, đăng ký trong `TaskFlowApp` và nối trang Thống
  kê với tổng số, đã hoàn thành và chưa hoàn thành từ SQLite.
- Trang tự tải khi mở, hỗ trợ kéo để tải lại, hiển thị loading/error cùng nút
  thử lại, và thông báo riêng khi chưa có công việc. Thẻ số liệu tự bố trí 2/3
  cột theo chiều rộng màn hình.
- Các test repository/provider/giao diện thống kê đạt **9/9**; `flutter analyze
  --no-pub` toàn dự án đạt **No issues found**.
- Toàn bộ `flutter test`: **18 test đạt, 4 widget test cũ thất bại** do kỳ vọng
  dashboard/route placeholder cũ, `pumpAndSettle` timeout và lỗi overflow ở
  trang công việc. Các test thống kê mới đều đạt; cần xử lý test UI cũ riêng.
- Chưa có kiểm tra trên emulator/thiết bị; biểu đồ tuần chưa triển khai. Vì vậy
  tiêu chí nghiệm thu tổng thể Checkpoint 3 vẫn để unchecked.

**Việc tiếp theo của SV-B:** Ngày 10 đánh giá biểu đồ tuần và dependencies; ưu
tiên số liệu chính xác, không diễn giải trạng thái hiện tại thành ngày hoàn thành.

### Báo cáo Ngày 10 — SV-B (Vũ) — đối chiếu repository 14/11/2026

- Đã tải dữ liệu tuần từ `StatsRepository` qua `StatsProvider` cùng lượt với
  tổng quan; provider chỉ công bố bộ số liệu sau khi cả hai truy vấn thành công.
- Đã thêm biểu đồ cột xếp chồng bảy ngày trong
  `lib/features/statistics/ui/weekly_task_chart.dart`, phân biệt task đã/chưa
  hoàn thành và hiển thị ngày trong tuần. Biểu đồ ghi rõ số liệu nhóm theo ngày
  đến hạn và trạng thái hiện tại, không ngụ ý ngày hoàn thành thực tế.
- Biểu đồ dùng widget Flutter, không thêm dependency. Khi không có task đến hạn,
  biểu đồ hiển thị thông báo rỗng và đủ các mốc ngày.
- Chạy test repository/provider/giao diện thống kê: **10/10 đạt**;
  `flutter analyze --no-pub` toàn dự án đạt **No issues found**. Toàn bộ test
  suite có **19 test đạt, 4 widget test cũ thất bại** do kỳ vọng dashboard/route
  placeholder cũ, `pumpAndSettle` timeout và lỗi overflow ở trang công việc;
  không có test thống kê thất bại.
- Chưa xác nhận trực quan trên emulator/thiết bị; tiêu chí nghiệm thu tổng thể
  Checkpoint 3 vẫn để unchecked.

**Việc tiếp theo của SV-B:** Ngày 11 rà soát loading/error/empty của các màn,
kiểm tra theme/điều hướng; tiếp tục cập nhật test UI cũ ở phạm vi tích hợp.

### Báo cáo Ngày 11 — SV-B (Vũ) — đối chiếu repository 14/11/2026

- Màn Danh mục chờ lần tải đầu trước khi kết luận danh sách rỗng; nếu truy vấn
  danh mục lỗi khi chưa có dữ liệu, màn hiển thị lỗi/thử lại thay vì báo rỗng.
  Lỗi tải dữ liệu công việc dùng để đếm task theo danh mục cũng được hiển thị.
- Thống kê giữ loading/error/retry/empty; Cài đặt hiển thị lỗi lưu/tải và có
  thao tác tải lại. Nếu đọc preferences lỗi lúc khởi động, app ghi lỗi qua
  `FlutterError.reportError` nhưng vẫn mở bằng giá trị mặc định để người dùng
  truy cập được SettingsPage. Cài đặt là form các lựa chọn cố định nên không có
  trạng thái danh sách rỗng.
- Kiểm tra tích hợp theme sáng/tối và điều hướng các tab Danh mục/Thống kê/Cài
  đặt bằng test; không phát hiện lỗi route/theme cần sửa.
- Bộ test liên quan category/settings/statistics/navigation đạt **22/22**;
  `flutter analyze --no-pub` toàn dự án đạt **No issues found**. Toàn bộ
  `flutter test` có **25 test đạt, 4 widget test cũ thất bại** do kỳ vọng
  dashboard/route placeholder cũ, timeout và overflow ở trang công việc; không
  có test mới thuộc phạm vi Ngày 11 thất bại.
- Chưa xác nhận trực quan trên thiết bị; Checkpoint 3 vẫn chưa nghiệm thu.

**Việc tiếp theo của SV-B:** Ngày 12 kiểm tra responsive lưới danh mục và màn
thống kê trên các kích thước mục tiêu; giữ nguyên giới hạn diễn giải biểu đồ tuần.

### Báo cáo Ngày 12 — SV-B (Vũ) — đối chiếu repository 14/11/2026

- Kiểm tra widget lưới danh mục tại 320, 390, 600, 720, 724, 1024 và 1080 px.
  Phát hiện hai cột trên màn 320 px khiến nội dung thẻ quá hẹp; đã điều chỉnh
  grid theo bề rộng thẻ mục tiêu khoảng 220 px, tối đa bốn cột, và giới hạn
  chiều cao thẻ một cột.
- Kiểm tra thẻ tổng quan và biểu đồ ở 320, 375, 475, 476, 600 và 1024 px.
  Thẻ số liệu giữ 2 cột khi vùng nội dung dưới 440 px và chuyển sang 3 cột khi
  đủ rộng; kiểm tra hàng thẻ và xác nhận không có layout exception.
- Hai file widget test liên quan đạt **9/9**; `flutter analyze --no-pub` đạt
  **No issues found**. Toàn bộ `flutter test` có **27 test đạt, 4 test cũ
  thất bại** trong `test/widget_test.dart` do kỳ vọng UI/route placeholder cũ,
  timeout `pumpAndSettle` và overflow ở trang công việc; các test responsive
  mới đều đạt.
- Chưa có emulator/thiết bị để xác minh trực quan; kết quả hôm nay giới hạn ở
  widget test. Checkpoint 3 vẫn chưa nghiệm thu do còn test/UI và kiểm tra thiết
  bị cần xử lý riêng.

**Việc tiếp theo của SV-B:** Ngày 13 kiểm tra xóa danh mục đang được công việc
sử dụng, persistence cài đặt và giữ nguyên cách diễn giải thống kê tuần.

### Báo cáo Ngày 13 — SV-B (Vũ) — đối chiếu repository 14/11/2026

- Trên Android emulator (API 37), tạo danh mục, gán vào một task có sẵn rồi
  xóa danh mục qua UI. Màn danh mục xác nhận có **1 công việc** trước khi xóa;
  sau xóa task vẫn còn và màn chi tiết hiện **Không có danh mục**.
- Đọc SQLite trực tiếp trước/sau cold-start: sau xóa có **1 task**, **0
  category**, `category_id IS NULL`. Test repository cũng xác nhận task còn
  trong DB và `TaskRepository` chuyển thành `Task.categoryId == null`.
- Đổi cài đặt sang theme tối và nhắc trước **30 phút**, force-stop rồi mở lại
  app. Theme tối và 30 phút vẫn hiển thị trong SettingsPage; SharedPreferences
  trên emulator giữ đúng hai giá trị. Đã khôi phục theme sáng và nhắc trước
  **15 phút** sau khi kiểm tra.
- `category_repository_test.dart`: **3/3 đạt**; `settings_provider_test.dart`:
  **3/3 đạt**, gồm tải lại bằng provider mới. `flutter analyze --no-pub` đạt
  **No issues found**. Toàn bộ `flutter test`: **27 đạt, 4 test cũ thất bại**
  trong `test/widget_test.dart` do kỳ vọng UI/route placeholder cũ,
  `pumpAndSettle` timeout và overflow tại trang công việc; không có lỗi mới
  thuộc phạm vi Ngày 13.
- Kiểm tra cold-start thực hiện trên emulator; không thay đổi schema hoặc
  production code vì khóa ngoại `ON DELETE SET NULL` và lưu preferences đã
  hoạt động đúng.

**Việc tiếp theo của SV-B:** Ngày 14 chạy thử end-to-end cùng Thắng, ghi nhận
bug còn lại và giữ nguyên dữ liệu/cài đặt đã xác minh.

### Báo cáo kiểm thử tích hợp Ngày 14 — 14/11/2026

- **Tích hợp:** working tree ở branch `vu`, HEAD `a42960b`
  (`Merge pull request #4 from GH-Courses/Thangb23606582`); thay đổi của nhánh
  Thắng đã có trong branch hiện tại, không cần merge lại. Không tạo commit hoặc
  push.
- **Emulator Android API 37:** tạo task `Day14 e2e task`, xác nhận task xuất
  hiện trong danh sách và thống kê tăng tổng số từ 1 lên 2; đánh dấu hoàn thành,
  xác nhận task chuyển sang bộ lọc hoàn thành và thống kê thành 2 tổng/1 hoàn
  thành/1 chưa hoàn thành; xóa task kiểm thử có xác nhận. Sau dọn dữ liệu, thống
  kê trở về 1 tổng/0 hoàn thành/1 chưa hoàn thành. Màn danh mục hiển thị trạng
  thái rỗng sau kịch bản xóa danh mục Ngày 13.
- **Tích hợp khác đã xác nhận trước đó:** xóa danh mục có task tham chiếu giữ
  task và đưa `category_id` về `NULL`; theme và thời gian nhắc lưu qua
  cold-start; responsive danh mục/thống kê đã có widget test.
- **Kiểm tra tự động:** `flutter analyze --no-pub` đạt **No issues found**;
  `flutter build apk --debug` thành công tại
  `build/app/outputs/flutter-apk/app-debug.apk`; `flutter test` có **27 đạt,
  4 thất bại**, đều trong `test/widget_test.dart`. Một failure liên quan test
  dashboard/viewport thấp và có log `RenderFlex overflowed by 194 pixels` ở
  `TasksPage`; ba test còn lại timeout khi `pumpAndSettle` ở test route
  placeholder, cài đặt và CRUD danh mục. Timeout chưa được xác nhận là lỗi
  runtime; chi tiết phân loại xem [bug.md](./bug.md).
- **Giới hạn kiểm thử:** chưa xác nhận luồng sửa task và notification thực tế
  trên thiết bị; chưa có bằng chứng hai người cùng thao tác kiểm thử trực tiếp.
  Vì vậy chưa coi toàn bộ gate Ngày 14 là nghiệm thu cuối.

**Việc tiếp theo:** xử lý overflow ở viewport nhỏ và làm ổn định/cập nhật các
widget test cũ; kiểm tra lại CRUD category/settings bằng test không treo; hoàn
thiện kiểm thử sửa task và notification trên thiết bị nếu có. Giữ nguyên việc
không commit/push nếu chưa được yêu cầu.

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
