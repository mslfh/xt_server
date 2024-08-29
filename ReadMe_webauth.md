# API Testing Guide

This guide provides a list of commands to be run on the terminal for setting up and testing the Application programming interface (API). Kindly note that the below commands are suitable to be run on windows powershell.

## SQL Terminal

```sh
# Navigate to the directory
cd <path>

# Access MySQL
mysql -u root -p

# Switch to the adminjs database
use adminjs;

# Create the database if it doesn't exist
create database adminjs;

# Show available databases
show databases;

# Use the adminjs database
use adminjs;

# Import the SQL file
source <path_of_SQL_file>;
```

## VS Code Terminal

```sh
# Navigate to the directory
cd <path>

# Install necessary packages
npm install
npm install @simplewebauthn/server
npm install @simplewebauthn/browser
npm install @simplewebauthn/types
npm install connect-session-sequelize
npm install express-session
npm install @types/express-session --save-dev

# Build the project
npm run build

# Start the project
npm run start
```
## Cookie Value

Steps to find the cookie value in Google Chrome is given below.

1. Login to the adminjs application.
2. Press F12 and navigate to 'Application' tab on top.
3. Find the Cookies option in Storage section of the sidebar.
4. Check for "http://localhost:500" and click on it.
5. Note the cookie name and cookie value(URL encoded) for future use.

Kindly note that cookie value could change for a different login. A session management is implemented to make sure that session doesn't expire prematurely.  

## Registration Options API Testing

The test cases for the **Registration Options** API using a JSON file (UTF-8 encoding) as input, with the corresponding `curl` commands are as follows. 

- **Curl Command**:
```sh
curl.exe -X POST "http://localhost:5000/admin/api/webauthn/register/options" `
-H "Content-Type: application/json" `
--data "@data.json" `
-b "<cookie name>=<cookie value>" `
-w "%{http_code}\n"
```

### Test Case 1: Successful Registration Options Generation
- **Description**: Verify that the API generates the correct registration options for a valid username.
- **Input**: Create a file named `data.json` with the following content:
```json
{
    "username": "alicejohnson"
}
```
- **Expected Output**:
	- Status Code: 200
	- Response Body:
	```json
       {
         "`": "<base64url-encoded-string>",
         "rp": {
           "name": "exertime_application",
           "id": "localhost"
         },
         "user": {
           "id": "3",
           "userName": "alicejohnson",
           "displayName": "Alice Johnson"
         },
         "pubKeyCredParams": [
           {"alg": -8, "type": "public-key"},
           {"alg": -7, "type": "public-key"},
           {"alg": -257, "type": "public-key"}
         ],
         "timeout": 60000,
         "attestation": "indirect",
         "excludeCredentials": [],
         "authenticatorSelection": {
           "userVerification": "preferred"
         },
         "extensions": {
           "credProps": true
         }
       }
	```
- **Outcome**: PASSED

### Test Case 2: Missing Username
- **Description**: Verify that the API returns an error when the username is missing.
- **Input**: Modify `data.json` to have the following content:
 ```json
{
    "username": ""
}
```
- **Expected Output**:
  - Status Code: 400
  - Response Body:
    ```json
    {
      "error": "Username is required"
    }
    ```
- **Outcome**: PASSED

### Test Case 3: User Not Found
- **Description**: Verify that the API returns an error when the username does not exist in the database.
- **Input**: Modify `data.json` to have the following content:
 ```json
{
    "username": "nonexistentuser"
}
```
- **Expected Output**:
     - Status Code: 404
     - Response Body:
       ```json
       {
         "error": "User not found"
       }
       ```
- **Outcome**: PASSED

### Test Case 4: Invalid Content-Type Header
- **Description**: Verify that the API returns an error when the `Content-Type` header is not set to `application/json`.
- **Input**: Use the same `data.json` file as in the successful case.
- **Curl Command**:
```sh
curl.exe -X POST "http://localhost:5000/admin/api/webauthn/register/options" `
-H "Content-Type: text/plain" `
--data "@data.json" `
-b "<cookie name>=<cookie value>" `
-w "%{http_code}\n"
```

- **Expected Output**:
     - Status Code: 415
     - Response Body:
       ```json
       {
         "error": "Unsupported Media Type"
       }
       ```
- **Outcome**: PASSED

### Test Case 5: Missing Cookie
- **Description**: Verify that the API returns an error when the session cookie is missing or invalid.
- **Input**: Use the same `data.json` file as in the successful case.
- **Curl Command**:
```sh
curl.exe -X POST "http://localhost:5000/admin/api/webauthn/register/options" `
-H "Content-Type: application/json" `
--data "@data.json" `
-w "%{http_code}\n"
```

- **Expected Output**:
     - Status Code: 403
     - Response Body:
       ```json
       {
         "error": "Authentication required"
       }
       ```
- **Outcome**: PASSED
	   
## Verifying Registration API Testing

- **Curl Command**:

```sh
curl.exe -X POST "http://localhost:5000/admin/api/webauthn/register/verify" `
  -H "Content-Type: application/json" `
  --data "@data.json" `
  -b "<cookie_name>=<valid_cookie_value>" `
  -w "%{http_code}\n"
```
### Test 6: Complete successful execution

