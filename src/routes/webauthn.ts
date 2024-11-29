import { Router } from 'express';
import { registrationOptions, verifyRegistration, authenticationOptions, verifyAuthentication, checkEmailAndPassword, newRegistration } from '../controllers/webauthnController.js';

const router = Router();

router.post('/register/options', registrationOptions);
router.post('/register/verify', verifyRegistration);
router.post('/register/new', newRegistration);

router.post('/login/options', authenticationOptions);
router.post('/login/verify', verifyAuthentication);
router.post('/login/check-password', checkEmailAndPassword);

export default router;
