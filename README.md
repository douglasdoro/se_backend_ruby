# S.E API Backend

# Como rodar

## Docker 
```bash
# Iniciar a applicação
docker-compose up
# Verifique se a aplicação está rodando em http://localhost:3000/up

# Rodar migrações
docker-compose exec api bin/rails db:migrate

# Rodar linter
docker-compose exec api bin/rubocop

# Rodar os testes
docker-compose exec api bin/rspec

# Rodar Seeds
docker-compose exec api bin/rails db:seed
```

## Localmente
```bash
# Run API
POSTGRES_USERNAME=postgres POSTGRES_PASSWORD=password POSTGRES_HOSTNAME=localhost POSTGRES_PORT=5432 bin/rails s
```
