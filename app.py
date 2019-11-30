from flask import Flask, render_template, redirect, url_for, request, flash, session, make_response
from flask_mysqldb import MySQL
#import pdfkit

app = Flask(__name__)

#MySql connection
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'admin'
app.config['MYSQL_PASSWORD'] = '1234'
app.config['MYSQL_DB'] = 'lacatuli'
mysql = MySQL(app)

#MySql session
app.secret_key = 'my_secret_key'

@app.errorhandler(404)
def error404(e):
	return render_template("404.html")

@app.route('/', methods=["POST", "GET"])
def login():
	if request.method == "POST":
		usuario = request.form["usuario"]
		contrasenia = request.form["contrasenia"]

		print(usuario +" "+contrasenia)

		if len(usuario) >= 1 and len(contrasenia) >= 1:
			
			try:
				print(usuario + " " + contrasenia)

				cur = mysql.connection.cursor()
				sql = 'SELECT * FROM Cuenta WHERE usuario = \'{0}\''.format(usuario)
				cur.execute(sql)
				mysql.connection.commit()

				data = cur.fetchall()


				if data[0][1] == contrasenia:

					sql = 'SELECT * FROM Persona WHERE cedula = \'{0}\''.format(data[0][2])
					cur.execute(sql)
					mysql.connection.commit()

					data = cur.fetchall()

					session["usuario"] = usuario
					session["persona"] = data[0]

					return render_template("index.html", usuario = session["persona"])
				else:
					flash('Contraseña incorrecta')
			except:
				flash('El usuario \"' + usuario + '\" no existe')
			
		else:
			flash('Falta el usuario y/o la cotraseña')

		return redirect(url_for("login"))
	else:
		return render_template("login.html")

@app.route('/logout')
def logout():
	session.pop("user", None)
	session.pop("persona", None)
	return redirect(url_for("login"))

@app.route('/registrarse', methods=['POST','GET'])
def registrarse():
	if request.method == 'POST':

		cedula = request.form["cedula"]
		nombre = request.form["nombre"]
		correo = request.form["correo"]
		telefono = request.form["telefono"]

		usuario = request.form['usuario']
		contrasenia = request.form['contrasenia']

		if len(usuario) >= 1 and len(contrasenia) >= 1 and len(cedula) >= 1 and len(nombre) >= 1 and len(correo) >= 1 and len(telefono) >= 1:
			
			cur = mysql.connection.cursor()
			sql = f'SELECT * FROM Persona WHERE cedula = {cedula}'
			cur.execute(sql)
			mysql.connection.commit()

			data = cur.fetchall()

			print(len(data))

			if len(data) == 0:
				cur.execute('INSERT INTO Persona (cedula, nombre, correo, telefono) VALUES (%s,%s,%s,%s)',
					(cedula, nombre, correo, telefono))
				mysql.connection.commit()
				cur.execute('INSERT INTO Cliente (activo, Persona_cedula) VALUES (%s, %s)', ('1', cedula))
				cur.execute('INSERT INTO Cuenta (usuario, contrasenia, Cliente_Persona_cedula) VALUES (%s,%s,%s)',
					(usuario, contrasenia, cedula))
				mysql.connection.commit()	
			else:
				flash('El usuario con la cedula \"'+cedula+'\" ya esta registrado')
		else:
			flash('Faltan datos por llenar')
	
	return redirect(url_for("login"))

@app.route('/index')
def index():
	if "persona" in session:
		return render_template("index.html", usuario = session["persona"])
	else:
		flash('No se encuentra logueado.')
		return redirect(url_for("login"))

@app.route('/cliente', methods = ["POST","GET"])
def crear_cliente():
	if "persona" in session:
		if request.method == "POST":
			cliente = request.form["nm"]
			return redirect(url_for("index", msg = cliente))
		else:
			return render_template("cliente.html", usuario = session["persona"])
	else:
		return redirect(url_for("login"))

@app.route('/crear_persona', methods = ["POST", "GET"])
def crear_persona():
	if "persona" in session:
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
			return render_template("crear_persona.html", usuario = session["persona"])
	else:
		return redirect(url_for("login"))

@app.route('/personas')
def listar_personas():
	if "persona" in session:
		cur = mysql.connection.cursor()
		cur.execute('SELECT * FROM Persona')

		data = cur.fetchall()

		return render_template("personas.html", personas = data, usuario = session["persona"])
	else:
		return redirect(url_for("login"))

@app.route('/viajes')
def listar_viajes():
	if "persona" in session:
		cur = mysql.connection.cursor()
		cur.execute('SELECT * FROM Viaje')

		data = cur.fetchall()

		return render_template("viajes.html", personas = data, usuario = session["persona"])
	else:
		return redirect(url_for("login"))

