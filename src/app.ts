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
import https from 'https';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

dotenv.config();

// Extend express-session types to add user data to session
declare module 'express-session' {
  interface SessionData {
    user: any;
  }
}

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
    origin: ['https://www.exertime.me', 'https://localhost:8443', process.env.FRONTEND_ORIGIN],
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization'],
    credentials: true,
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
        cookie: {
          secure: true,  // Set this to `true` when using HTTPS
          httpOnly: true,  // Prevent client-side JS from accessing the cookie
          maxAge: 1000 * 60 * 60 * 24,  // Set cookie expiration to 1 day
        },
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
          secure: true,  // HTTPS is required to set secure cookies
          httpOnly: true,
          maxAge: 1000 * 60 * 60 * 24,
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
      next();
    });

    app.use(express.json()); // For parsing application/json

    app.use('/admin/api/webauthn', webauthnRoutes); // Use the WebAuthn routes

    /*
    app.post('/admin/login', async (req, res) => {
      try {
        const loginResult = await provider.handleLogin({ data: req.body, headers: req.headers });
    
        if (loginResult) {
          // If login is successful, set a session and cookie
          req.session.user = loginResult;
          return res.status(200).json({
            success: true,
            message: 'Login successful',
            user: loginResult,
          });
        } else {
          // If login fails, send a JSON error response
          return res.status(401).json({
            success: false,
            message: 'Invalid login credentials',
          });
        }
      } catch (error) {
        console.error('Error during login:', error);
        return res.status(500).json({
          success: false,
          message: 'Internal server error',
        });
      }
    });
    */

    // Use AdminJS router
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
