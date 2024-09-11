import { BaseAuthProvider, LoginHandlerOptions } from 'adminjs';
import bcrypt from 'bcryptjs';
import { DEFAULT_ADMIN } from './constants.js';
import User from '../db/models/user.js';  

class CustomAuthProvider extends BaseAuthProvider {

  // Handle login logic
  async handleLogin(opts: LoginHandlerOptions) {
    const { data } = opts;
    const { email, password, microsoftEmail, oid, sub } = data;  // Added microsoftEmail, oid, sub
    const { email: adminEmail, password: adminPassword } = DEFAULT_ADMIN;

    console.log(`Attempting login for email: ${email}`);
    console.log(`Plain password provided: ${password}`);

    // Admin Login Logic
    if (email === adminEmail) {
      console.log('Admin login attempt detected');
      const isPasswordCorrect = await bcrypt.compare(password, adminPassword);
      if (isPasswordCorrect) {
        console.log('Admin password correct');
        return { email: adminEmail, role: 'admin' };
      } else {
        console.log('Admin password incorrect');
        return null;
      }
    }

    // Microsoft Account Login Logic
    if (microsoftEmail && oid && sub) {
      try {
        console.log('Microsoft login attempt, checking database...');
        const user = await User.findOne({ where: { microsoftEmail, oid, sub } });
        if (!user || !user.isLinked) {
          console.log('No linked Microsoft account found');
          return null;  // Return null if no matching Microsoft account
        }
        console.log(`Microsoft User found: ${user.microsoftEmail}, login successful`);
        return { email: user.microsoftEmail, role: 'user' };  // Microsoft login successful
      } catch (error) {
        console.error('Error during Microsoft login:', error);
        return null;
      }
    }

    // Non-admin login logic for regular email/password users
    try {
      console.log('Non-admin login attempt, checking database...');
      const user = await User.findOne({ where: { Email: email } });
      if (!user) {
        console.log(`No user found with email: ${email}`);
        return null;
      }

      console.log(`User found: ${user.Email}, AdminFlag: ${user.AdminFlag}`);
      const isPasswordCorrect = await bcrypt.compare(password, user.Password);
      if (!isPasswordCorrect) {
        console.log('User password incorrect');
        return null;
      }

      const role = user.AdminFlag ? 'admin' : 'user';
      console.log(`User password correct, login successful as ${role}`);
      return { email: user.Email, role };  // Regular login successful

    } catch (error) {
      console.error('Error during login:', error);
      return null;
    }
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
