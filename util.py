from flask import flash

def verificarLogin(usuario, contrasenia):

    if len(usuario) >= 1 and len(contrasenia) >= 1:

        try:
            print(usuario + " " + contrasenia)

            cur = mysql.connection.cursor()
            sql = 'SELECT * FROM Cuenta WHERE usuario = \'{0}\''.format(usuario)
            cur.execute(sql)
            mysql.connection.commit()

            data = cur.fetchall()

            if data[0][1] == contrasenia:
                return redirect(url_for("index"))
            else:
                flash('Contraseña incorrecta')
        except:
            flash('El usuario \"' + usuario + '\" no existe')

    else:
        flash('Falta el usuario y/o la cotraseña')
