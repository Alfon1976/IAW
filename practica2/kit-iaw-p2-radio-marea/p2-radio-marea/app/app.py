import os
import pymysql

def conectar_db():
    return pymysql.connect(
        host=os.environ.get("DB_HOST", "mariadb"),
        user=os.environ.get("DB_USER", "radio_web"),
        password=os.environ.get("DB_PASS", "8adb9709746d0a7fafe45e6029e2fc93"),
        database=os.environ.get("DB_NAME", "radio"),
        cursorclass=pymysql.cursors.DictCursor
    )

def leer_podcasts(buscar=None):
    db = conectar_db()
    with db.cursor() as cursor:
        if buscar:
            sql = "SELECT id, titulo, fecha, audio FROM podcasts WHERE titulo LIKE %s ORDER BY fecha DESC"
            cursor.execute(sql, ("%" + buscar + "%",))
        else:
            sql = "SELECT id, titulo, fecha, audio FROM podcasts ORDER BY fecha DESC"
            cursor.execute(sql)
        resultado = cursor.fetchall()
    db.close()
    return resultado
