USE MochiVocab;
GO

-- Xóa dữ liệu cũ để tránh lỗi trùng lặp khi chạy lại nhiều lần
DELETE FROM User_Vocab_Tracking;
DELETE FROM Course_Vocabulary;
DELETE FROM User_Course;
DELETE FROM Vocabularies;
DELETE FROM Courses;
DELETE FROM Users;
DBCC CHECKIDENT ('Users', RESEED, 0);
DBCC CHECKIDENT ('Vocabularies', RESEED, 0);
DBCC CHECKIDENT ('Courses', RESEED, 0);
GO

-- 1. INSERT 5 USERS (Đa dạng Free và Premium)
INSERT INTO Users (name, email, password_hash, account_type) VALUES 
('Quan Tran', 'quan@mochi.com', 'hash1', 'Premium'),
('Nina Nguyen', 'nina@mochi.com', 'hash2', 'Free'),
('Dev Cuoi Tuan', 'dev@mochi.com', 'hash3', 'Premium'),
('Tester A', 'testA@mochi.com', 'hash4', 'Free'),
('BA Thực Chiến', 'ba@mochi.com', 'hash5', 'Premium');

-- 2. INSERT 3 COURSES
INSERT INTO Courses (course_name, access_condition) VALUES 
('IELTS Vocabulary 7.0', 'Free'),
('IT Professional English', 'Premium'),
('Daily Communication', 'Free');

-- 3. INSERT 15 VOCABULARIES (Từ vựng IT & IELTS)
INSERT INTO Vocabularies (word, vietnamese_meaning) VALUES 
('Algorithm', 'Thuat Toan'), ('Database', 'Co So Du Lieu'), ('Architecture', 'kien Truc'),
('Requirement', 'Yeu Cau'), ('Optimization', 'Toi Uu Hoa'), ('Deployment', 'Trien Khai'),
('Integration', 'Tich Hop'), ('Authentication', 'Xac Thuc'), ('Scalability', 'Kha Nang Mo Rong'),
('Redundancy', 'Du Thua / Du Phong'), ('Ubiquitous', 'Co Mat Khap Noi'), ('Meticulous', 'Ti mi'),
('Pragmatic', 'Thuc Te'), ('Resilient', 'Kien Cuong'), ('Innovative', 'Doi Moi');

-- 4. INSERT SỔ TAY ON TẬP (User_Vocab_Tracking)
-- test thuật toán Golden Time cho User ID = 1 (Quan Tran)
INSERT INTO User_Vocab_Tracking (user_id, vocab_id, learning_status, memory_level, next_review_time) VALUES 
-- CASE 1: ĐÃ QUÁ HẠN ÔN TẬP TRONG QUÁ KHỨ (Bắt buộc phải hiện thông báo hôm nay)
(1, 1, 'Learning', 1, DATEADD(day, -3, GETDATE())),
(1, 2, 'Learning', 2, DATEADD(day, -1, GETDATE())),
(1, 3, 'Learning', 1, DATEADD(hour, -12, GETDATE())),

-- CASE 2: VỪA TỚI HẠN TRONG HÔM NAY (Bắt buộc phải hiện thông báo)
(1, 4, 'Learning', 3, GETDATE()),
(1, 5, 'Learning', 2, GETDATE()),

-- CASE 3: TƯƠNG LAI MỚI CẦN ÔN (KHÔNG ĐƯỢC HIỆN RA trong ngày hôm nay)
(1, 6, 'Learning', 1, DATEADD(day, 1, GETDATE())),   -- Ngày mai
(1, 7, 'Learning', 3, DATEADD(day, 5, GETDATE())),   -- 5 ngày nữa
(1, 8, 'Learning', 4, DATEADD(day, 14, GETDATE())),  -- 2 tuần nữa
(1, 9, 'Mastered', 5, DATEADD(day, 30, GETDATE())),  -- Đã thuộc (Level 5)

-- Trộn vài record cho User ID = 2 (Nina) để test tính cá nhân hóa
(2, 1, 'Learning', 1, DATEADD(day, -2, GETDATE())),
(2, 5, 'Learning', 3, DATEADD(day, 10, GETDATE()));
GO

PRINT '[TECH LEAD NOTIFICATION]';
PRINT 'He thong đa san sang thuat toan Golden Time.';
