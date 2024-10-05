#!/bin/bash

echo "Containers Down"
docker-compose down

echo "Remove Volume"
docker volume rm se_backend_pg_data