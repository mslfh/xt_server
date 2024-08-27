import bcrypt from 'bcryptjs';  // 使用 import 替代 require

// 明文密码
const password = 'password';  // 这里替换为你想要加密的密码

// 生成 bcrypt 哈希密码，saltRounds 决定加密强度，一般 10 是一个常用值
const saltRounds = 10;
const hashedPassword = bcrypt.hashSync(password, saltRounds);

// 输出加密后的密码
console.log('Hashed Password:', hashedPassword);
