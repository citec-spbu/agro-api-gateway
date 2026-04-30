# agro-api-gateway

Nginx gateway для маршрутизации запросов между фронтендом и микросервисами платформы.

## Стек
- Nginx
- Docker / Docker Compose

## Быстрый запуск
```bash
docker network create agronetwork 2>/dev/null || true
docker compose up -d --build
```

Gateway будет доступен по адресу `http://localhost:8080`.

## Маршруты
Основные префиксы:
- `/api/auth`
- `/api/profiles`
- `/api/fields-service`
- `/api/meteo`
- `/api/dzz`
- `/api/analytics`
