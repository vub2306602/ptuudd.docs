-- TaskFlow demo data for presentation
-- Insert only into an empty taskflow.db or after clearing existing demo rows.

PRAGMA foreign_keys = ON;

DELETE FROM tasks;
DELETE FROM categories;

INSERT INTO categories (id, name, color, created_at) VALUES
  (1, 'Công việc', 14155768, '2026-11-16T08:00:00.000Z'),
  (2, 'Học tập', 16178258, '2026-11-16T08:10:00.000Z'),
  (3, 'Gia đình', 15177105, '2026-11-16T08:20:00.000Z'),
  (4, 'Sức khỏe', 14178147, '2026-11-16T08:30:00.000Z');

INSERT INTO tasks (
  id, title, description, due_at, priority, is_completed,
  category_id, reminder_at, created_at, updated_at
) VALUES
  (1, 'Hoàn thành báo cáo tuần', 'Tổng hợp kết quả công việc.',
   '2026-11-21T16:00:00.000Z', 3, 0, 1,
   '2026-11-21T15:30:00.000Z', '2026-11-16T08:40:00.000Z', '2026-11-16T08:40:00.000Z'),
  (2, 'Ôn Flutter Provider', 'Xem lại Provider và ChangeNotifier.',
   '2026-11-22T09:00:00.000Z', 2, 0, 2,
   '2026-11-22T08:30:00.000Z', '2026-11-16T09:00:00.000Z', '2026-11-16T09:00:00.000Z'),
  (3, 'Mua rau củ', NULL,
   '2026-11-21T18:00:00.000Z', 1, 1, 3, NULL,
   '2026-11-16T09:20:00.000Z', '2026-11-21T18:10:00.000Z'),
  (4, 'Chạy bộ buổi sáng', NULL,
   '2026-11-20T07:00:00.000Z', 2, 1, 4, NULL,
   '2026-11-16T09:30:00.000Z', '2026-11-20T07:30:00.000Z'),
  (5, 'Chuẩn bị họp nhóm', NULL,
   '2026-11-19T14:00:00.000Z', 3, 1, 1, NULL,
   '2026-11-16T09:40:00.000Z', '2026-11-19T14:30:00.000Z');
