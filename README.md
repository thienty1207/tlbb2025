# Thiên Long Bát Bộ - Game Landing Page (với Clerk Authentication)

Dự án website landing page cho game Thiên Long Bát Bộ, bao gồm trang chủ cho người chơi và hệ thống quản trị cho admin. Sử dụng kiến trúc tách biệt frontend React và backend Node.js Express với Clerk Authentication.

## Cấu trúc dự án

```
thienlongbb/
├── frontend/
│   └── src/
│       ├── assets/         # Hình ảnh, font, icon
│       ├── components/
│       │   ├── ui/         # Components từ shadcn/ui
│       │   └── layout/     # Layout components (Navbar, Footer, etc.)
│       ├── constants/      # Hằng số (API endpoints, routes)
│       ├── hooks/          # Custom React hooks
│       ├── lib/            # Utility functions, API client
│       ├── pages/          # Page components
│       ├── services/       # API interaction logic
│       ├── styles/         # Global styles, Tailwind config
│       └── types/          # TypeScript type definitions
├── backend/
│   └── src/
│       ├── controllers/    # Route handlers và business logic
│       ├── models/         # Database models
│       ├── routes/         # Express route definitions
│       ├── middleware/     # Custom middleware (Clerk auth, validation)
│       ├── config/         # Configuration files
│       ├── services/       # Business services (file upload, etc.)
│       └── utils/          # Utility functions
├── mysql_setup.sql         # SQL để thiết lập database MySQL
├── react-frontend-rules.mdc     # Quy tắc phát triển frontend
└── nodejs-backend-rules.mdc     # Quy tắc quản lý backend
```

## Thiết lập Database (MySQL)

### Bước 1: Cài đặt MySQL

Đảm bảo bạn đã cài đặt MySQL Server trên máy hoặc sử dụng XAMPP/WAMP.

### Bước 2: Tạo Database và Tables

1. Mở phpMyAdmin hoặc MySQL Workbench
2. Tạo database mới tên `thienlongbb` (hoặc chạy lệnh trong file SQL)
3. Copy toàn bộ nội dung file `mysql_setup.sql` và chạy

### Bước 3: Thiết lập Clerk Authentication

- **Tài khoản admin sẽ được tạo tự động** khi bạn đăng nhập lần đầu qua Clerk
- Backend sẽ sync thông tin user từ Clerk vào MySQL
- Không cần tạo tài khoản thủ công

## Stack Công nghệ

### Frontend
- **React** với TypeScript
- **Vite** hoặc Create React App
- **Tailwind CSS** cho styling
- **shadcn/ui** cho UI components
- **Framer Motion** cho animations
- **Swiper.js** cho carousels
- **@tanstack/react-query** cho state management
- **React Router v6** cho routing
- **Axios** cho HTTP requests
- **@clerk/clerk-react** cho authentication

### Backend
- **Node.js** với **Express.js**
- **MySQL** database
- **@clerk/clerk-sdk-node** cho Clerk integration
- **Multer** cho file upload
- **Joi** cho input validation
- **Helmet** cho security headers

### Development Tools
- **ESLint** + **Prettier** cho code quality
- **Nodemon** cho development server
- **dotenv** cho environment variables

### Authentication
- **Clerk** - Complete authentication solution
- **JWT tokens** được Clerk tự động quản lý
- **Role-based authorization** qua MySQL

## Cấu trúc Database (MySQL)

### Bảng chính:
- `users` - Thông tin user đồng bộ từ Clerk (clerk_id, email, role)
- `posts` - Bài viết, tin tức, sự kiện, hướng dẫn
- `sects` - Hệ thống môn phái
- `features` - Tính năng huyền thoại
- `site_settings` - Cài đặt chung trang web

### API Endpoints:
- **Authentication:** `/api/auth/*` (sync-user, me, update-role)
- **Posts Management:** `/api/posts/*`
- **Sects Management:** `/api/sects/*`
- **Features Management:** `/api/features/*`
- **Site Settings:** `/api/site-settings/*`
- **File Upload:** `/api/upload`

## Tính năng Authentication (Clerk)

### Đăng nhập với Clerk
- **Login options:** Email/Password, Google, GitHub, Facebook, v.v.
- **Sign up:** Tự động tạo tài khoản mới
- **Password reset:** Clerk tự động xử lý qua email
- **Email verification:** Tự động gửi email xác thực
- **Session management:** JWT tokens được Clerk quản lý

### User Synchronization
- **Quy trình:**
  1. User đăng nhập qua Clerk trên frontend
  2. Frontend nhận JWT token từ Clerk
  3. Frontend gọi API `/api/auth/sync-user` để đồng bộ data
  4. Backend tạo/cập nhật user record trong MySQL
  5. Backend trả về role cho frontend authorization

### Role Management
- **Default role:** 'admin' cho tất cả user mới
- **Role assignment:** Admin có thể thay đổi role qua admin panel
- **Authorization:** Frontend kiểm tra role để hiển thị UI phù hợp

## Bảo mật