The **Verifying Registration API** is part of the WebAuthn flow, where it checks the validity of a user's registration response from a hardware authenticator (like a fingerprint scanner or security key). The process involves verifying that the client's response matches the challenge initially provided by the server and that the response is signed correctly by the user's authenticator.

**Why Testing Without a Front End is Hard:**
- This API needs the below as input.
```json
{
  "username": "alicejohnson",
  "attestationResponse": {
    "id": "<valid_id>",
    "rawId": "<valid_raw_id>",
    "type": "public-key",
    "response": {
      "clientDataJSON": "<valid_clientDataJSON>",
      "attestationObject": "<valid_attestationObject>"
    }
  }
}

```
- This API relies on data (like `clientDataJSON` and `attestationObject`) generated by client-side browser functions and authenticators.
- These components include complex cryptographic data and dynamic elements (like unique challenges and signatures) that are hard to replicate manually.
- The API also depends on maintaining session state (like the challenge) and securely interacting with client-side hardware, which isn't feasible to simulate without an actual front-end setup. The encoding of various objects in different formats makes it difficult to test the above API accurately.

**Overall Interaction:**
1. **Registering Options API** sends a challenge to the client.
2. The client generates a response using its authenticator.
3. **Verifying Registration API** checks this response to confirm the user's identity and register the public key for future authentications.

Without the front-end to handle these steps, generating valid test data and maintaining the required session and security context becomes very difficult.

- **Outcome**: PENDING
### Test 7: The username is missing
- **Input**: Modify `data.json` and don't include the username.
- **Expected Output**:
     - Status Code: 400
     - Response Body:
       ```json
       {
         "error": "Username and attestationResponse are required"
       }
       ```
- **Outcome**: PASSED
### Test 8: The attestationResponse is missing
- **Input**: Modify `data.json` to not include the attestationResponse.
- **Expected Output**:
     - Status Code: 400
     - Response Body:
       ```json
       {
         "error": "Username and attestationResponse are required"
       }
       ```
- **Outcome**: PASSED
### Test 9: The user not found
- **Input**: Modify `data.json` to include incorrect username.
- **Expected Output**:
     - Status Code: 404
     - Response Body:
       ```json
       {
         "error": "User not found"
       }
       ```
- **Outcome**: PASSED

### Test 10: Challenge Not Found in Session
- **Description**: The challenge required for verification is not found in the session, likely due to session expiry or incorrect session management.
- **Input**: Request body in data.json.
```json
{
    "username": "alicejohnson",
    "attestationResponse": {
        "id": "<valid_Id>",
        "rawId": "<valid_rawId>",
        "type": "public-key",
        "response": {
            "clientDataJSON": "<validClientDataJSON>",
            "attestationObject": "<validAuthenticationObject>"
        }
    }
}
```
- **Setup**:
  - Use an expired or invalid session cookie.
  ```sh
  curl.exe -X POST "http://localhost:5000/admin/api/webauthn/register/verify" `
  -H "Content-Type: application/json" `
  --data "@data.json" `
  -b "connect.sid=s%3Ainvalid_session_id123" `
  -w "%{http_code}\n"
  ````
- **Expected Output**:
  - **Status Code**: 400
  - **Response Body**:
    ```json
    {
      "error": "Challenge not found in session"
    }
    ```
- **Outcome**: PASSED

## Authentication Options API Testing

- **Curl Command**:

```sh
curl.exe -X POST "http://localhost:5000/admin/api/webauthn/login/options" `
-H "Content-Type: application/json" `
--data "@data.json" `
-b "connect.sid=s%3A4KNQAuvVn4rbkRwhXcEXMtWD54EAyRou.NsrpLrcVPWK9uhM%2Fi52Xm8t8L%2BS6YVQYUiIX5Q5MhmE" `
-w "%{http_code}\n"
```

### Test Case 11: Successful Authentication Options Retrieval
   - **Description**: Verify that the API returns authentication options for a valid user.
   - **Input**:
     - Request body in data.json:
     ```json 
      { 
          "username": "alicejohnson" 
      }
     ```
   - **Expected Output**:
     - Status Code: 200
     - Response Body:
       ```json
       {
          "rpID": "localhost",
          "challenge": "<base64url-encoded challenge>",
          "allowCredentials": [
             {
               "id": "1",
              "type": "public-key"
            }
          ],
          "timeout": 60000,
          "userVerification": "preferred"
       }
       ```
- **Outcome**: PASSED

### Test Case 12: Missing Username in Request
   - **Description**: Verify that the API returns an error when the `username` is not provided in the request body.
   - **Input**:
     - Request body in data.json: `{ }`
   - **Expected Output**:
     - Status Code: 400
     - Response Body:
       ```json
       {
         "error": "Username is required"
       }
       ```
- **Outcome**: PASSED

### Test Case 13: User Not Found
   - **Description**: Verify that the API returns an error when the user does not exist in the database.
   - **Input**:
     - Request body in data.json.
      ```json
        { "username": "nonexistentuser" }
      ````
   - **Expected Output**:
     - Status Code: 404
     - Response Body:
       ```json
       {
         "error": "User not found"
       }
       ```
