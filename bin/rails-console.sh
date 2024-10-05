#!/bin/bash

echo "Starting rails console inside the container"
docker-compose exec -it api bin/rails c
