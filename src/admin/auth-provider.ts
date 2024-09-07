import { BaseAuthProvider, LoginHandlerOptions } from 'adminjs';
import bcrypt from 'bcryptjs';
import { DEFAULT_ADMIN } from './constants.js';
import User from '../db/models/user.js';  // 引入用户模型

class CustomAuthProvider extends BaseAuthProvider {

  // 处理登录逻辑
  async handleLogin(opts: LoginHandlerOptions) {
    const { data } = opts;
    const { email, password } = data;
    const { email: adminEmail, password: adminPassword } = DEFAULT_ADMIN;

    console.log(`Attempting login for email: ${email}`);
    console.log(`Plain password provided: ${password}`);

    // 如果是 Admin 用户
    if (email === adminEmail) {
      console.log('Admin login attempt detected');
      // 验证 Admin 密码
      const isPasswordCorrect = await bcrypt.compare(password, adminPassword);
      if (isPasswordCorrect) {
        console.log('Admin password correct');
        // 返回管理员信息和角色
        return { email: adminEmail, role: 'admin' };
      } else {
        console.log('Admin password incorrect');
        // 密码错误，返回 null
        return null;
      }
    }

    // 如果不是 Admin，检查数据库中是否存在该用户
    try {
      console.log('Non-admin login attempt, checking database...');
      // 通过 email 查找用户
      const user = await User.findOne({ where: { Email: email } });
      if (!user) {
        console.log(`No user found with email: ${email}`);
        return null;  // 如果用户不存在，返回 null
      }

      console.log(`User found: ${user.Email}, AdminFlag: ${user.AdminFlag}`);
      console.log(`Stored hashed password: ${user.Password}`);

      // 检查用户是否为管理员 (AdminFlag)
      if (user.AdminFlag) {
        console.log('User is an admin, verifying password with bcrypt...');
        // 如果用户是管理员，使用 bcrypt 验证密码
        const isPasswordCorrect = await bcrypt.compare(password, user.Password);
        if (!isPasswordCorrect) {
          console.log('Admin password in database is incorrect');
          return null;  // 如果密码错误，返回 null
        }
        console.log('Admin password correct, login successful');
        return { email: user.Email, role: 'admin' };  // 管理员登录成功
      } else {
        console.log('User is not an admin, verifying password with bcrypt...');
        // 普通用户登录，使用 bcrypt 验证密码
        const isPasswordCorrect = await bcrypt.compare(password, user.Password);
        console.log(`Password match result: ${isPasswordCorrect}`);
        if (!isPasswordCorrect) {
          console.log('User password incorrect');
          return null;  // 密码错误，返回 null
        }
        console.log('User password correct, login successful');
        return { email: user.Email, role: 'user' };  // 普通用户登录成功
      }

    } catch (error) {
      // 捕获并记录错误
      console.error('Error during login:', error);
      return null;
    }
  }

  // 处理注销逻辑
  async handleLogout(context: any) {
    return Promise.resolve();
  }

  // 处理刷新 token 的逻辑
  async handleRefreshToken(opts: LoginHandlerOptions) {
    const { data } = opts;
    return Promise.resolve({ email: data.email });
  }

  // 配置 UI 属性（根据需要自定义）
  getUiProps() {
    return {};
  }
}

export default CustomAuthProvider;
