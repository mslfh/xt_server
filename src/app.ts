import express from 'express';
import AdminJS from 'adminjs';
import { buildAuthenticatedRouter } from '@adminjs/express';
import provider from './admin/auth-provider.js'; 
import options from './admin/options.js';  
import initializeDb from './db/index.js'; 
import jwt from 'jsonwebtoken';
import * as dotenv from 'dotenv';

dotenv.config();

const port = process.env.PORT || 5000;

const start = async () => {
  const app = express();

  try {
    await initializeDb();
    console.log('Database initialized.');

    const admin = new AdminJS(options);

    const adminEnvironment = process.env.NODE_ENV === 'production' ? 'initialize' : 'watch';
    admin[adminEnvironment]();

    const router = buildAuthenticatedRouter(
      admin,
      {
        cookieName: 'adminjs',
        cookiePassword: process.env.COOKIE_SECRET,
        provider, 
      },
      null,
      {
        secret: process.env.COOKIE_SECRET,
        saveUninitialized: true,
        resave: true,
      }
    );


    app.use(admin.options.rootPath, router);

  
    app.use(express.json());


    app.post('/login', async (req, res) => {
      try {
        const { email, password } = req.body;
        const user = await provider.authenticate({ email, password });
        if (!user) {
          return res.status(401).json({ error: 'Invalid credentials' });
        }

        const token = jwt.sign(
          { email: user.email, role: user.role },
          process.env.JWT_SECRET,
          { expiresIn: process.env.JWT_EXPIRATION || '1h' } 
        );
        return res.json({ token });
      } catch (error) {
        return res.status(500).json({ error: 'Something went wrong during login' });
      }
    });

   
    const verifyToken = (req: any, res: express.Response, next: express.NextFunction) => {
      const token = req.headers['authorization']?.split(' ')[1];
      if (!token) {
        return res.status(403).json({ error: 'No token provided' });
      }

      jwt.verify(token, process.env.JWT_SECRET!, (err, decoded) => {
        if (err) {
          return res.status(401).json({ error: 'Failed to authenticate token' });
        }
        req.user = decoded as { email: string; role: string }; 
        next();
      });
    };

   
    app.get('/protected', verifyToken, (req: any, res) => {
      res.json({ message: 'This is a protected route', user: req.user });
    });

 
    app.listen(port, () => {
      console.log(`AdminJS available at http://localhost:${port}${admin.options.rootPath}`);
    });

  } catch (error) {
    console.error('Failed to start the application:', error);
  }
};

start();
