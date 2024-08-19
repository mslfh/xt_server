import { DefaultAuthProvider } from 'adminjs';
import bcrypt from 'bcryptjs';
import componentLoader from './component-loader.js';  
import { DEFAULT_ADMIN } from './constants.js';  


class CustomAuthProvider extends DefaultAuthProvider {
  authenticate = async ({ email, password }) => {
    if (email === DEFAULT_ADMIN.email) {
      const hashedAdminPassword = bcrypt.hashSync(DEFAULT_ADMIN.password, 10);
      const isPasswordCorrect = await bcrypt.compare(password, hashedAdminPassword);
      if (isPasswordCorrect) {
        return { email: DEFAULT_ADMIN.email, role: 'admin' };
      }
    }
    return null;
  }
}


const provider = new CustomAuthProvider({
  componentLoader,  
  authenticate: async ({ email, password }) => {
    if (email === DEFAULT_ADMIN.email) {
      const hashedAdminPassword = bcrypt.hashSync(DEFAULT_ADMIN.password, 10);
      const isPasswordCorrect = await bcrypt.compare(password, hashedAdminPassword);
      if (isPasswordCorrect) {
        return { email: DEFAULT_ADMIN.email, role: 'admin' };
      }
    }
    return null;
  },
});

export default provider;
