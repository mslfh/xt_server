import { Request, Response } from 'express';
import {
    generateRegistrationOptions,
    verifyRegistrationResponse,
    generateAuthenticationOptions,
    verifyAuthenticationResponse,
} from '@simplewebauthn/server';
import {
    PublicKeyCredentialCreationOptionsJSON,
    PublicKeyCredentialRequestOptionsJSON,
} from '@simplewebauthn/types';
import Credentials from '../db/models/credentials.js';
import User from '../db/models/user.js';

const rpName = process.env.RP_NAME!;
const rpID = process.env.RP_ID!;
const origin = process.env.ORIGIN!;
const timeout = parseInt(process.env.TIMEOUT_MS!, 10);

// Define the base64ToBase64URL function to convert Base64 to Base64URL format
function base64ToBase64URL(base64: string): string {
    return base64.replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
}

// Registration Options API
export const registrationOptions = async (req: Request, res: Response) => {
    console.log('Registration Options Route Hit');
    const { username } = req.body;

    if (!username) {
        return res.status(400).json({ error: 'Username is required' });
    }

    const user = await User.findOne({ where: { Username: username } });
    if (!user) {
        return res.status(404).json({ error: 'User not found' });
    }

    const userID = new TextEncoder().encode(user.ID);
    const displayName = `${user.GivenNames} ${user.Surname}`;

    const options: PublicKeyCredentialCreationOptionsJSON = await generateRegistrationOptions({
        rpName,
        rpID,
        userID,
        userName: user.Username,
        timeout,
        attestationType: 'indirect',
        authenticatorSelection: {
            userVerification: 'preferred',
        },
    });

    // Store the challenge in the session
    req.session.challenge = options.challenge;

    return res.json({
        ...options,
        user: {
            id: user.ID,
            userName: user.Username,
            displayName,
        },
    });
};

// Verify Registration API
export const verifyRegistration = async (req: Request, res: Response) => {
    const { username, attestationResponse } = req.body;

    // Check for required fields in the request body
    if (!username || !attestationResponse) {
        return res.status(400).json({ error: 'Username and attestationResponse are required' });
    }

    const user = await User.findOne({ where: { Username: username } });
    if (!user) {
        return res.status(404).json({ error: 'User not found' });
    }

    try {
        const storedChallenge = req.session.challenge;

        if (!storedChallenge) {
            return res.status(400).json({ error: 'Challenge not found in session' });
        }

        // Convert id and rawId to Base64URL format
        attestationResponse.id = base64ToBase64URL(attestationResponse.id);
        attestationResponse.rawId = base64ToBase64URL(attestationResponse.rawId);

        const verification = await verifyRegistrationResponse({
            response: attestationResponse,
            expectedChallenge: storedChallenge,
            expectedOrigin: origin,
            expectedRPID: rpID,
        });

        if (verification.verified) {
            const { credentialPublicKey, credentialID, counter } = verification.registrationInfo!;

            await Credentials.create({
                ID: credentialID,
                UserID: user.ID,
                PublicKey: credentialPublicKey,
                WebAuthnUserID: credentialID,
                Counter: counter,
            });

            req.session.challenge = null; // Clear the challenge from the session

            return res.json({ status: 'ok' });
        } else {
            return res.status(400).json({ status: 'failed' });
        }
    } catch (error) {
        console.error(error);
        return res.status(500).send('Verification failed');
    }
};

// Authentication Options API
export const authenticationOptions = async (req: Request, res: Response) => {
    const { username } = req.body;

    if (!username) {
        return res.status(400).json({ error: 'Username is required' });
    }

    const user = await User.findOne({ where: { Username: username } });
    if (!user) {
        return res.status(404).json({ error: 'User not found' });
    }

    const credentials = await Credentials.findAll({ where: { UserID: user.ID } });

    const options: PublicKeyCredentialRequestOptionsJSON = await generateAuthenticationOptions({
        timeout,
        allowCredentials: credentials.map(cred => ({
            id: cred.ID, // Convert to Base64URLString
            type: 'public-key',
        })),
        userVerification: 'preferred',
        rpID,
    });

    // Store the challenge in the session for verification
    req.session.challenge = options.challenge;

    return res.json(options);
};

// Verify Authentication API
export const verifyAuthentication = async (req: Request, res: Response) => {
    const { username, authenticationResponse } = req.body;

    if (!username || !authenticationResponse) {
        return res.status(400).json({ error: 'Username and authenticationResponse are required' });
    }

    const user = await User.findOne({ where: { Username: username } });
    if (!user) {
        return res.status(404).json({ error: 'User not found' });
    }

    try {
        const credential = await Credentials.findOne({
            where: { UserID: user.ID, ID: authenticationResponse.rawId },
        });

        if (!credential) {
            return res.status(404).json({ error: 'Credential not found' });
        }

        const storedChallenge = req.session.challenge;

        if (!storedChallenge) {
            return res.status(400).json({ error: 'Challenge not found in session' });
        }

        const verification = await verifyAuthenticationResponse({
            response: authenticationResponse,
            expectedChallenge: storedChallenge,
            expectedOrigin: origin,
            expectedRPID: rpID,
            authenticator: {
                credentialPublicKey: credential.PublicKey,
                counter: credential.Counter,
                credentialID: credential.ID, // Ensure this is present
            },
        });

        if (verification.verified) {
            credential.Counter = verification.authenticationInfo.newCounter;
            await credential.save();

            req.session.challenge = null; // Clear the challenge from the session

            return res.json({ status: 'ok', username: user.Username });
        } else {
            return res.status(400).json({ status: 'failed' });
        }
    } catch (error) {
        console.error(error);
        return res.status(500).send('Verification failed');
    }
};
