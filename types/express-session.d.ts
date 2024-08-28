import session from 'express-session';

declare module 'express-session' {
    interface SessionData {
        challenge?: string; // Define other session properties if needed
    }
}

declare module 'express-serve-static-core' {
    interface Request {
        session: session.Session & Partial<session.SessionData>;
    }
}
