#!/bin/bash

# Step 1: Log in to Admin API to generate session cookies
echo "Logging in as admin..."
curl -X POST http://localhost:5000/admin/login \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'email=admin@example.com&password=password' \
-c cookies.txt

# Step 2: Create a new exercise delay
echo "Creating a new exercise delay..."
curl -X POST http://localhost:5000/admin/api/resources/exercise_delay/actions/new \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'Duration=30&DateTime=2024-09-07T14:00:00Z&ExerciseID=1&UserID=2'

# Step 3: List all exercise delays to verify the creation
echo "Listing all exercise delays..."
curl -X GET "http://localhost:5000/admin/api/resources/exercise_delay/actions/list?direction=desc&sortBy=ID&page=1&perPage=10" \
-b cookies.txt \
-H "Content-Type: application/json" | jq

# Step 4: Retrieve details of a specific exercise delay (replace 1 with actual record ID from listing)
echo "Showing details of exercise delay ID=1..."
curl -X GET "http://localhost:5000/admin/api/resources/exercise_delay/records/1/show" \
-b cookies.txt \
-H "Content-Type: application/json" | jq

# Step 5: Edit the exercise delay (updating the duration)
echo "Editing exercise delay with ID=1..."
curl -X POST "http://localhost:5000/admin/api/resources/exercise_delay/records/1/edit" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'Duration=45'

# Step 6: Delete a specific exercise delay
echo "Deleting exercise delay ID=1..."
curl -X POST "http://localhost:5000/admin/api/resources/exercise_delay/records/1/delete" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded"

# Step 7: Bulk delete exercise delays (IDs 2 and 3 as examples)
echo "Bulk deleting exercise delays with IDs 2 and 3..."
curl -X POST "http://localhost:5000/admin/api/resources/exercise_delay/bulk/bulkDelete" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'recordIds=2&recordIds=3'

