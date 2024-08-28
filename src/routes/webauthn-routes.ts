import { Router } from 'express';
import { registrationOptions, verifyRegistration, authenticationOptions, verifyAuthentication } from '../controllers/webauthn-controller.js';

const router = Router();

router.post('/register/options', registrationOptions);
router.post('/register/verify', verifyRegistration);
router.post('/login/options', authenticationOptions);
router.post('/login/verify', verifyAuthentication);

export default router;