- **Clerk JWT Authentication** với automatic token refresh
- **Backend token verification** với Clerk SDK
- **Input validation** cho tất cả API endpoints
- **SQL injection prevention** với parameterized queries
- **CORS** configuration cho production
- **Rate limiting** cho API endpoints
- **File upload security** với validation
- **Role-based authorization** từ MySQL database

## Thiết lập Clerk

### Bước 1: Tạo Clerk Application
1. Đăng ký tài khoản tại [clerk.com](https://clerk.com)
2. Tạo application mới
3. Lấy Publishable Key và Secret Key

### Bước 2: Cấu hình Authentication Methods
- Enable Email/Password
- Enable Google OAuth (optional)
- Configure sign-up settings
- Set up email templates

### Bước 3: Domain Configuration
- Add development domain: `http://localhost:5173`
- Add production domain khi deploy: `https://thienlongbb2025.com`

## Thiết lập môi trường phát triển

### Prerequisites
- Node.js 18+
- MySQL 8.0+
- npm hoặc yarn
- Clerk account

### Backend Setup
1. Navigate vào thư mục backend: `cd backend`
2. Cài đặt dependencies: `npm install`
3. Tạo file `.env` với các biến môi trường cần thiết:
   ```env
   NODE_ENV=development
   PORT=3000
   DB_HOST=localhost
   DB_PORT=3306
   DB_NAME=thienlongbb
   DB_USER=root
   DB_PASSWORD=your_mysql_password
   
   # Clerk Configuration
   CLERK_SECRET_KEY=sk_test_your_clerk_secret_key
   
   # File Upload
   UPLOAD_PATH=./uploads
   FRONTEND_URL=http://localhost:5173
   ```
4. Chạy server: `npm run dev`

### Frontend Setup
1. Navigate vào thư mục frontend: `cd frontend`
2. Cài đặt dependencies: `npm install`
3. Tạo file `.env` cho frontend:
   ```env
   VITE_CLERK_PUBLISHABLE_KEY=pk_test_your_clerk_publishable_key
   VITE_API_URL=http://localhost:3000/api
   ```
4. Chạy development server: `npm run dev`

## Deployment

### Backend Deployment
- Có thể deploy lên VPS, Heroku, hoặc Railway
- Cấu hình MySQL database trên production
- Thiết lập environment variables production
- **Không cần cấu hình email service** - Clerk tự động xử lý

### Frontend Deployment
- Build ứng dụng: `npm run build`
- Deploy lên Vercel, Netlify, hoặc hosting tĩnh
- Cập nhật API URL cho production environment
- **Cập nhật domain trên Clerk Dashboard** cho production

### Clerk Production Setup
1. **Domain configuration:** Add production domain vào Clerk
2. **Environment keys:** Use production keys thay vì test keys
3. **Webhooks:** Cấu hình webhooks cho real-time user sync (optional)

## Phát triển

### Quy trình làm việc:
1. **Setup Clerk:** Cấu hình authentication trước
2. **Backend:** Thiết lập API endpoints và database
3. **Frontend:** Xây dựng giao diện và kết nối Clerk + API
4. **Testing:** Test authentication flow và API integration
5. **Deployment:** Deploy cả frontend và backend với production Clerk

### Chạy đồng thời:
- Backend: `cd backend && npm run dev` (port 3000)
- Frontend: `cd frontend && npm run dev` (port 5173)

## Tính năng chính

### Trang Landing Page (Người chơi)
- Giao diện đẹp, đậm chất kiếm hiệp
- Responsive design
- Animations khi scroll
- Slider môn phái và tính năng
- Hiển thị tin tức, sự kiện mới nhất

### Trang Admin (Quản trị viên)
- **Đăng nhập an toàn với Clerk** (Email/Password + OAuth)
- **Quên mật khẩu:** Clerk tự động gửi email reset
- **Multi-factor authentication:** Optional, có thể enable trên Clerk
- Quản lý bài viết (CRUD)
- Quản lý môn phái (CRUD)  
- Quản lý tính năng game (CRUD)
- Upload và quản lý hình ảnh
- Cập nhật cài đặt trang web
- User management và role assignment

## Ưu điểm của Clerk Integration

### Cho Developer:
- **Không cần code authentication logic** - Clerk xử lý hết
- **Không cần setup email service** - Clerk tự động gửi email
- **Automatic security features** - 2FA, fraud detection, etc.
- **Easy to scale** - Clerk handle unlimited users

### Cho User:
- **Multiple login options** - Email, Google, GitHub, etc.
- **Seamless user experience** - Professional auth UI
- **Secure password reset** - Automatic email flow
- **Profile management** - User có thể tự update thông tin

### Cho Production:
- **99.9% uptime** - Clerk infrastructure rất stable
- **Global CDN** - Fast loading worldwide
- **GDPR compliant** - Automatic privacy compliance
- **Easy domain management** - No CORS issues

## Liên hệ

- Project: Thiên Long Bát Bộ Landing Page
- Architecture: Frontend (React + Clerk) + Backend (Node.js) + Database (MySQL)
- Features: Complete Authentication System with Clerk Integration
- Deployment: Easy deployment với Clerk cloud infrastructure
