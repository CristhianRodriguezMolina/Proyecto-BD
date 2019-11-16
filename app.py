from flask import Flask, render_template, redirect, url_for, request
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'admin'
app.config['MYSQL_PASSWORD'] = '1234'
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

@app.route('/crear_persona', methods = ["POST", "GET"])
def crear_persona():

	if request.method == "POST":
		cedula = request.form["cedula"]
		nombre = request.form["nombre"]
		correo = request.form["correo"]
		telefono = request.form["tel"]

		cur = mysql.connection.cursor()
		cur.execute('INSERT INTO Persona (cedula, nombre, correo, telefono) VALUES (%s,%s,%s,%s)',
			(cedula, nombre, correo, telefono))
		mysql.connection.commit()	
		return redirect(url_for("listar_personas"))

	else:

		return render_template("crear_persona.html")

@app.route('/personas')
def listar_personas():

	cur = mysql.connection.cursor()
	cur.execute('SELECT * FROM Persona')

	data = cur.fetchall()

	return render_template("personas.html", personas = data)

@app.route('/eliminar_persona<cedula>')
def eliminar_persona(cedula):
	cur = mysql.connection.cursor()
	cur.execute(f'DELETE FROM Persona WHERE Persona.cedula = {cedula}')
	mysql.connection.commit()
	return redirect(url_for("listar_personas"))

@app.route('/editar_persona<cedula>')
def editar_persona(cedula):

	if request.method == "POST":
		nombre = request.form["nombre"]
		correo = request.form["correo"]
		telefono = request.form["tel"]

		cur = mysql.connection.cursor()
		cur.execute('UPDATE Persona SET nombre = %s, correo = %s, telefono = %s WHERE cedula = %s',(nombre, correo, telefono, cedula))
		mysql.connection.commit()	
		return redirect(url_for("listar_personas"))
	else:	

		cur = mysql.connection.cursor()
		sql = f'SELECT * FROM Persona WHERE cedula = {cedula}'
		cur.execute(sql)
		data = cur.fetchall()

		return render_template("editar_persona.html", persona = data[0])

@app.route('/alertpopup')
def alert_popup():
	return render_template("alertpopup.html")

if __name__ == '__main__':
    app.run(port = 3000, debug = True)

