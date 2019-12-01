from flask import Flask, render_template, redirect, url_for, request, flash, session, make_response
from flask_mysqldb import MySQL
# from pyreportjasper import JasperPy
# import os, reportePDF
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
				cur.execute('INSERT INTO Persona (cedula, nombre, correo, telefono,activo) VALUES (%s,%s,%s,%s,%s)',
					(cedula, nombre, correo, telefono, 1))
				mysql.connection.commit()
				sql = 'INSERT INTO Cliente (Persona_cedula) VALUES ('+cedula+')'
				print(sql)
				cur.execute(sql)
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

@app.route('/crear_reserva', methods = ["POST", "GET"])
def crear_reserva():
	if "persona" in session:
		if request.method == "POST":
			identificador = request.form["id"]
			f_llegada = request.form["f_llegada"]
			f_salida = request.form["f_salida"]
			costo = request.form["costo"]
			reservante = request.form["cbxClientes"]
			guia = request.form["cbxGuias"]

			cur = mysql.connection.cursor()

			sql = "INSERT INTO Reserva (id,fechaLlegada,fechaSalida,costo,reservante,Guia_Persona_cedula)"
			sql += f"VALUES({identificador},'{f_llegada}','{f_salida}',{costo},{reservante},{guia}) "
			cur.execute(sql)
			mysql.connection.commit()	
			return redirect(url_for("listar_reservas"))
		else:
			cur = mysql.connection.cursor()
			cur.execute('SELECT DISTINCT Persona_cedula FROM Cliente')
			data = cur.fetchall()
			cur = mysql.connection.cursor()
			cur.execute('SELECT DISTINCT Persona_cedula FROM Guia')
			data2 = cur.fetchall()
			return render_template("crear_reserva.html", usuario = session["persona"], clientes = data, guias = data2)
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


@app.route('/reservas')
def listar_reservas():
	if "persona" in session:
		cur = mysql.connection.cursor()
		cur.execute('SELECT * FROM Reserva')

		data = cur.fetchall()

		return render_template("reservas.html", reservas = data, usuario = session["persona"])
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

@app.route('/grupos')
def listar_grupos():
	if "persona" in session:
		cur = mysql.connection.cursor()
		cur.execute('SELECT Reserva_id, COUNT(Persona_cedula) AS n_personas FROM Grupo GROUP BY Reserva_id')
		datos = cur.fetchall()
		grupos = list()
		for dato in datos:	
			cur.execute(f"SELECT Persona_cedula, nombre FROM Grupo g INNER JOIN Persona p ON g.Persona_cedula = p.cedula WHERE Reserva_id = '{dato[0]}'")
			tupla = [dato, cur.fetchall()]
			grupos.append(tupla)

		tam = len(grupos)
		return render_template("grupos.html", grupos = grupos, tam = grupos, usuario = session["persona"])
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

@app.route('/editar_reserva<identificador>', methods = ["POST", "GET"])
def editar_reserva(identificador):
	if "persona" in session:
		if request.method == "POST":
			f_llegada = request.form["f_llegada"]
			f_salida = request.form["f_salida"]
			costo = request.form["costo"]
			reservante = request.form["cbxClientes"]
			guia = request.form["cbxGuias"]


			cur = mysql.connection.cursor()
			sql = f"UPDATE Reserva SET fechaSalida = '{f_salida}', costo = {costo}, reservante = {reservante}, Guia_Persona_cedula = {guia}, fechaLlegada = '{f_llegada}' WHERE id = {identificador}"
			cur.execute(sql)
			mysql.connection.commit()	
			return redirect(url_for("listar_reservas"))
		else:	
			cur = mysql.connection.cursor()
			sql = f'SELECT * FROM Reserva WHERE id = {identificador}'
			cur.execute(sql)
			data = cur.fetchall()
			cur = mysql.connection.cursor()
			cur.execute('SELECT DISTINCT Persona_cedula FROM Cliente')
			data2 = cur.fetchall()
			cur = mysql.connection.cursor()
			cur.execute('SELECT DISTINCT Persona_cedula FROM Guia')
			data3 = cur.fetchall()


			return render_template("editar_reserva.html", reserva = data[0], clientes = data2, guias = data3, usuario = session["persona"])
	else:
		return redirect(url_for("login"))		

@app.route('/eliminar_grupo<persona_gr>$<reserva>')
def eliminar_grupo(persona_gr, reserva):
	print("---------------", persona_gr, "------", reserva, "-------------")
	if "persona" in session:	
		cur = mysql.connection.cursor()
		sql = f"DELETE FROM Grupo WHERE Grupo.Reserva_id = {reserva} AND Grupo.Persona_cedula = '{persona_gr}'"
		cur.execute(sql)
		mysql.connection.commit()
		return redirect(url_for("listar_grupos"))		
	else:
		return redirect(url_for("login"))		

