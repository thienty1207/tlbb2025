-- ===================================================================
-- THIÊN LONG BÁT BỘ - MYSQL DATABASE SETUP (với Clerk Authentication)
-- File này chứa tất cả các lệnh SQL để thiết lập database MySQL
-- Chạy trên phpMyAdmin hoặc MySQL Workbench
-- ===================================================================

-- Tạo database (nếu chưa có)
CREATE DATABASE IF NOT EXISTS `thienlongbb` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `thienlongbb`;

-- ===================================================================
-- CREATE TABLES
-- ===================================================================

-- Bảng users (Đồng bộ từ Clerk - chỉ lưu thông tin cơ bản)
CREATE TABLE `users` (
    `clerk_id` VARCHAR(255) PRIMARY KEY,  -- Clerk User ID
    `email` VARCHAR(100) UNIQUE NOT NULL,
    `username` VARCHAR(50),
    `first_name` VARCHAR(50),
    `last_name` VARCHAR(50),
    `avatar_url` TEXT,
    `role` ENUM('admin', 'editor') NOT NULL DEFAULT 'admin',
    `is_active` BOOLEAN DEFAULT TRUE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng posts (Bài viết, tin tức, sự kiện, hướng dẫn, tính năng)
CREATE TABLE `posts` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `title` VARCHAR(200) NOT NULL,
    `category` ENUM('tin_tuc', 'su_kien', 'huong_dan', 'tinh_nang') NOT NULL,
    `banner_url` TEXT,
    `content_url` TEXT NOT NULL,
    `published_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` VARCHAR(255),  -- Clerk User ID
    FOREIGN KEY (`created_by`) REFERENCES `users`(`clerk_id`) ON DELETE SET NULL
);

-- Bảng sects (Hệ thống môn phái)
CREATE TABLE `sects` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) UNIQUE NOT NULL,
    `description` TEXT,
    `image_url` TEXT NOT NULL,
    `display_order` INT DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng site_settings (Cài đặt chung cho trang web)
CREATE TABLE `site_settings` (
    `key` VARCHAR(100) PRIMARY KEY,
    `value` TEXT,
    `description` TEXT,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng features (Tính năng huyền thoại)
CREATE TABLE `features` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `title` VARCHAR(200) NOT NULL,
    `description` TEXT,
    `image_url` TEXT NOT NULL,
    `display_order` INT DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ===================================================================
-- CREATE INDEXES FOR PERFORMANCE
-- ===================================================================

CREATE INDEX `idx_posts_category` ON `posts`(`category`);
CREATE INDEX `idx_posts_published` ON `posts`(`published_at`);
CREATE INDEX `idx_sects_order` ON `sects`(`display_order`);
CREATE INDEX `idx_features_order` ON `features`(`display_order`);
CREATE INDEX `idx_users_email` ON `users`(`email`);

-- ===================================================================
-- INSERT INITIAL DATA
-- ===================================================================

-- Tài khoản admin sẽ được tạo tự động khi đăng nhập Clerk lần đầu
-- Tạm thời để trống, sẽ sync từ Clerk

-- Cài đặt trang web ban đầu
INSERT INTO `site_settings` (`key`, `value`, `description`) VALUES
('download_link', 'https://example.com/download', 'Link tải game chính thức'),
('download_background_url', '', 'URL ảnh nền cho section tải game'),
('download_button_image_url', '', 'URL ảnh cho nút tải game'),
('site_title', 'Thiên Long Bát Bộ', 'Tiêu đề trang web'),
('site_description', 'Game nhập vai kiếm hiệp hấp dẫn', 'Mô tả trang web');

-- Dữ liệu mẫu cho bài viết (created_by sẽ được cập nhật sau khi có user)
INSERT INTO `posts` (`title`, `category`, `content_url`) VALUES
('Chào mừng đến với Thiên Long Bát Bộ', 'tin_tuc', 'https://example.com/post1'),
('Sự kiện mở server đầu tiên', 'su_kien', 'https://example.com/event1'),
('Hướng dẫn tạo nhân vật', 'huong_dan', 'https://example.com/guide1'),
('Hệ thống PK độc đáo', 'tinh_nang', 'https://example.com/feature1');

-- Dữ liệu mẫu cho môn phái
INSERT INTO `sects` (`name`, `description`, `image_url`, `display_order`) VALUES
('Tiêu Dao', 'Môn phái tự do, không ràng buộc, chuyên về tốc độ và linh hoạt', 'https://example.com/sect1.jpg', 1),
('Thiếu Lâm', 'Môn phái truyền thống với võ công cứng cỏi, phòng thủ mạnh mẽ', 'https://example.com/sect2.jpg', 2),
('Võ Đang', 'Môn phái cân bằng giữa công và thủ, nội công sâu dày', 'https://example.com/sect3.jpg', 3),
('Nga Mi', 'Môn phái nữ lưu, chuyên về kiếm pháp tinh tế', 'https://example.com/sect4.jpg', 4);

-- Dữ liệu mẫu cho tính năng
INSERT INTO `features` (`title`, `description`, `image_url`, `display_order`) VALUES
('Chiến Đấu Thời Gian Thực', 'Trải nghiệm PK hấp dẫn với hệ thống chiến đấu mượt mà', 'https://example.com/feature1.jpg', 1),
('Hệ Thống Bang Hội', 'Kết nối cộng đồng, xây dựng bang hội mạnh mẽ', 'https://example.com/feature2.jpg', 2),
('Thế Giới Mở Rộng Lớn', 'Khám phá thế giới võ lâm bao la với hàng trăm địa điểm', 'https://example.com/feature3.jpg', 3);

-- ===================================================================
-- SUCCESS MESSAGE
-- ===================================================================
SELECT 'MySQL Database setup completed successfully! Ready for Clerk integration.' as status; 