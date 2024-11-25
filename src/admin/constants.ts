import bcrypt from 'bcryptjs';

export const DEFAULT_ADMIN = {
  email: 'admin@example.com',
  password: bcrypt.hashSync('password', 10),
};
