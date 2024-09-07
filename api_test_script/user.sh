#!/bin/bash

# Log in to AdminJS and save the session cookies to cookies.txt
# This is necessary to perform subsequent requests with authentication
curl -X POST http://localhost:5000/admin/login \
  -H "Content-Type: application/json" \
  -d '{"email": "admin@example.com", "password": "password"}' \
  -c cookies.txt

# Create a new user with the given attributes
curl -X POST http://localhost:5000/admin/api/resources/user/actions/new \
  -b cookies.txt \
  -H "Content-Type: application/json" \
  -d '{
      "DepartmentID": 1,
      "GivenNames": "John",
      "Surname": "Doe",
      "PreferredName": "Johnny",
      "Username": "johndoe",
      "Domain": "example.com",
      "JobTitle": "Developer",
      "Email": "john.doe@example.com",
      "Password": "password123",
      "Passkey": "passkey123",
      "DOB": "1990-01-01",
      "Gender": "M",
      "Height": 180,
      "Status": "A",
      "AdminFlag": 1,
      "ExitEnabled": true,
      "IsNew": true,
      "CalorieGoal": 2500
  }'

# Update the user's information, specifically the surname, email, and calorie goal
curl -X POST http://localhost:5000/admin/api/resources/user/records/1/edit \
  -b cookies.txt \
  -H "Content-Type: application/json" \
  -d '{
            "Surname": "DoeUpdated",
            "Email": "john.doe.updated@example.com",
            "CalorieGoal": 2100
        }'

# Search for the user with the given name "John" in the system and return the result
curl -X GET 'http://localhost:5000/admin/api/resources/user/actions/search/John' \
  -b cookies.txt | jq

# Retrieve all User Exercise Logs for a specific User ID
# Replace [USER_ID] with the actual User ID to filter the logs for that user
curl -X GET "http://localhost:5000/admin/api/resources/UserExerciseLog/records?[UserID]=1" \
     -b cookies.txt \
     -H "Content-Type: application/json"

# Retrieve exercise records where the department belongs to organisation with ID = 1
curl -X GET "http://localhost:5000/admin/api/resources/exercise/actions/list" \
     -b cookies.txt \
     -H "Content-Type: application/json" \
     -d '{
           "filters": {
              "Department.OrganisationID": 1
           }
         }' | jq

# Retrieve exercises related to a specific user by filtering with their User ID
curl -X GET "http://localhost:5000/admin/api/resources/exercise/actions/list" \
     -b cookies.txt \
     -H "Content-Type: application/json" \
     -d '{"filters": {"UserID": "1"}}' | jq

# End of the script
