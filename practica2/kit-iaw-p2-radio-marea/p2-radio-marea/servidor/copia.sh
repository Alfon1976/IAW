#!/usr/bin/env bash
set -euo pipefail

if [ -f "$(dirname "$0")/radio.env" ]; then
    . "$(dirname "$0")/radio.env"
elif [ -f "/etc/radio/radio.env" ]; then
    . "/etc/radio/radio.env"
fi

COPIAS_DIR="/srv/copias"
mkdir -p "$COPIAS_DIR"

FECHA=$(date +"%Y%m%d-%H%M%S")
FICHERO="$COPIAS_DIR/radio-$FECHA.sql"

mysqldump -h "${DB_HOST:-mariadb}" -u "$COPIAS_USER" -p"$COPIAS_PASS" "${DB_NAME:-radio}" > "$FICHERO"

# Borrar copias con más de 7 días o mantener limpias
find "$COPIAS_DIR" -type f -name "radio-*.sql" -mmin +10080 -delete 2>/dev/null || true

echo "Copia creada en $FICHERO"
