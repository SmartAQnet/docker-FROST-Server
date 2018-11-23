docker-compose exec database psql -U sensorthings -d sensorthings -c "CREATE EXTENSION IF NOT EXISTS \"postgis\""
docker-compose exec database psql -U sensorthings -d sensorthings -c "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\""

curl -X POST "http://localhost:8080/FROST-Server/DatabaseStatus"

pause
