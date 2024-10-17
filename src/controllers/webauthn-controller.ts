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
import { v4 as uuidv4 } from 'uuid';
import bcrypt from 'bcrypt';

const rpName = process.env.RP_NAME!;
const rpID = process.env.RP_ID!;
const origin = process.env.FRONTEND_ORIGIN!;
const timeout = parseInt(process.env.TIMEOUT_MS!, 10);

// Define the base64ToBase64URL function to convert Base64 to Base64URL format
function base64ToBase64URL(base64: string): string {
    return base64.replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
}

function hexToUint8Array(hex: string): Uint8Array {
    if (hex.length % 2 !== 0) {
        throw new Error('Hex string must have an even number of characters');
    }

    const array = new Uint8Array(hex.length / 2);
    for (let i = 0; i < hex.length; i += 2) {
        array[i / 2] = parseInt(hex.substr(i, 2), 16);
    }
    return array;
}

// Registration Options API
export const registrationOptions = async (req: Request, res: Response) => {
    console.log('Registration Options Route Hit');
    console.log('rpID: ', rpID);
    const { username } = req.body;

    if (!username) {
        return res.status(400).json({ error: 'Username is required.' });
    }

    const user = await User.findOne({ where: { Username: username } });
    if (!user) {
        return res.status(404).json({ error: 'User not found.' });
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
        return res.status(400).json({ error: 'Username and attestationResponse are required.' });
    }

    const user = await User.findOne({ where: { Username: username } });
    if (!user) {
        return res.status(404).json({ error: 'User not found.' });
    }

    try {
        const storedChallenge = req.session.challenge;

        if (!storedChallenge) {
            return res.status(400).json({ error: 'Challenge not found in session.' });
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
            const credentialPublicKeyBuffer = Buffer.from(credentialPublicKey);
            console.log('Credential Public Key:', credentialPublicKey);
            console.log('Credential Public Key Buffer:', credentialPublicKeyBuffer);

            await Credentials.create({
                ID: credentialID,
                UserID: user.ID,
                PublicKey: credentialPublicKeyBuffer,
                WebAuthnUserID: credentialID,
                Counter: counter,
            });

            // Update the Passkey field in the User table
            user.Passkey = credentialID;
            await user.save();

            req.session.challenge = null; // Clear the challenge from the session

            return res.status(200).json({ status: 'ok', message: 'Registration with passkey successful!' });
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
    const { email } = req.body;

    if (!email) {
        return res.status(400).json({ error: 'Email is required.' });
    }

    const user = await User.findOne({ where: { Email: email } });
    if (!user) {
        return res.status(404).json({ error: 'User not found.' });
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
    console.log('Verify Authentication Route Hit');
    console.log(req.body);
    const { email, authenticationResponse } = req.body;

    if (!email || !authenticationResponse) {
        return res.status(400).json({ error: 'Email and authenticationResponse are required.' });
    }

    const user = await User.findOne({ where: { Email: email } });
    if (!user) {
        return res.status(404).json({ error: 'User not found.' });
    }

    try {
        const credential = await Credentials.findOne({
            where: { UserID: user.ID, ID: authenticationResponse.rawId },
        });

        if (!credential) {
            return res.status(404).json({ error: 'Credential not found.' });
        }

        const storedChallenge = req.session.challenge;

        if (!storedChallenge) {
            return res.status(400).json({ error: 'Challenge not found in session.' });
        }

        console.log('Credential Public Key from database:', credential.PublicKey);

        const credentialPublicKey = new Uint8Array(credential.PublicKey);

        // Log the credential public key to debug the issue
        console.log('Credential Public Key:', credentialPublicKey);

        const verification = await verifyAuthenticationResponse({
            response: authenticationResponse,
            expectedChallenge: storedChallenge,
            expectedOrigin: origin,
            expectedRPID: rpID,
            authenticator: {
                credentialPublicKey: credentialPublicKey,
                counter: credential.Counter,
                credentialID: credential.ID,
            },
        });

        if (verification.verified) {
            credential.Counter = verification.authenticationInfo.newCounter;
            await credential.save();

            req.session.challenge = null; // Clear the challenge from the session

            // Store user information in the session
            req.session.user = {
                id: user.ID,
                username: user.Username,
            };
            // Save the session and return a response with userID and username
            req.session.save((err) => {
                if (err) {
                    console.error('Error saving session:', err);
                    return res.status(500).json({ error: 'Failed to save session.' });
                }

                // Session is saved, return success response
                return res.status(200).json({
                    message: 'Verification with passkey successful!',
                    userID: user.ID,       // Returning userID
                    username: user.Username, // Returning username
                });
            });

        } else {
            return res.status(400).json({ status: 'failed' });
        }
    } catch (error) {
        console.error(error);
        return res.status(500).send('Verification failed');
    }
};

export const checkEmailAndPassword = async (req: Request, res: Response) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ error: 'Email and password are required.' });
    }

    try {
        // Find user by email
        const user = await User.findOne({ where: { Email: email } });
        if (!user) {
            return res.status(404).json({ error: 'User not found.' });
        }

        // Validate the password
        const isPasswordValid = await bcrypt.compare(password, user.Password);
        if (!isPasswordValid) {
            return res.status(401).json({ error: 'Invalid email or password.' });
        }

        // Store user information in the session
        req.session.user = {
            id: user.ID,
            username: user.Username,
        };

        // Save the session and return a response with userID and username
        req.session.save((err) => {
            if (err) {
                console.error('Error saving session:', err);
                return res.status(500).json({ error: 'Failed to save session.' });
            }

            // Session is saved, return success response
            return res.status(200).json({
                message: 'Email and password are correct.',
                userID: user.ID,       // Returning userID
                username: user.Username, // Returning username
                departmentID: user.DepartmentID,
            });
        });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Internal server error' });
    }
};

// New Registration API
export const newRegistration = async (req: Request, res: Response) => {
    console.log('New Registration Route Hit');

    const { username, email, password } = req.body;

    // Check for required fields in the request body
    if (!username || !email || !password) {
        return res.status(400).json({ status: 'error', message: 'Username, email, and password are required.' });
    }

    try {
        // Check if the username already exists
        const existingUserByUsername = await User.findOne({ where: { Username: username } });
        if (existingUserByUsername) {
            return res.status(400).json({ status: 'error', message: 'Registration failed. Username already exists.' });
        }

        // Check if the email already exists
        const existingUserByEmail = await User.findOne({ where: { Email: email } });
        if (existingUserByEmail) {
            return res.status(400).json({ status: 'error', message: 'Registration failed. Email already exists.' });
        }

        const userId = uuidv4();

        // Create a new user
        await User.create({
            ID: userId,
            Username: username,
            Email: email,
            Password: password,
        });

        return res.status(200).json({ status: 'ok', message: 'Registration successful!' });
    } catch (error) {
        console.error('Error during registration:', error);
        return res.status(500).json({ status: 'error', message: 'Internal server error' });
    }
};