@app.route('/editar_grupo<identificador>')
def editar_grupo(identificador):
	if "persona" in session:

			cur = mysql.connection.cursor()
			sql = f"SELECT * FROM Grupo WHERE Reserva_id = '{identificador}'"
			cur.execute(sql)
			data = cur.fetchall()
			cur = mysql.connection.cursor()
			cur.execute('SELECT DISTINCT id FROM Reserva ORDER BY id ASC')
			data2 = cur.fetchall()
			cur.execute('SELECT cedula, nombre FROM Persona')
			data3 = cur.fetchall()

			return render_template("editar_grupo.html",grupo = data, reservas = data2, personas = data3, usuario = session["persona"])
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
			session["sql_actual"] = sql
			session["reporte_actual"] = 1
			#session["parametros"] = {'fechaSalida_param' : variable}
			#PDF CRISTHIAN
			"""rendered = render_template("index.html",titulo = "Reservas para el mes de x", reporte = data, usuario = session["persona"])
			css = ["static/lib/bootstrap/css/bootstrap.min.css",
			"static/css/style.css",
			"static/css/style-responsive.css",
			"static/css/table-responsive.css",]
			pdf = pdfkit.from_string(rendered, False, css=css)

			response = make_response(pdf)
			response.headers['Content-Type'] = 'application/pdf'
			response.headers['Content-Disposition'] = 'attachment; filename=output.pdf'
			return response
			return rendered"""

			return render_template("descripcion_reporte.html", titulo = "Reservas para el mes de "+str(variable), reporte = data, usuario = session["persona"], tipo = "reservas")
		elif reporte == "extension_correo":

			cur = mysql.connection.cursor()
			sql = f"SELECT * FROM Persona WHERE correo LIKE '%{variable}'"
			cur.execute(sql)
			data = cur.fetchall() 
			session["sql_actual"] = sql
			session["reporte_actual"] = 2
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
			cur.execute(sql)
			data = cur.fetchall()
			session["sql_actual"] = sql
			session["reporte_actual"] = "sitios_turisticos"
			session["parametros"] = {}
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
			cur.execute(sql)
			data = cur.fetchall()
			session["sql_actual"] = sql
			session["reporte_actual"] = 4
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
			cur.execute(sql)
			data = cur.fetchall()
			session["sql_actual"] = sql
			session["reporte_actual"] = 5
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
			session["sql_actual"] = sql
			session["reporte_actual"] = 6
			cur.execute(sql)
			data = cur.fetchall()
			titulo = f"Hoteles que han tenido el mismo numero de hospendantes que la empresa de hoteles {variable}"	
			return render_template("descripcion_reporte.html", titulo = titulo, reporte = data, usuario = session["persona"], tipo = "hospedantes_hoteles")
		elif reporte == "reservas_personas":
			cur = mysql.connection.cursor()
			sql = "SELECT re.id, re.reservante, COUNT(pe.cedula) AS cant_personas\n"
			sql +="FROM (grupo g INNER JOIN persona pe ON g.persona_cedula = pe.cedula)\n"
			sql +="INNER JOIN reserva re ON g.reserva_id = re.id\n"
			sql +="GROUP BY re.id\n"
			session["sql_actual"] = sql
			session["reporte_actual"] = "reservas_personas"
			session["parametros"] = {}
			cur.execute(sql)
			data = cur.fetchall()
			titulo = "Reservas por cantidad de viajeros"
			return render_template("descripcion_reporte.html", titulo = titulo, reporte = data, usuario = session["persona"], tipo = "reservas_personas")
		elif reporte == "asociados_por_reserva":
			cur = mysql.connection.cursor()
			sql = "SELECT Reserva_id,COUNT(Persona_cedula) as p_con_cuenta "
			sql +="FROM Grupo WHERE Persona_cedula IN (SELECT Cuenta.Cliente_Persona_cedula FROM Cuenta) "
			sql +="GROUP BY Reserva_id"

			cur.execute(sql)
			data = cur.fetchall()
			titulo = f"Cantidad de personas con cuenta en LACATULI por reserva"
			return render_template("descripcion_reporte.html", titulo = titulo, reporte = data, usuario = session["persona"], tipo = "asociados_por_reserva")

		elif reporte == "reserva_mas_numerosa_por_anio":
			cur = mysql.connection.cursor()
			sql = "SELECT Reserva_id,COUNT(Persona_cedula) as cant_personas FROM Grupo "
			sql+= f"WHERE Reserva_id IN (SELECT id from Reserva WHERE fechaLlegada LIKE '%{variable}%') "
			sql+= "AND Reserva_id IN (SELECT Reserva_id FROM (SELECT Reserva_id,COUNT(Persona_cedula) as p_con_cuenta "
			sql+= "FROM Grupo WHERE Persona_cedula IN (SELECT Cuenta.Cliente_Persona_cedula FROM Cuenta) "
			sql+= "GROUP BY Reserva_id HAVING p_con_cuenta > 1) as reservas_con_2Cuentas)GROUP BY Reserva_id "
			sql+= "ORDER BY cant_personas DESC"

			cur.execute(sql)
			data = cur.fetchall()
			titulo = f"Reserva(s) con el grupo más numeroso para el año {variable}\nAcalaración: Solo aquellas reservas con 2 personas (o más) con cuenta en LACATULI.com"
			return render_template("descripcion_reporte.html", titulo = titulo, reporte = data, usuario = session["persona"], tipo = "reserva_mas_numerosa_por_anio")
		
		elif reporte == "n_sitios_turisticos":
			cur = mysql.connection.cursor()
			sql = "SELECT Recorrido_id, descripcion, "
			sql += "COUNT(SitioTuristico_nombre) as cant_sitios FROM Recorrido, Paquete "
			sql += "WHERE id = Recorrido_id GROUP BY Recorrido_id" 
			cur.execute(sql)
			data = cur.fetchall()
			titulo = "Numero de sitios Turisticos a visitar en cada recorrido"
			return render_template("descripcion_reporte.html", titulo = titulo, reporte = data, usuario = session["persona"], tipo = "n_sitios_turisticos")
		
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

