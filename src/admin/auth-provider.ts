import { BaseAuthProvider, LoginHandlerOptions } from 'adminjs';
import bcrypt from 'bcryptjs';
import { DEFAULT_ADMIN } from './constants.js';
import User from '../db/models/user.js';  // Import the User model

class CustomAuthProvider extends BaseAuthProvider {

  // Handle the login logic
  async handleLogin(opts: LoginHandlerOptions) {
    const { data } = opts;
    const { email, password } = data;
    const { email: adminEmail, password: adminPassword } = DEFAULT_ADMIN;

    // Check if the login attempt is for the default admin account
    if (email === adminEmail) {
      // Verify admin password using bcrypt
      const isPasswordCorrect = await bcrypt.compare(password, adminPassword);
      if (isPasswordCorrect) {
        // If password is correct, return admin details with the 'admin' role
        return { email: adminEmail, role: 'admin' };
      }
      // Return null if the admin password is incorrect
      return null;
    }

    // If not admin, check for a regular user in the database
    try {
      // Find the user in the database by email
      const user = await User.findOne({ where: { Email: email } });
      if (!user) {
        return null;  // Return null if the user does not exist
      }

      // Check if the user is an admin (AdminFlag is set)
      if (user.AdminFlag) {
        // If the user is an admin, verify the password using bcrypt
        const isPasswordCorrect = await bcrypt.compare(password, user.Password);
        if (!isPasswordCorrect) {
          return null;  // Return null if the password is incorrect
        }
        return { email: user.Email, role: 'admin' };  // Admin login successful
      } else {
        // If the user is not an admin, compare the password as plain text
        if (password !== user.Password) {
          return null;  // Return null if the password does not match
        }
        return { email: user.Email, role: 'user' };  // User login successful
      }

    } catch (error) {
      // Log any errors during the login process and return null
      console.error('Error during login:', error);
      return null;
    }
  }

  // Handle logout logic (no action needed here for now)
  async handleLogout(context: any) {
    return Promise.resolve();
  }

  // Handle token refresh logic (for session management)
  async handleRefreshToken(opts: LoginHandlerOptions) {
    const { data } = opts;
    return Promise.resolve({ email: data.email });
  }

  // Configure UI properties (can be customized if needed)
  getUiProps() {
    return {};
  }
}

export default CustomAuthProvider;
