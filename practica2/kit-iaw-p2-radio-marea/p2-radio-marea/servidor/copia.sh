#!/bin/sh
set -e

. /srv/servidor/radio.env

mkdir -p /copias
FECHA=$(date +%Y%m%d-%H%M%S)
FICHERO="/copias/radio-${FECHA}.sql"

mysqldump -h db -u "$COPIAS_USER" -p"$COPIAS_PASS" --ssl=0 --single-transaction --no-tablespaces radio > "$FICHERO"

find /copias -type f -name "radio-*.sql" -mtime +7 -delete
