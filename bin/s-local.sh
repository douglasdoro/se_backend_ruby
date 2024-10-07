#!/bin/bash

echo "Running Rails server outside a container"
POSTGRES_USERNAME=postgres POSTGRES_PASSWORD=password POSTGRES_HOSTNAME=localhost POSTGRES_PORT=5432 rails s