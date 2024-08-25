import { BaseAuthProvider, LoginHandlerOptions } from 'adminjs';
import bcrypt from 'bcryptjs';
import { DEFAULT_ADMIN } from './constants.js'; 

class CustomAuthProvider extends BaseAuthProvider {

  async handleLogin(opts: LoginHandlerOptions) {
    const { data } = opts;
    const { email, password } = data;
    const { email: adminEmail, password: adminPassword } = DEFAULT_ADMIN;

    if (email === adminEmail) {
      const isPasswordCorrect = await bcrypt.compare(password, adminPassword);
      if (isPasswordCorrect) {
        return { email: adminEmail, role: 'admin' };
      }
    }

    return null;
  }

 
  async handleLogout(context: any) {
    return Promise.resolve();
  }


  async handleRefreshToken(opts: LoginHandlerOptions) {
    const { data } = opts;
    return Promise.resolve({ email: data.email });
  }


  getUiProps() {
    return {};
  }
}

export default CustomAuthProvider;