@app.route('/crear_grupo<personas_gr>$<reserva>')
def crear_grupo(personas_gr, reserva):
	if "persona" in session:
		if personas_gr != "_":

			personas_gr = personas_gr.split(",")

			cur = mysql.connection.cursor()
			for persona_gr in personas_gr:
				cur.execute('INSERT INTO Grupo (Reserva_id, Persona_cedula) VALUES (%s,%s)',
					(reserva, persona_gr))
				mysql.connection.commit()
			return redirect(url_for("listar_grupos"))
		else:
			cur = mysql.connection.cursor()
			cur.execute('SELECT DISTINCT id FROM Reserva ORDER BY id ASC')
			data = cur.fetchall()
			cur.execute('SELECT cedula, nombre FROM Persona')
			data2 = cur.fetchall()
			return render_template("crear_grupo.html", reservas = data, personas = data2, usuario = session["persona"])
	else:
		return redirect(url_for("login"))

@app.route('/cargar_datos')
def cargar_datos():
	cur = mysql.connection.cursor()
	cur.execute('SELECT DISTINCT empresa FROM Vuelo')
	data = cur.fetchall()
	cur.execute('SELECT DISTINCT empresa FROM Bus')
	data2 = cur.fetchall()
	cur.execute('SELECT DISTINCT empresa FROM Hotel')
	data3 = cur.fetchall()
	return render_template("reportes.html", usuario = session["persona"], empresasVuelos = data, empresasBuses = data2, empresasHoteles = data3)

@app.route('/generar_reporte', methods=['POST'])
def generar_reporte_reservas():
	if request.method == 'POST':
		sql = session["sql_actual"]
		num = session["reporte_actual"]
		reportePDF.generarReporte(sql, mysql, num)
		return redirect(url_for("cargar_datos"))

@app.route('/generar_reporte_jasper', methods=['POST'])
def n():
	if request.method == 'POST':
		input_file = os.path.dirname(os.path.abspath(__file__)) + \
                 '/examples/'+ session["reporte_actual"] +'.jrxml'
		output = os.path.dirname(os.path.abspath(__file__)) + '/output/examples'
		con = {
			'driver': 'mysql',
			'username': 'admin',
			'password': '1234',
			'host': 'localhost',
			'database': 'lacatuli',
    	}
		jasper = JasperPy()
		jasper.process(
			input_file,
			output_file=output,
			format_list=["pdf"],
			db_connection=con,
			parameters=session["parametros"],
			locale='pt_BR'  # LOCALE Ex.:(en_US, de_GE)
		)
		return redirect(url_for("cargar_datos"))

def verificarLogin(usuario, contasenia):
	pass

if __name__ == '__main__':
    app.run(port = 3000, debug = True)

