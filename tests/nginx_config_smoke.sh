#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NGINX_CONF="$ROOT_DIR/nginx.conf"
PROXY_CONF="$ROOT_DIR/includes/proxy.conf"

assert_contains() {
  local file="$1"
  local needle="$2"
  if ! grep -Fq "$needle" "$file"; then
    echo "Missing expected config fragment in $file: $needle"
    exit 1
  fi
}

assert_contains "$NGINX_CONF" "location /api/auth"
assert_contains "$NGINX_CONF" "location /api/profiles"
assert_contains "$NGINX_CONF" "location /api/fields-service"
assert_contains "$NGINX_CONF" "location /api/meteo"
assert_contains "$NGINX_CONF" "location /api/dzz"
assert_contains "$NGINX_CONF" "location /api/iot"
assert_contains "$NGINX_CONF" "location ^~ /api/analytics"
assert_contains "$NGINX_CONF" "proxy_pass http://auth-service:8080/api/auth"
assert_contains "$NGINX_CONF" "proxy_pass http://profiles-service:8080/api/profiles"
assert_contains "$NGINX_CONF" "proxy_pass http://fields-service:8080/api/v2/fields-service"
assert_contains "$NGINX_CONF" "proxy_pass http://meteo-service:8080/api/meteo"
assert_contains "$NGINX_CONF" "proxy_pass http://dzz-service:8080/api/dzz"
assert_contains "$NGINX_CONF" "proxy_pass http://iot-service:8080/api/iot"
assert_contains "$NGINX_CONF" "set \$analytics_upstream http://analytics-service:8080"

assert_contains "$PROXY_CONF" "proxy_set_header Host \$host;"
assert_contains "$PROXY_CONF" "proxy_set_header X-Real-IP \$remote_addr;"
assert_contains "$PROXY_CONF" "proxy_http_version 1.1;"

echo "Nginx gateway smoke checks passed"
