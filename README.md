### 1. Mục tiêu trang web
- Tạo một trang chủ ấn tượng, đậm chất kiếm hiệp, thu hút người chơi mới và giữ chân cộng đồng.
- Cung cấp thông tin về game, các sự kiện, tính năng, hướng dẫn, hệ thống môn phái, và các liên kết tải game, nạp thẻ, đăng ký.
- Dễ dàng quản trị nội dung qua trang Admin.

---

### 2. Chức năng chính của trang web

#### **A. Trang Landing Page (cho người chơi)**
- Giao diện đẹp, đậm chất kiếm hiệp, màu sắc chủ đạo: vàng nhạt, cam nhạt, đỏ.
- Responsive tốt trên mọi thiết bị.
- Có hiệu ứng động khi cuộn trang và khi chuyển đổi các mục (ví dụ: slider môn phái).
- Các khu vực chính:
  1. **Banner chính:** Hình ảnh lớn, nút tải game, nạp thẻ, đăng ký, ngày ra mắt.
  2. **Tin tức - Sự kiện:** Danh sách các bài viết mới nhất, phân loại theo tab (Tin tức, Sự kiện, Hướng dẫn, Tính năng).
  3. **Hệ thống môn phái:** Slider các môn phái, mỗi môn phái có hình ảnh và mô tả ngắn.
  4. **Tính năng huyền thoại:** Giới thiệu các tính năng đặc sắc của game.
  5. **Footer:** Thông tin nhà phát hành, bản quyền, liên hệ.

#### **B. Trang Admin (cho quản trị viên)**
- Đăng nhập bằng Clerk.
- Quản lý các nội dung trên trang Home:
  - Thay đổi ảnh nền, ảnh nút, link tải game ở khu vực tải game.
  - Thêm/sửa/xóa bài viết (tin tức, sự kiện, hướng dẫn, tính năng), upload ảnh banner, nhập link nội dung chi tiết.
  - Thêm/sửa/xóa môn phái, upload ảnh đại diện môn phái.
  - Quản lý các cài đặt chung (ảnh, link, v.v.).

---

### 3. Cấu trúc các bảng dữ liệu (backend)

#### **A. Bảng `posts` (Bài viết, tin tức, sự kiện, hướng dẫn, tính năng)**
- `id`: Mã định danh bài viết (tự tăng)
- `title`: Tiêu đề bài viết
- `category`: Phân loại ("tin_tuc", "su_kien", "huong_dan", "tinh_nang")
- `banner_url`: Đường dẫn ảnh banner
- `content_url`: Đường dẫn tới nội dung chi tiết (có thể là link ngoài hoặc link nội bộ)
- `published_at`: Ngày đăng
- `created_by`: Người tạo (nếu cần)

#### **B. Bảng `sects` (Hệ thống môn phái)**
- `id`: Mã định danh môn phái
- `name`: Tên môn phái (ví dụ: "Tiêu Dao")
- `image_url`: Đường dẫn ảnh đại diện môn phái
- `description`: Mô tả ngắn về môn phái
- `order`: Thứ tự hiển thị

#### **C. Bảng `site_settings` (Cài đặt chung cho trang web)**
- `key`: Tên cài đặt (ví dụ: "download_background_url", "download_button_image_url", "download_link")
- `value`: Giá trị cài đặt (đường dẫn ảnh, link, v.v.)

#### **D. Bảng `users` (Quản lý tài khoản Admin)**
- `id`: Mã người dùng (sẽ được đồng bộ từ Clerk, không phải số tự tăng).
- `email`: Địa chỉ email của quản trị viên.
- `username`: Tên đăng nhập.
- `role`: Vai trò (ví dụ: "admin", "editor") để phân quyền trong trang quản trị.
- `full_name`: Tên đầy đủ (tùy chọn).
- `avatar_url`: Link ảnh đại diện (tùy chọn).
- **Lưu ý:** Mật khẩu sẽ do Clerk quản lý và mã hóa an toàn, không lưu trong bảng này.

#### **E. (Tùy chọn) Bảng `features` (Tính năng huyền thoại)**
- `id`: Mã định danh tính năng
- `title`: Tên tính năng
- `image_url`: Ảnh minh họa
- `description`: Mô tả ngắn
- `order`: Thứ tự hiển thị

---

### 4. Ghi chú
- Các bảng trên có thể mở rộng thêm trường nếu phát sinh nhu cầu thực tế.
- Tất cả nội dung đều có thể quản lý dễ dàng qua trang Admin, không cần biết kỹ thuật.
