# Đặc tả giao diện theo ảnh demo

> Codebase là repository `26-27hk1-ct48401-labs-thangb2306582` ở thư mục ngang cấp với `project`. Đây là app bán hàng đã có Provider/GoRouter/theme/drawer, không phải counter scaffold. Mockup là Habit Tracker; các module products/cart/orders không phải tính năng đích. Ảnh gốc ở [thư mục anh](../anh/).

## 1. Đọc bộ ảnh demo

| Ảnh | Màn hình / ý tưởng chính | Vai trò trong app |
|---|---|---|
| `Screenshot 2026-11-07 085953.png` | Trang chủ: lời chào, nút thêm, lối tắt thể loại/lịch/tìm kiếm, nhóm hôm nay/ngày mai/tuần này | Màn tổng quan và danh sách việc/thói quen theo ngày |
| `Screenshot 2026-11-07 090007.png` | Navigation drawer màu xanh lá, hồ sơ và các mục chức năng | Điều hướng tới các khu vực chính |
| `Screenshot 2026-11-07 090011.png` | Lịch và lời nhắc: đồng hồ/lịch trực quan, danh sách mục đến hạn và thao tác nhanh | Lịch, nhắc việc và danh sách theo thời gian |
| `Screenshot 2026-11-07 090015.png` | Lưới thể loại nhiều màu pastel, icon và số lượng | Quản lý danh mục |
| `Screenshot 2026-11-07 090022.png` | Nhật ký rỗng, minh họa sổ và CTA tạo thói quen đầu tiên | Empty state cho nhật ký |
| `Screenshot 2026-11-07 090025.png` | Danh sách thói quen dạng thẻ màu, số ngày hoàn thành và nút thêm nổi | Nhật ký/danh sách thói quen |
| `Screenshot 2026-11-07 090029.png` | Chi tiết thói quen, thống kê tiến độ, lịch chọn ngày và cấu hình lịch lặp | Chi tiết và theo dõi tiến độ một thói quen |
| `Screenshot 2026-11-07 090034.png` | Điểm thưởng, số xu, nhiệm vụ và đổi thưởng | Khu vực điểm thưởng; mở rộng so với phân công gốc |
| `Screenshot 2026-11-07 090037.png` | Mục tiêu hằng ngày/hằng tuần, checklist và CTA hoàn tất | Mục tiêu; có thể biểu diễn bằng task lặp lại trong bản đầu |
| `Screenshot 2026-11-07 090040.png` | Streak cá nhân/bạn bè, lịch tô màu các ngày liên tiếp | Chuỗi ngày; mở rộng so với phân công gốc |

## 2. Phong cách giao diện cần bám

- **Tông màu:** nền xanh xám/pastel rất nhạt; khối nội dung xanh dương nhạt; dùng xanh lá mint, vàng, cam, hồng, tím nhạt để phân biệt thẻ/danh mục. Tránh nền trắng tinh toàn màn.
- **Bề mặt:** thẻ bo góc lớn, viền mảnh hoặc bóng đổ nhẹ; nút chính bo viên thuốc; vùng nhấn có tương phản đủ để đọc.
- **Chữ:** tiêu đề màn hình lớn, đậm, xanh xám đậm; nội dung và nhãn ngắn, dễ quét. Không dùng bóng chữ nặng như mockup nếu làm giảm độ rõ.
- **Icon:** icon line đơn giản, nhất quán trong cùng một hệ; icon danh mục đặt trong ô nền sáng riêng.
- **Bố cục:** ưu tiên thẻ phân nhóm theo ngày/trạng thái, số liệu căn thẳng hàng, thao tác chính dễ chạm bằng một tay.
- **Điều hướng:** drawer như ảnh 090007 là mẫu tham khảo. Trên điện thoại có thể dùng drawer kết hợp bottom navigation rút gọn; tránh đưa toàn bộ 9 mục lên thanh đáy.
- **Khả năng đọc:** chữ tương phản đạt mức dễ đọc, vùng chạm đủ lớn, trạng thái không chỉ dựa vào màu (kèm nhãn/icon).

## 3. Bản đồ màn hình và chủ sở hữu

| Màn hình | Thành phần chính theo ảnh | Chủ sở hữu đề xuất | Ưu tiên |
|---|---|---|---|
| Trang chủ | Lời chào, ngày hiện tại, nút `+`, chip Thể loại/Lịch/Tìm kiếm, nhóm Hôm nay/Ngày mai/Trong tuần, tiến độ hoàn tất | SV-A; SV-B sở hữu shell/theme | P0 |
| Tạo/sửa mục | Tên, ghi chú, thể loại, ngày/giờ, mức ưu tiên, lịch lặp/nhắc | SV-A | P0 |
| Chi tiết mục | Thông tin, trạng thái, lịch sử/ngày thực hiện, chỉnh sửa/xóa | SV-A | P0 |
| Lịch và lời nhắc | Lịch chọn ngày, danh sách mục theo thời gian, thao tác hoàn thành/sửa/xóa | SV-A; route/shell chung do SV-B | P1 |
| Thể loại | Grid thẻ màu, icon, tên và số lượng; thêm/sửa/xóa bằng dialog | SV-B | P0 |
| Cài đặt | Theme sáng/tối, thời gian nhắc mặc định, thông tin app | SV-B | P0 |
| Nhật ký | Danh sách thói quen; empty state có minh họa/CTA | SV-A nếu đổi định hướng sang thói quen; nếu giữ TaskFlow thì dùng cho lịch sử công việc hoàn thành | P1 |
| Chi tiết thói quen | Mục tiêu, lịch lặp, tiến độ và lịch đánh dấu ngày | SV-A; cần xác nhận domain habit | P2 |
| Thống kê | Số liệu tổng quan và biểu đồ theo tuần, cùng phong cách thẻ pastel | SV-B | P1 |
| Mục tiêu | Checklist mục tiêu ngày/tuần | SV-A hoặc SV-B theo quyết định domain | P2 |
| Streak / Điểm thưởng | Lịch chuỗi ngày, xu và đổi thưởng | Chưa phân công; chỉ làm khi có duyệt phạm vi | P2 |
| Drawer | Hồ sơ/đăng nhập và danh sách khu vực | SV-B | P1 |

