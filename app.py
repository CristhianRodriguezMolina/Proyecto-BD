from flask import Flask, render_template, redirect, url_for, request

app = Flask(__name__)

@app.route('/<msg>')
def index(msg):
	return render_template("base.html", msg = msg)

@app.route('/cliente', methods = ["POST","GET"])
def crear_cliente():

	if request.method == "POST":
		cliente = request.form["nm"]
		return redirect(url_for("index", msg = cliente))
	else:
		
		return render_template("cliente.html")





if __name__ == '__main__':
    app.run(port = 3000, debug = True)