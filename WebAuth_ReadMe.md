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

Kindly note that cookie value will change for a different login.

## Registration Options API Testing

The test cases for the **Registration Options** API using a JSON file (UTF-8 encoding) as input, with the corresponding `curl` commands are as follows. 

- **Curl Command**:
```bash
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
         "challenge": "<base64url-encoded-string>",
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

### 2. **Test Case: Missing Username**
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

### 3. **Test Case: User Not Found**
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

### 4. **Test Case: Invalid Content-Type Header**
- **Description**: Verify that the API returns an error when the `Content-Type` header is not set to `application/json`.
- **Input**: Use the same `data.json` file as in the successful case.
- **Curl Command**:
```bash
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

### 5. **Test Case: Missing Cookie**
- **Description**: Verify that the API returns an error when the session cookie is missing or invalid.
- **Input**: Use the same `data.json` file as in the successful case.
- **Curl Command**:
```bash
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
	   
## Verifying Registration API Testing

```bash
curl.exe -X POST "http://localhost:5000/admin/api/webauthn/register/verify" `
  -H "Content-Type: application/json" `
  --data "@data.json" `
  -b "<cookie_name>=<valid_cookie_value>" `
  -w "%{http_code}\n"
```