### Ánh xạ domain để không hiểu nhầm

Nếu giữ TaskFlow theo phân công hiện tại, `task` được gọi thân thiện là “công việc/mục tiêu”, Nhật ký có thể là lịch sử hoàn thành, còn streak/điểm thưởng/đăng nhập/bạn bè là ý tưởng tham khảo chưa thuộc P0. Nếu nhóm muốn app là Habit Tracker như mockup, cần thống nhất lại model (thói quen, lịch lặp, lần thực hiện), schema, phân công và mục tiêu 21 ngày trước khi code; không nên chỉ đổi nhãn UI trong khi dữ liệu vẫn mang ngữ nghĩa khác.

## 4. Component dùng chung

SV-B định nghĩa style tokens/theme trong vùng chung ngày 1–2; SV-A sử dụng `Theme.of(context)` và component được thống nhất, không tự đặt màu tùy ý.

- `AppScaffold`: nền, vùng nội dung an toàn, app bar và drawer/shell.
- `PastelCard`: nền màu semantic, bo góc, khoảng đệm nhất quán.
- `CategoryChip` / `CategoryCard`: icon, tên, số lượng và màu danh mục.
- `ProgressSummary`: số hoàn tất/tổng, thanh tiến độ và nhãn.
- `DateGroupHeader`: ngày, số lượng hoàn tất, thu gọn/mở rộng.
- `EmptyState`: icon/minh họa, thông điệp ngắn, CTA.
- `PrimaryActionButton` và nút thêm nổi `+`.
- Trạng thái loading/error/empty dùng chung quy tắc; thao tác xóa có xác nhận.

Thông số khởi điểm để nhóm tinh chỉnh: khoảng đệm màn 16–20 dp; khoảng cách thẻ 12–16 dp; bo góc 16–24 dp; vùng chạm tối thiểu theo guideline Flutter/Material. Ưu tiên dùng theme token thay vì rải số/màu trong widget.

## 5. Responsive và tương tác

- Điện thoại hẹp: một cột; nhóm ngày dạng accordion; drawer hoặc navigation gọn; nút thêm luôn dễ thấy.
- Điện thoại rộng/tablet: lưới danh mục 2–4 cột; trang chủ có thể chia danh sách và chi tiết hai pane; biểu đồ dùng chiều rộng khả dụng.
- Lịch: hỗ trợ chọn ngày và giữ trạng thái lọc khi trở lại màn danh sách.
- Thẻ công việc: bấm mở chi tiết; checkbox đánh dấu hoàn thành; menu sửa/xóa có nhãn trợ năng.
- Tìm kiếm/lọc: trạng thái lọc đang chọn nhìn thấy rõ và có thao tác xóa lọc.
- Dark mode: chuyển cùng palette pastel sang bề mặt tối dịu; đảm bảo chữ và icon vẫn tương phản.

## 6. Thứ tự triển khai thiết kế

1. Ngày 1–2: chốt domain (TaskFlow hay Habit Tracker), palette, typography, component cơ bản, drawer/shell và breakpoint.
2. Tuần 1: hoàn thành trang chủ, form, chi tiết, danh mục, cài đặt; dùng dữ liệu SQLite thật.
3. Tuần 2: lịch/lời nhắc, thống kê, empty/error/loading states, responsive và polish theo ảnh.
4. Tuần 3: sửa lỗi thị giác trên thiết bị thật, chụp ảnh màn hình báo cáo, không thêm P2 nếu ảnh hưởng build/nộp.

## 7. Checklist review UI

- [ ] Cùng một màu/kiểu chữ/khoảng cách cho các màn liên quan.
- [ ] Danh sách có loading, empty, error và trạng thái có dữ liệu.
- [ ] Tên dài, danh mục dài, ngày giờ và màn hình nhỏ không tràn.
- [ ] Nút thêm, hoàn thành, sửa, xóa hoạt động và có phản hồi.
- [ ] Drawer/route không che nội dung hoặc làm mất trạng thái ngoài ý muốn.
- [ ] Theme sáng/tối dễ đọc; trạng thái không phân biệt chỉ bằng màu.
- [ ] Chụp màn hình thật để so với ảnh tham khảo trước checkpoint ngày 14 và ngày 21.