@app.route('/cambiar_estado_persona<cedula>$<estado>')
def cambiar_estado_persona(cedula, estado):
	if "persona" in session:
		cur = mysql.connection.cursor()
		if estado == "1":
			cur.execute(f'UPDATE Persona SET activo = 0 WHERE Persona.cedula = {cedula}')
		else :
			cur.execute(f'UPDATE Persona SET activo = 1 WHERE Persona.cedula = {cedula}')
		mysql.connection.commit()
		return redirect(url_for("listar_personas"))
	else:
		return redirect(url_for("login"))

@app.route('/editar_persona<cedula>', methods = ["POST", "GET"])
def editar_persona(cedula):
	if "persona" in session:
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

			return render_template("editar_persona.html", persona = data[0], usuario = session["persona"])
	else:
		return redirect(url_for("login"))

@app.route('/reportes_lista$<reporte>$<variable>')
def generar_reportes(reporte,variable):
	if "persona" in session:
		if reporte == "reservas":

			cur = mysql.connection.cursor()
			sql = "SELECT * from Reserva where fechaSalida like '%"+str(variable)+"%'"
			cur.execute(sql)
			data = cur.fetchall() 

			#PDF CRISTHIAN
			# rendered = render_template("descripcion_reporte.html",titulo = "Reservas para el mes de x", reporte = data, usuario = session["persona"])
			# pdf = pdfkit.from_string(rendered, False)

			# response = make_response(pdf)
			# response.headers['Content-Type'] = 'application/pdf'
			# response.headers['Content-Disposition'] = 'attachment; filename=output.pdf'
			# return response

			return render_template("descripcion_reporte.html", titulo = "Reservas para el mes de "+str(variable), reporte = data, usuario = session["persona"], tipo = "reservas")
		elif reporte == "extension_correo":

			cur = mysql.connection.cursor()
			sql = f"SELECT * FROM Persona WHERE correo LIKE '%{variable}'"
			cur.execute(sql)
			data = cur.fetchall() 

			#PDF CRISTHIAN
			# rendered = render_template("descripcion_reporte.html",titulo = "Reservas para el mes de x", reporte = data, usuario = session["persona"])
			# pdf = pdfkit.from_string(rendered, False)

			# response = make_response(pdf)
			# response.headers['Content-Type'] = 'application/pdf'
			# response.headers['Content-Disposition'] = 'attachment; filename=output.pdf'
			# return response

			return render_template("descripcion_reporte.html", titulo = f"Personas con correos con extension de {variable}", reporte = data, usuario = session["persona"], tipo = "extension_correo")
		elif reporte == "sitios_turisticos":

			cur = mysql.connection.cursor()
			sql = "SELECT st.nombre AS sitio_turistico, st.direccion, c.nombre AS ciudad, count(per.cedula) AS turistas\n"
			sql += 	"FROM Persona per, Grupo g, Reserva res, Viaje v, Recorrido rec, Paquete paq, SitioTuristico st, Ciudad c \n"
			sql += 	"WHERE per.cedula = g.Persona_cedula\n"
			sql += 	"AND g.Reserva_id = res.id\n"
			sql += 	"AND res.id = v.Reserva_id\n"
			sql += 	"AND v.Recorrido_id = rec.id\n"
			sql += 	"AND rec.id = paq.Recorrido_id\n"
			sql += 	"AND paq.SitioTuristico_nombre = st.nombre\n"
			sql += 	"AND paq.SitioTuristico_codCiudad = st.Ciudad_codCiudad\n"
			sql += 	"AND st.Ciudad_codCiudad = c.codCiudad\n"
			sql += 	"GROUP BY st.nombre\n"
			sql += 	"ORDER BY turistas DESC\n"
			sql += 	"LIMIT 5"
			cur.execute(sql);
			data = cur.fetchall()
			return render_template("descripcion_reporte.html", titulo = "Los 5 sitios turisticos mas visitados en todos los tiempos", reporte = data, usuario = session["persona"], tipo = "sitios_turisticos")
		elif reporte == "reporte_vuelos_personas":
			vuelos = variable.split(",")
			cur = mysql.connection.cursor()
			sql = 	"SELECT p.cedula, p.nombre, vul.referencia, vul.empresa\n"
			sql += 	"FROM Vuelo vul, Tiqueteria t, Viaje vje, Reserva r, Grupo g, Persona p\n"
			sql += 	"WHERE vul.referencia = t.Vuelo_referencia\n"
			sql += 	"AND t.Viaje_id = vje.id\n"
			sql += 	"AND vje.Reserva_id = r.id\n"
			sql += 	"AND r.id = g.Reserva_id\n"
			sql += 	"AND g.Persona_cedula = p.cedula\n"
			sql += 	f"AND vul.empresa = '{vuelos[0]}'\n"
			sql += 	"AND p.cedula NOT IN(\n"
			sql += 		"SELECT p.cedula\n"
			sql += 		"FROM Vuelo vul, Tiqueteria t, Viaje vje, Reserva r, Grupo g, Persona p\n"
			sql += 		"WHERE vul.referencia = t.Vuelo_referencia\n"
			sql += 		"AND t.Viaje_id = vje.id\n"
			sql += 		"AND vje.Reserva_id = r.id\n"
			sql += 		"AND r.id = g.Reserva_id\n"
			sql += 		"AND g.Persona_cedula = p.cedula\n"
			sql += 		f"AND vul.empresa = '{vuelos[1]}'\n"
			sql += 	")"
			cur.execute(sql);
			data = cur.fetchall()
			titulo = f"Personas que han viajado en vuelos de {vuelos[0]} pero no en vuelos de {vuelos[1]}"
			return render_template("descripcion_reporte.html", titulo = titulo, reporte = data, usuario = session["persona"], tipo = "reporte_vuelos_personas")
		elif reporte == "prom_sillas_buses":
			cur = mysql.connection.cursor()
			sql = 	"SELECT empresa, AVG(numAsientos) AS prom_asientos FROM Bus\n"
			sql +=	"GROUP BY empresa\n"
			sql +=	"HAVING AVG(numAsientos) > (\n"
			sql +=		"SELECT AVG(numAsientos) AS prom_asientos FROM Bus\n"
			sql +=		f"WHERE empresa LIKE '{variable}'\n"
			sql += 	")"
			cur.execute(sql);
			data = cur.fetchall()
			titulo = f"Empresas de buses que tiene un promedio de sillas mayor al de la empresa {variable}"	
			return render_template("descripcion_reporte.html", titulo = titulo, reporte = data, usuario = session["persona"], tipo = "prom_sillas_buses")
		elif reporte == "hospedantes_hoteles":
			cur = mysql.connection.cursor()
			sql = 	"SELECT h.empresa AS hotel, COUNT(p.cedula) AS n_clientes\n"
			sql +=	"FROM Persona p, Grupo g, Reserva r, Viaje v, Acomodacion a, Hotel h\n"
			sql +=	"WHERE p.cedula = g.Persona_cedula\n"
			sql +=	"AND g.Reserva_id = r.id\n"
			sql +=	"AND r.id = v.Reserva_id\n"
			sql +=	"AND v.id = a.Viaje_id\n"
			sql +=	"AND a.Hotel_nit = h.nit\n"
			sql +=	f"AND h.empresa NOT LIKE '{variable}'\n"
			sql +=	"GROUP BY h.empresa\n"
			sql +=	"HAVING COUNT(p.cedula) = (\n"
			sql +=	"	SELECT COUNT(p.cedula) AS n_clientes\n"
			sql +=	"	FROM Persona p, Grupo g, Reserva r, Viaje v, Acomodacion a, Hotel h\n"
			sql +=	"	WHERE p.cedula = g.Persona_cedula\n"
			sql +=	"	AND g.Reserva_id = r.id\n"
			sql +=	"	AND r.id = v.Reserva_id\n"
			sql +=	"	AND v.id = a.Viaje_id\n"
			sql +=	"	AND a.Hotel_nit = h.nit\n"
			sql +=	f"	AND h.empresa LIKE '{variable}'\n"
			sql +=	")"

			cur.execute(sql);
			data = cur.fetchall()
			titulo = f"Hoteles que han tenido el mismo numero de hospendantes que la empresa de hoteles {variable}"	
			return render_template("descripcion_reporte.html", titulo = titulo, reporte = data, usuario = session["persona"], tipo = "hospedantes_hoteles")
		else:	
			return render_template("reportes.html", usuario = session["persona"])
	else:
		return redirect(url_for("login"))

