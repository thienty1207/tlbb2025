# Thiên Long Bát Bộ - Backend API

Backend REST API cho dự án Thiên Long Bát Bộ sử dụng Node.js Express và Clerk Authentication.

## 📁 Cấu trúc thư mục

```
backend/
├── src/
│   ├── controllers/      # Route handlers và business logic
│   ├── models/          # Database models và schemas
│   ├── routes/          # Express route definitions
│   ├── middleware/      # Custom middleware (Clerk auth, validation)
│   ├── config/          # Configuration files (database, Clerk)
│   ├── services/        # Business services (file upload, etc.)
│   └── utils/           # Utility functions và helpers
├── uploads/             # File upload storage
│   ├── images/          # Uploaded images (JPG, PNG, GIF, WebP)
│   ├── documents/       # Uploaded documents (PDF, etc.)
│   └── temp/            # Temporary files
├── logs/                # Application logs
├── package.json         # Dependencies và scripts
├── env.example          # Environment variables template
├── .gitignore           # Git ignore rules
└── README.md            # This file
```

## 🚀 Setup Instructions

### 1. Cài đặt Dependencies
```bash
npm install
```

### 2. Cấu hình Environment Variables
```bash
# Copy template
cp env.example .env

# Chỉnh sửa .env với các giá trị thực tế
```

### 3. Chạy Development Server
```bash
npm run dev
```

## 📝 Environment Variables Required

### Database Configuration
- `DB_HOST` - MySQL hostname (default: localhost)
- `DB_PORT` - MySQL port (default: 3306)
- `DB_NAME` - Database name (thienlongbb)
- `DB_USER` - MySQL username
- `DB_PASSWORD` - MySQL password

### Clerk Authentication
- `CLERK_SECRET_KEY` - Clerk secret key từ dashboard

### File Upload
- `UPLOAD_PATH` - Đường dẫn thư mục upload (./uploads)
- `MAX_FILE_SIZE` - Kích thước file tối đa (5MB = 5242880 bytes)
- `ALLOWED_FILE_TYPES` - Loại file được phép upload

### Security & CORS
- `FRONTEND_URL` - URL của frontend để CORS
- `ALLOWED_ORIGINS` - Danh sách domains được phép

## 📂 Upload Directories

### `/uploads/images/`
- Lưu trữ hình ảnh upload từ admin panel
- Supported formats: JPEG, PNG, GIF, WebP
- Used for: Post banners, sect images, feature images

### `/uploads/documents/`
- Lưu trữ tài liệu upload
- Supported formats: PDF, DOC, DOCX
- Used for: Game guides, documentation

### `/uploads/temp/`
- Lưu trữ files tạm thời
- Auto cleanup after processing
- Used for: Image processing, thumbnails

## 🔧 Key Features

- **Clerk Authentication** - JWT token verification
- **MySQL Integration** - Database operations
- **File Upload** - Image và document upload
- **CORS Support** - Cross-origin requests
- **Rate Limiting** - API protection
- **Input Validation** - Joi schema validation
- **Error Handling** - Centralized error management
- **Logging** - Request và error logging

## 🛡️ Security Features

- **Clerk JWT Verification** - All protected routes
- **Input Validation** - Joi schemas cho all endpoints
- **SQL Injection Prevention** - Parameterized queries
- **File Upload Security** - Type và size validation
- **Rate Limiting** - Protection against abuse
- **CORS Configuration** - Controlled access origins

## 📊 API Endpoints

### Authentication
- `POST /api/auth/sync-user` - Sync Clerk user to MySQL
- `GET /api/auth/me` - Get current user info

### Content Management
- `GET /api/posts` - Get all posts
- `POST /api/posts` - Create new post (admin)
- `PUT /api/posts/:id` - Update post (admin)
- `DELETE /api/posts/:id` - Delete post (admin)

### File Upload
- `POST /api/upload` - Upload files (images/documents)

## 🔍 Logs

Application logs được lưu trong `/logs/` directory:
- `access.log` - HTTP request logs
- `error.log` - Error logs
- `combined.log` - All logs combined

## 🐛 Troubleshooting

### Common Issues:

1. **MySQL Connection Error**
   - Check DB credentials in `.env`
   - Ensure MySQL server is running
   - Verify database `thienlongbb` exists

2. **Clerk Authentication Error**
   - Verify `CLERK_SECRET_KEY` is correct
   - Check Clerk dashboard configuration
   - Ensure frontend domain is added to Clerk

3. **File Upload Error**
   - Check `uploads/` directory permissions
   - Verify `MAX_FILE_SIZE` setting
   - Ensure file type is in `ALLOWED_FILE_TYPES`

## 🚀 Production Deployment

1. Set `NODE_ENV=production`
2. Use production Clerk keys
3. Configure production MySQL database
4. Set proper `ALLOWED_ORIGINS`
5. Use process manager (PM2, Docker)
6. Setup SSL/HTTPS
7. Configure reverse proxy (Nginx) 