#!/bin/bash
set -e

echo "=================================="
echo "   REPARANDO RADIO MAREA"
echo "=================================="

# 1. Corregir B2.1 en app.py
python3 - <<'PY'
from pathlib import Path

p = Path("app/app.py")
s = p.read_text()

inicio = s.index('@app.route("/api/estudio")')
fin = s.index('# B4:', inicio)

funcion = '''@app.route("/api/estudio")
def estudio():
    if "locutor" not in session:
        return jsonify({"error": "Primero, POST /api/entrar"}), 401

    return jsonify({
        "locutor": session["locutor"],
        "siguiente": "Noticias del puerto, a las 13:00"
    })


'''

s = s[:inicio] + funcion + s[fin:]
s = s.replace('app.secret_key = "cambiame"\n', '')
p.write_text(s)
print("OK: B2.1 corregido")
PY

# 2. Comprobar variables de entorno
ENV="servidor/radio.env"

if ! grep -q '^SECRET_KEY=.' "$ENV"; then
    echo "ERROR: Falta SECRET_KEY en radio.env"
    exit 1
fi

if ! grep -q '^LOCUTOR_CLAVE=.' "$ENV"; then
    echo "ERROR: Falta LOCUTOR_CLAVE en radio.env"
    echo "Añade LOCUTOR_CLAVE a servidor/radio.env"
    exit 1
fi

echo "OK: Variables de entorno configuradas"

# 3. Revisar Gunicorn
echo "Configuración actual de Gunicorn:"
grep -n '^workers' servidor/gunicorn.conf.py

# 4. Validar Python
python3 -m py_compile app/app.py
echo "OK: Python sin errores de sintaxis"

# 5. Reiniciar
echo "Reiniciando servicios..."
./practica.sh recargar

# 6. Comprobar
echo "=================================="
echo "   COMPROBANDO BLOQUE B"
echo "=================================="

./practica.sh comprobar
