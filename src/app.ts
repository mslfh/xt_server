import express from 'express';
import AdminJS from 'adminjs';
import cors from 'cors';
import { buildAuthenticatedRouter } from '@adminjs/express';
import CustomAuthProvider from './admin/auth-provider.js';
import options from './admin/options.js';
import initializeDb from './db/index.js';
import * as dotenv from 'dotenv';
import webauthnRoutes from './routes/webauthn-routes.js';
import session from 'express-session';
import sequelize from './db/config.js';
import SequelizeStore from 'connect-session-sequelize';
import http from 'http';
import https from 'https';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

// Extend express-session types
declare module 'express-session' {
  interface SessionData {
    user?: any; // 修改为合适的用户类型
  }
}

dotenv.config();

const port = process.env.PORT || 5000;

// Define the session store using connect-session-sequelize
const SequelizeSessionStore = SequelizeStore(session.Store);
const sessionStore = new SequelizeSessionStore({
  db: sequelize,
});

// Sync the session store to ensure the session table is created/updated
sessionStore.sync();

// Get the directory name in ES module scope
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Load SSL/TLS certificates
const sslOptions = {
  key: fs.readFileSync(path.resolve(__dirname, '../localhost-key.pem')),
  cert: fs.readFileSync(path.resolve(__dirname, '../localhost.pem')),
};

const start = async () => {
  const app = express();

  // Allow cross-source requests
  app.use(cors({
    origin: ['https://www.exertime.me', 'https://localhost:8443'],
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization'],
    credentials: true,
  }));

  app.use(express.json()); // For parsing application/json

  try {
    await initializeDb();
    console.log('Database initialized.');

    const admin = new AdminJS(options);
    const provider = new CustomAuthProvider();

    const router = buildAuthenticatedRouter(
      admin,
      {
        cookieName: 'adminjs',
        cookiePassword: process.env.COOKIE_SECRET || 'supersecret-password',
        provider,
      },
      null,
      {
        secret: process.env.COOKIE_SECRET || 'supersecret-session',
        resave: false,
        saveUninitialized: false,
      }
    );

    // Configure session middleware
    app.use(
      session({
        secret: process.env.SESSION_SECRET || 'your_secret_key',
        store: sessionStore,
        resave: false,
        saveUninitialized: false,
        cookie: { 
          secure: process.env.NODE_ENV === 'production', // Set to true in production
          httpOnly: true,  // Set to true to prevent client-side access to cookie
          maxAge: 1000 * 60 * 60 * 24, // Cookie expiration
        },
      })
    );

    // Adding a middleware to log all requests
    app.use((req, res, next) => {
      console.log(`Received request: ${req.method} ${req.url}`);
      next();
    });

    // Middleware to check content type and authentication cookie
    app.use('/admin/api/webauthn', (req, res, next) => {
      if (req.method === 'POST' && req.headers['content-type'] !== 'application/json') {
        console.error(`Invalid content type: ${req.headers['content-type']} for ${req.url}`);
        return res.status(415).json({ error: 'Unsupported Media Type' });
      }

      // Check for authentication cookie
      const cookie = req.headers.cookie;
      console.log(`Cookie: ${cookie}`);
      if (!cookie || !cookie.includes('connect.sid=')) {
        console.error(`Missing or invalid authentication cookie in request: ${req.method} ${req.url}`);
        return res.status(403).json({ error: 'Authentication required' });
      }

      next();
    });

    app.use('/admin/api/webauthn', webauthnRoutes); // Use the WebAuthn routes
    app.use(admin.options.rootPath, router);

    // Start the HTTPS server
    https.createServer(sslOptions, app).listen(port, () => {
      console.log(`AdminJS available at https://localhost:${port}${admin.options.rootPath}`);
    });

  } catch (error) {
    console.error('Failed to start the application.', error);
  }
};

start();
