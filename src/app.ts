import express from 'express';
import AdminJS from 'adminjs';
import { buildAuthenticatedRouter } from '@adminjs/express';
import CustomAuthProvider from './admin/auth-provider.js'; 
import options from './admin/options.js';
import initializeDb from './db/index.js';
import * as dotenv from 'dotenv';

dotenv.config();

const port = process.env.PORT || 5000;

const start = async () => {
  const app = express();

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
        saveUninitialized: false
      }
    );

    app.use(admin.options.rootPath, router);


    app.listen(port, () => {
      console.log(`AdminJS available at http://localhost:${port}${admin.options.rootPath}`);
    });

  } catch (error) {
    console.error('Failed to start the application:', error);
  }
};

start();
