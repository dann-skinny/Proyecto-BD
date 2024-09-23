import os
from flask import Flask, json, jsonify, render_template, request, redirect, send_file, session, url_for
from flask_mysqldb import MySQL

app = Flask(__name__)
app.secret_key = 'clave_secreta'

##########################################################
##### Base de datos MySQL. #####
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root' 
app.config['MYSQL_DB'] = 'colegio'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

mysql = MySQL(app)

##########################################################
##### Menú de calificaciones #####
@app.route('/')
def index():
    return render_template('index.html')

##########################################################
##### Busqueda #####
@app.route('/buscar', methods=['POST'])
def buscar():
    alumno = request.form.get('alumno')
    cursor = mysql.connection.cursor()

    # Consulta a la BD
    consulta = """SELECT a.nombre_asignatura, p.nombre_periodo, ROUND(AVG(c.nota), 1) AS calificacion_total
                  FROM alumno al
                  JOIN calificacion c ON al.idalumno = c.idalumno
                  JOIN elemento_evaluacion e ON c.idelemento = e.idelemento
                  JOIN asignatura a ON e.idasignatura = a.idasignatura
                  JOIN periodo_academico p ON c.idperiodo = p.idperiodo
                  WHERE al.idalumno = %s 
                  GROUP BY a.nombre_asignatura, p.nombre_periodo"""
    cursor.execute(consulta, (alumno,))
    myresult = cursor.fetchall()
    cursor.close()

    # Calcular el promedio
    if myresult:
        total_calificaciones = sum([row['calificacion_total'] for row in myresult])
        cantidad_asignaturas = len(myresult)
        promedio = total_calificaciones / cantidad_asignaturas

    return render_template('index.html', data=myresult, promedio=promedio)

if __name__ == '__main__':
    app.run(debug=True)