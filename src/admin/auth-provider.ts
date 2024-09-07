import { BaseAuthProvider, LoginHandlerOptions } from 'adminjs';
import bcrypt from 'bcryptjs';
import { DEFAULT_ADMIN } from './constants.js';
import User from '../db/models/user.js';  

class CustomAuthProvider extends BaseAuthProvider {

  // Handle login logic
  async handleLogin(opts: LoginHandlerOptions) {
    const { data } = opts;
    const { email, password } = data;
    const { email: adminEmail, password: adminPassword } = DEFAULT_ADMIN;

    console.log(`Attempting login for email: ${email}`);
    console.log(`Plain password provided: ${password}`);

    // If the user is an Admin
    if (email === adminEmail) {
      console.log('Admin login attempt detected');
      // Verify Admin password
      const isPasswordCorrect = await bcrypt.compare(password, adminPassword);
      if (isPasswordCorrect) {
        console.log('Admin password correct');
        // Return admin details and role
        return { email: adminEmail, role: 'admin' };
      } else {
        console.log('Admin password incorrect');
        // If password is incorrect, return null
        return null;
      }
    }

    // If not Admin, check the database for the user
    try {
      console.log('Non-admin login attempt, checking database...');
      // Find user by email
      const user = await User.findOne({ where: { Email: email } });
      if (!user) {
        console.log(`No user found with email: ${email}`);
        return null;  // Return null if user does not exist
      }

      console.log(`User found: ${user.Email}, AdminFlag: ${user.AdminFlag}`);
      console.log(`Stored hashed password: ${user.Password}`);

      // Check if the user is an admin (AdminFlag)
      if (user.AdminFlag) {
        console.log('User is an admin, verifying password with bcrypt...');
        // If user is an admin, verify the password using bcrypt
        const isPasswordCorrect = await bcrypt.compare(password, user.Password);
        if (!isPasswordCorrect) {
          console.log('Admin password in database is incorrect');
          return null;  // Return null if the password is incorrect
        }
        console.log('Admin password correct, login successful');
        return { email: user.Email, role: 'admin' };  // Admin login successful
      } else {
        console.log('User is not an admin, verifying password with bcrypt...');
        // For regular users, verify the password using bcrypt
        const isPasswordCorrect = await bcrypt.compare(password, user.Password);
        console.log(`Password match result: ${isPasswordCorrect}`);
        if (!isPasswordCorrect) {
          console.log('User password incorrect');
          return null;  // Return null if password is incorrect
        }
        console.log('User password correct, login successful');
        return { email: user.Email, role: 'user' };  // Regular user login successful
      }

    } catch (error) {
      // Catch and log any errors
      console.error('Error during login:', error);
      return null;
    }
  }

  // Handle logout logic
  async handleLogout(context: any) {
    return Promise.resolve();
  }

  // Handle refresh token logic
  async handleRefreshToken(opts: LoginHandlerOptions) {
    const { data } = opts;
    return Promise.resolve({ email: data.email });
  }

  // Configure UI properties (customize as needed)
  getUiProps() {
    return {};
  }
}

export default CustomAuthProvider;