- **Outcome**: PASSED

### Test Case 14: No Credentials Found for User
   - **Description**: Verify that the API returns an empty `allowCredentials` array when the user exists but has no credentials stored.
   - **Input**:
     - Request body in data.json: 
     ```json
      { 
          "username": "johndoe" 
      }
      ```
   - **Expected Output**:
     - Status Code: 200
     - Response Body:
       ```json
       {
          "rpID": "localhost",
          "challenge": "<base64url-encoded challenge>",
          "allowCredentials": [],
          "timeout": 60000,
          "userVerification": "preferred"
       }
       ```
- **Outcome**: PASSED

### Test Case 15: Invalid Content Type
   - **Description**: Verify that the API returns an error when the `Content-Type` header is not set to `application/json`.
   - **Input**:
     - Request body in data.json: 
     ```json
      { 
          "username": "alicejohnson" 
      }
      ```
     - Header: `Content-Type: text/plain`
   - **Expected Output**:
     - Status Code: 415
     - Response Body:
       ```json
       {
         "error": "Unsupported Media Type"
       }
       ```
- **Outcome**: PASSED   

## Verifying Authentication API Testing

- **Curl Command**:
```sh
curl.exe -X POST "http://localhost:5000/admin/api/webauthn/login/verify" `
-H "Content-Type: application/json" `
--data "@data.json" `
-b "connect.sid=<cookie_value>" `
-w "%{http_code}\n"
```

### Test Case 16: Complete successful execution

Its tough to test this functionality without frontend implementation due to similar reasons that are mentioned in test case 6.

- **Outcome**: PENDING

### Test Case 17: Missing Required Fields

- **Description**: The request is missing the required `username` or `authenticationResponse` fields.
- **Input**:
  - Request body in data.json: 
  ```json
  {
      "authenticationResponse": {
          "id": "dummy",
          "type": "public-key"
      }
  }
  ```
- **Expected Output**:
  - **Status Code**: 400
  - **Response Body**:
    ```json
    {
      "error": "Username and authenticationResponse are required"
    }
    ```
- **Outcome**: PASSED

### Test Case 18: User Not Found

- **Description**: The username provided does not exist in the database.
- **Input**: Request body in data.json.
```json
{
    "username": "nonexistentuser",
    "authenticationResponse": {
        "id": "dummy",
        "rawId": "dummyRawId",
        "type": "public-key",
        "response": {
            "clientDataJSON": "dummyClientDataJSON",
            "authenticatorData": "dummyAuthenticatorData",
            "signature": "dummySignature",
            "userHandle": "dummyUserHandle"
        }
    }
}
  ```
- **Expected Output**:
  - **Status Code**: 404
  - **Response Body**:
    ```json
    {
      "error": "User not found"
    }
    ```
- **Outcome**: PASSED

### Test Case 19: Credential Not Found

- **Description**: The `authenticationResponse.rawId` does not match any stored credentials for the user.
- **Input**: Request body in data.json.
```json
{
    "username": "alicejohnson",
    "authenticationResponse": {
        "id": "nonexistentCredentialId",
        "rawId": "nonexistentCredentialId",
        "type": "public-key",
        "response": {
            "clientDataJSON": "dummyClientDataJSON",
            "authenticatorData": "dummyAuthenticatorData",
            "signature": "dummySignature",
            "userHandle": "dummyUserHandle"
        }
    }
}
```
- **Expected Output**:
  - **Status Code**: 404
  - **Response Body**:
    ```json
    {
      "error": "Credential not found"
    }
    ```
- **Outcome**: PASSED

### Test Case 20: Invalid Authentication Response

Its tough to test this functionality without frontend implementation due to similar reasons that are mentioned in test case 6.

- **Description**: The `authenticationResponse` is invalid (e.g., the signature does not match the stored public key).
- **Input**: Request body in data.json.
- **Expected Output**:
  - **Status Code**: 400
  - **Response Body**:
    ```json
    {
      "status": "failed"
    }
    ```
- **Outcome**: PENDING

### Test Case 21: Challenge Not Found in Session

- **Description**: The challenge was not found in the session, likely due to session expiry or incorrect session management.
- **Input**: Request body in data.json.
```json
{
    "username": "alicejohnson",
    "authenticationResponse": {
        "id": "1",
        "rawId": "1",
        "type": "public-key",
        "response": {
            "clientDataJSON": "validClientDataJSON",
            "authenticatorData": "validAuthenticatorData",
            "signature": "validSignature",
            "userHandle": "validUserHandle"
        }
    }
}
```
- **Setup**: Use an expired or invalid session cookie.
  ```sh
  curl.exe -X POST "http://localhost:5000/admin/api/webauthn/login/verify" `
  -H "Content-Type: application/json" `
  --data "@data.json" `
  -b "connect.sid=s%3Ainvalid_session_id123" `
  -w "%{http_code}\n"
  ```
- **Expected Output**:
  - **Status Code**: 400
  - **Response Body**:
    ```json
    {
      "error": "Challenge not found in session"
    }
    ```
- **Outcome**: PASSED
