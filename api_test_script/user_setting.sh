#!/bin/bash

# Log in and save the session to cookies.txt
curl -X POST http://localhost:5000/admin/login \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'email=admin@example.com&password=password' \
-c cookies.txt

# Fetch the user_setting list, sort by ID in descending order, with 10 records per page
curl -X GET "http://localhost:5000/admin/api/resources/user_setting/actions/list?direction=desc&sortBy=ID&page=1&perPage=10" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" | jq

# Create a new user_setting record with SettingValue, SettingKey, Value, Content, and UserID
curl -X POST http://localhost:5000/admin/api/resources/user_setting/actions/new \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'SettingValue=High&SettingKey=theme&Value=dark&Content=user preferences&UserID=6'

# Retrieve details of the user_setting record with ID=1
curl -X GET "http://localhost:5000/admin/api/resources/user_setting/records/1/show" \
-b cookies.txt \
-H "Content-Type: application/json" | jq

# Edit the user_setting record with ID=1, updating the Value to 'light'
curl -X POST "http://localhost:5000/admin/api/resources/user_setting/records/1/edit" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" \
-d "Value=light"

# Search for user_setting records, sorting by ID in ascending order
curl -X GET "http://localhost:5000/admin/api/resources/user_setting/actions/search/3?filters.ID=1&sortBy=ID&direction=asc" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded"

# Delete the user_setting record with ID=5
curl -X POST "http://localhost:5000/admin/api/resources/user_setting/records/5/delete" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded"

# Bulk delete user_setting records with IDs 1, 2, and 3
curl -X POST "http://localhost:5000/admin/api/resources/user_setting/bulk/bulkDelete" \
-b cookies.txt \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'recordIds=1&recordIds=2&recordIds=3'

