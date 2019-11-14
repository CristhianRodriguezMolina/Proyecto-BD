from flask import Flask, render_template, redirect, url_for, request

app = Flask(__name__)

@app.route('/<msg>')
def index(msg):
	return render_template("login.html")

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