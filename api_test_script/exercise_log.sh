#!/bin/bash

# Log in and obtain the session cookies for authenticated access
curl -X POST http://localhost:5000/admin/login \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'email=admin@example.com&password=password' \
-c cookies.txt

# List all exercise log records with pagination and sorting
curl -X GET "http://localhost:5000/admin/api/resources/exercise_log/actions/list?direction=desc&sortBy=ID&page=1&perPage=10" \
-b cookies.txt \
-H "Content-Type: application/json" | jq

# Create a new exercise log entry
curl -X POST http://localhost:5000/admin/api/resources/exercise_log/actions/new \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'UserID=2&ExerciseID=1&StartDateTime=2024-09-07&EndDateTime=2024-09-07&Source=M&Duration=30&Repetitions=10'

# Retrieve details of a specific exercise log entry (ID=1)
curl -X GET "http://localhost:5000/admin/api/resources/exercise_log/records/1/show" \
-b cookies.txt \
-H "Content-Type: application/json" | jq

# Update an existing exercise log entry (ID=1)
curl -X POST "http://localhost:5000/admin/api/resources/exercise_log/records/1/edit" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" \
-d "Duration=60&Repetitions=15"

# Search for a specific exercise log entry based on filters and sort by ID
curl -X GET "http://localhost:5000/admin/api/resources/exercise_log/actions/search/3?filters.ID=1&sortBy=ID&direction=asc" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded"

# Delete a specific exercise log entry (ID=5)
curl -X POST "http://localhost:5000/admin/api/resources/exercise_log/records/5/delete" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded"

# Bulk delete multiple exercise log entries
curl -X POST "http://localhost:5000/admin/api/resources/exercise_log/bulk/bulkDelete" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'recordIds=1&recordIds=2&recordIds=3'
