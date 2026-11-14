# Schema cơ sở dữ liệu TaskFlow

> **Trạng thái:** DDL đã được triển khai trong `lib/core/database/database_helper.dart`
> (version 1). Category và Task model/repository/provider dùng schema này; database
> được mở khi một repository truy cập dữ liệu.
>
> **CSDL mục tiêu:** SQLite.

```sql
PRAGMA foreign_keys = ON;

CREATE TABLE categories (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    name       TEXT NOT NULL UNIQUE,
    color      INTEGER,
    created_at TEXT NOT NULL
);

CREATE TABLE tasks (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    title        TEXT NOT NULL,
    description  TEXT,
    due_at       TEXT,
    priority     INTEGER NOT NULL DEFAULT 1
                 CHECK (priority IN (1, 2, 3)),
    is_completed INTEGER NOT NULL DEFAULT 0
                 CHECK (is_completed IN (0, 1)),
    category_id  INTEGER,
    reminder_at  TEXT,
    created_at   TEXT NOT NULL,
    updated_at   TEXT NOT NULL,
    FOREIGN KEY (category_id)
        REFERENCES categories (id)
        ON DELETE SET NULL
);
```

## Quy ước dữ liệu

- `priority`: `1` = thấp, `2` = vừa, `3` = cao.
- `is_completed`: `0` = chưa hoàn thành, `1` = đã hoàn thành.
- `color` là số nguyên, có thể lưu giá trị màu ARGB; các cột `color`,
  `description`, `due_at`, `category_id` và `reminder_at` được phép `NULL`.
- Các cột ngày giờ (`created_at`, `updated_at`, `due_at`, `reminder_at`) lưu
  dưới dạng chuỗi ISO 8601. SQLite không có kiểu ngày giờ riêng.
- Khi xóa danh mục, `ON DELETE SET NULL` giữ lại task nhưng bỏ liên kết danh mục.
  Database helper phải bật kiểm tra khóa ngoại cho kết nối SQLite.
- Model `Task`/`Category` và repository cần dùng đúng tên cột trong schema này;
  ngày giờ cần được chuyển đổi nhất quán khi đọc/ghi.
- Khi schema thay đổi sau khi phát hành, tăng version database và viết migration;
  không xóa dữ liệu người dùng để né migration.

## Quy ước thống kê

- Tổng quan lấy tổng số task, số đã hoàn thành (`is_completed = 1`) và số chưa
  hoàn thành (`is_completed = 0`) trực tiếp từ bảng `tasks`. Tỷ lệ hoàn thành
  bằng số đã hoàn thành chia tổng số; khi chưa có task, tỷ lệ là `0`.
- Thống kê tuần dùng tuần lịch từ thứ Hai đến Chủ nhật theo ngày đến hạn
  `due_at`; mỗi ngày trả tổng số task đến hạn và số hiện đang hoàn thành. Ngày
  không có task vẫn có số liệu bằng `0`; task không có hạn không thuộc biểu đồ.
- Schema hiện không lưu thời điểm hoàn thành riêng. Vì vậy, số task hoàn thành
  theo ngày trong thống kê tuần là trạng thái hiện tại của các task đến hạn ngày
  đó, không biểu thị task đã được hoàn thành đúng ngày ấy. Muốn đo thời điểm
  hoàn thành thực tế cần thống nhất và migration schema riêng.
