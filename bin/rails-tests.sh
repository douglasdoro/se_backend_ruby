#!/bin/bash

echo "Running all tests"
docker-compose exec -it test bin/rspec 
