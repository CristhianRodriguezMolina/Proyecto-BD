from flask import Flask, render_template, redirect, url_for, request
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'lacatuli'
mysql = MySQL(app)

@app.route('/')
def login():
	return render_template("login.html")

@app.route('/index')
def index():
	return render_template("index.html")

@app.route('/cliente', methods = ["POST","GET"])
def crear_cliente():

	if request.method == "POST":
		cliente = request.form["nm"]
		return redirect(url_for("index", msg = cliente))
	else:
		return render_template("cliente.html")

@app.route('/persona', methods = ["POST", "GET"])
def crear_persona():

	if request.method == "POST":
		cedula = request.form["cedula"]
		nombre = request.form["nombre"]
		correo = request.form["correo"]
		telefono = request.form["tel"]

		cur = mysql.connection.cursor()
		cur.execute('INSERT INTO PERSONA (cedula, nombre, correo, telefono) VALUES (%s,%s,%s,%s)',
		(cedula, nombre, correo, telefono))
		mysql.connection.commit()

		print("Cedula:",cedula," nombre: ",nombre," correo: ",correo," telefono: ",telefono)
		return redirect(url_for("index", msg = cedula))

	else:

		return render_template("crear_persona.html")



if __name__ == '__main__':
    app.run(port = 3000, debug = True)