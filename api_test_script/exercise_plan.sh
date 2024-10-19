curl -i -X POST "https://localhost:5000/admin/login" -H "Accept: application/json" --data-urlencode 'email=admin@example.com' --data-urlencode 'password=password' --cookie-jar cookies.txt -k

curl -i -X GET "https://localhost:5000/admin/api/resources/exercise_plan/records/10/show" -b cookies.txt -H "Content-Type: application/json" -H "Accept: application/json" -k