@app.route('/crear_viaje', methods = ["POST", "GET"])
def crear_viaje():
	if "persona" in session:
		if request.method == "POST":
			cedula = request.form["cedula"]
			nombre = request.form["nombre"]
			correo = request.form["correo"]
			telefono = request.form["tel"]

			cur = mysql.connection.cursor()
			cur.execute('INSERT INTO Persona (cedula, nombre, correo, telefono) VALUES (%s,%s,%s,%s)',
				(cedula, nombre, correo, telefono))
			mysql.connection.commit()	
			return redirect(url_for("listar_viajes"))
		else:
			return render_template("crear_viaje.html", usuario = session["persona"])
	else:
		return redirect(url_for("login"))

@app.route('/cargar_datos')
def cargar_datos():
	cur = mysql.connection.cursor()
	cur.execute('SELECT empresa FROM Vuelo GROUP BY empresa')
	data = cur.fetchall()
	cur.execute('SELECT empresa FROM Bus GROUP BY empresa')
	data2 = cur.fetchall()
	cur.execute('SELECT empresa FROM Hotel GROUP BY empresa')
	data3 = cur.fetchall()
	return render_template("reportes.html", usuario = session["persona"], empresasVuelos = data, empresasBuses = data2, empresasHoteles = data3)

def verificarLogin(usuario, contasenia):
	pass

if __name__ == '__main__':
    app.run(port = 3000, debug = True)

