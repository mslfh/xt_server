import bcrypt from 'bcryptjs';

// 明文密码
const password = 'password';

const saltRounds = 10;
const hashedPassword = bcrypt.hashSync(password, saltRounds);

// 输出加密后的密码
console.log('Hashed Password:', hashedPassword);
