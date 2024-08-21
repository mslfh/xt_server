import { BaseAuthProvider, LoginHandlerOptions } from 'adminjs';
import bcrypt from 'bcryptjs';
import { DEFAULT_ADMIN } from './constants.js'; // 假设你在 constants.ts 中定义了管理员账户

class CustomAuthProvider extends BaseAuthProvider {
  // 处理登录逻辑
  async handleLogin(opts: LoginHandlerOptions) {
    const { data } = opts;
    const { email, password } = data;
    const { email: adminEmail, password: adminPassword } = DEFAULT_ADMIN;

    if (email === adminEmail) {
      const isPasswordCorrect = await bcrypt.compare(password, adminPassword);
      if (isPasswordCorrect) {
        return { email: adminEmail, role: 'admin' }; // 登录成功返回用户信息
      }
    }

    return null; // 登录失败返回 null
  }

  // 处理注销逻辑（如果需要）
  async handleLogout(context: any) {
    return Promise.resolve();
  }

  // 处理刷新 token 的逻辑（如果需要）
  async handleRefreshToken(opts: LoginHandlerOptions) {
    const { data } = opts;
    return Promise.resolve({ email: data.email });
  }

  // 如果你需要为前端提供额外的 UI 配置，可以在这里返回
  getUiProps() {
    return {};
  }
}

export default CustomAuthProvider;
