from flask import Flask, render_template, redirect, url_for, request
from flaskext.mysql import MySQL

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

@app.route('/persona')
def crear_persona():

	return render_template("form_component.html")



if __name__ == '__main__':
    app.run(port = 3000, debug = True)