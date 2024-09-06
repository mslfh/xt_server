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

dotenv.config();

const port = process.env.PORT || 5000;

// Define the session store using connect-session-sequelize
const SequelizeSessionStore = SequelizeStore(session.Store);
const sessionStore = new SequelizeSessionStore({
  db: sequelize,
});

// Sync the session store to ensure the session table is created/updated
sessionStore.sync();

const start = async () => {
  const app = express();

  // Allow cross-source requests
  app.use(cors({
    origin: 'https://www.exertime.me',  
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization'],
    credentials: true
  }));
  

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
        cookie: { secure: false }, // Set to true if using HTTPS
      })
    );

    // Adding a middleware to log all requests
    app.use((req, res, next) => {
      console.log(`Received request: ${req.method} ${req.url}`);
      next();
    });

    // Middleware to check content type and authentication cookie
    app.use('/admin/api/webauthn', (req, res, next) => {

      // Check for valid JSON content type
      if (req.method === 'POST' && req.headers['content-type'] !== 'application/json') {
        return res.status(415).json({ error: 'Unsupported Media Type' });
      }

      // Check for authentication cookie
      const cookie = req.headers.cookie;
      if (!cookie || !cookie.includes('connect.sid=')) {
        return res.status(403).json({ error: 'Authentication required' });
      }
      next();
    });

    app.use(express.json()); // For parsing application json

    app.use('/admin/api/webauthn', webauthnRoutes); // Use the WebAuthn routes

    app.use(admin.options.rootPath, router);

    app.listen(port, () => {
      console.log(`AdminJS available at http://localhost:${port}${admin.options.rootPath}`);
    });

  } catch (error) {
    console.error('Failed to start the application.', error);
  }
};

start();
