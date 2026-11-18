from flask import Flask, jsonify, request, session

app = Flask(__name__)
app.secret_key = "pulsera-secreta-estudio"

@app.route("/entrar", methods=["POST"])
def entrar():
    datos = request.get_json(silent=True) or {}
    locutor = datos.get("locutor", "invitado")
    session["locutor"] = locutor
    return jsonify({"ok": True, "locutor": locutor}), 200

@app.route("/estudio", methods=["GET"])
def estudio():
    if "locutor" not in session:
        return jsonify({"error": "Necesitas pulsera para entrar al estudio"}), 401
    return jsonify({"ok": True, "locutor": session["locutor"]}), 200

if __name__ == "__main__":
    app.run(debug=True)
