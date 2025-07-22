const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const rateLimit = require('express-rate-limit');
const path = require('path');
const fs = require('fs');
const { ClerkExpressRequireAuth } = require('@clerk/clerk-sdk-node');
const { checkDbConnection } = require('./config/database');

require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// ===================================================================
// MIDDLEWARE SETUP
// ===================================================================

// Security headers
app.use(helmet());

// CORS configuration
app.use(cors({
  origin: process.env.ALLOWED_ORIGINS?.split(',') || ['http://localhost:5173'],
  credentials: true
}));

// Request logging
app.use(morgan('combined'));

// Rate limiting
const limiter = rateLimit({
  windowMs: parseInt(process.env.RATE_LIMIT_WINDOW_MS) || 15 * 60 * 1000, // 15 minutes
  max: parseInt(process.env.RATE_LIMIT_MAX_REQUESTS) || 100, // limit each IP to 100 requests per windowMs
  message: {
    error: 'Too many requests from this IP, please try again later.'
  }
});
app.use('/api/', limiter);

// Body parsing middleware
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Static files (uploaded images)
app.use('/uploads', express.static('uploads'));
app.use(express.static(path.join(__dirname, '..', 'public')));

// Check database connection
checkDbConnection();

// Clerk authentication middleware (example for protected routes)
// app.use('/api/protected', ClerkExpressRequireAuth());

// ===================================================================
// ROUTES
// ===================================================================

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({
    status: 'OK',
    message: 'Thiên Long Bát Bộ Backend API is running',
    timestamp: new Date().toISOString(),
    version: '1.0.0'
  });
});

// API routes will be added here
// app.use('/api/auth', require('./routes/auth'));
// app.use('/api/posts', require('./routes/posts'));
// app.use('/api/sects', require('./routes/sects'));
// app.use('/api/features', require('./routes/features'));
// app.use('/api/site-settings', require('./routes/siteSettings'));
// app.use('/api/upload', require('./routes/upload'));

// Root endpoint
app.get('/', (req, res) => {
  res.json({
    message: 'Thiên Long Bát Bộ Backend API',
    version: '1.0.0',
    documentation: '/api/docs',
    health: '/health'
  });
});

// ===================================================================
// ERROR HANDLING
// ===================================================================

// 404 handler
app.use('*', (req, res) => {
  res.status(404).json({
    error: 'Not Found',
    message: `Cannot ${req.method} ${req.originalUrl}`
  });
});

// Global error handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  
  res.status(err.status || 500).json({
    error: process.env.NODE_ENV === 'production' ? 'Internal Server Error' : err.message,
    ...(process.env.NODE_ENV !== 'production' && { stack: err.stack })
  });
});

// ===================================================================
// SERVER START
// ===================================================================

app.listen(PORT, () => {
  console.log(`🚀 Thiên Long Bát Bộ Backend API running on port ${PORT}`);
  console.log(`📱 Environment: ${process.env.NODE_ENV || 'development'}`);
  console.log(`🌐 Health check: http://localhost:${PORT}/health`);
  console.log(`📊 API base URL: http://localhost:${PORT}/api`);
});

module.exports = app; 