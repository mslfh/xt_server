#!/bin/bash

# Step 1: Log in to Admin API to generate session cookies
echo "Logging in as admin..."
curl -X POST http://localhost:5000/admin/login \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'email=admin@example.com&password=password' \
-c cookies.txt

# Step 2: Create a new helpful hint
echo "Creating a new helpful hint..."
curl -X POST http://localhost:5000/admin/api/resources/helpful_hint/actions/new \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'DepartmentID=1&HintOrder=1&Hint=This is a helpful hint for testing purposes.'

# Step 3: List all helpful hints to verify the creation
echo "Listing all helpful hints..."
curl -X GET "http://localhost:5000/admin/api/resources/helpful_hint/actions/list?direction=desc&sortBy=ID&page=1&perPage=10" \
-b cookies.txt \
-H "Content-Type: application/json" | jq

# Step 4: Retrieve details of a specific helpful hint (replace 1 with actual record ID from listing)
echo "Showing details of helpful hint ID=1..."
curl -X GET "http://localhost:5000/admin/api/resources/helpful_hint/records/1/show" \
-b cookies.txt \
-H "Content-Type: application/json" | jq

# Step 5: Edit the helpful hint (updating HintOrder and Hint)
echo "Editing helpful hint with ID=1..."
curl -X POST "http://localhost:5000/admin/api/resources/helpful_hint/records/1/edit" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'HintOrder=2&Hint=This helpful hint has been updated.'

# Step 6: Delete a specific helpful hint
echo "Deleting helpful hint ID=1..."
curl -X POST "http://localhost:5000/admin/api/resources/helpful_hint/records/1/delete" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded"

# Step 7: Bulk delete helpful hints (IDs 2 and 3 as examples)
echo "Bulk deleting helpful hints with IDs 2 and 3..."
curl -X POST "http://localhost:5000/admin/api/resources/helpful_hint/bulk/bulkDelete" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'recordIds=2&recordIds=3'

