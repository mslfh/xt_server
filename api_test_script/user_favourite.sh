#!/bin/bash

# Log in and save the session to cookies.txt
curl -X POST http://localhost:5000/admin/login \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'email=admin@example.com&password=password' \
-c cookies.txt

# Fetch the user_favorite list, sort by ID in descending order, with 10 records per page
curl -X GET "http://localhost:5000/admin/api/resources/user_favorite/actions/list?direction=desc&sortBy=ID&page=1&perPage=10" \
-b cookies.txt \
-H "Content-Type: application/json" | jq

# Create a new user_favorite record with specified UserID, ExerciseID, and CreatedAt
curl -X POST http://localhost:5000/admin/api/resources/user_favorite/actions/new \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'UserID=2&ExerciseID=1&CreatedAt=2024-09-07'

# Retrieve details of the user_favorite record with ID=1
curl -X GET "http://localhost:5000/admin/api/resources/user_favorite/records/1/show" \
-b cookies.txt \
-H "Content-Type: application/json" | jq

# Edit the user_favorite record with ID=1, updating ExerciseID to 2
curl -X POST "http://localhost:5000/admin/api/resources/user_favorite/records/1/edit" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" \
-d "ExerciseID=2"

# Search for user_favorite records, sorting by ID in ascending order
curl -X GET "http://localhost:5000/admin/api/resources/user_favorite/actions/search/3?filters.ID=1&sortBy=ID&direction=asc" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded"

# Delete the user_favorite record with ID=5
curl -X POST "http://localhost:5000/admin/api/resources/user_favorite/records/5/delete" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded"

# Bulk delete user_favorite records with IDs 1, 2, and 3
curl -X POST "http://localhost:5000/admin/api/resources/user_favorite/bulk/bulkDelete" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'recordIds=1&recordIds=2&recordIds=3'

