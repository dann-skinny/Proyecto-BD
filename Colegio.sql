create database Colegio;
use Colegio;
drop database Colegio;

/*Tabla Sede*/
create table sede(
	idsede int primary key auto_increment,
    nombre_sede varchar(50) not null,
    director varchar(20) not null, 
	ubicacion varchar(50) not null
);

insert into sede(nombre_sede, director, ubicacion) values
	('Colegio Alamo', 'Esteban Quito', 'Calle 123');
    
select * from sede;

/*Tabla Nivel*/
create table nivel(
	idnivel int primary key auto_increment,
    nivel varchar(20) not null
);

insert into nivel(nivel) values
	('Preescolar'),
    ('Primaria'),
    ('Secundaria');
    
select * from nivel;

/*Tabla Grado*/
create table grado(
	idgrado int primary key auto_increment,
    numero_grado int not null,
    idnivel int not null,
    foreign key(idnivel) references nivel(idnivel) 
);

insert into grado(numero_grado, idnivel) values
-- Preescolar
	(1, 1),
	(2, 1),
    (3, 1),
-- Primaria
	(1, 2),
    (2, 2),
    (3, 2),
    (4, 2),
    (5, 2),
    (6, 2),
-- Secundaria
	(1, 3),
    (2, 3),
    (3, 3);
    
select * from grado;

/*Tabla Grupo*/
create table grupo(
	idgrupo int primary key auto_increment,
    letra_grupo varchar(1) not null,
    capacidad int not null,
    idgrado int not null,
    foreign key(idgrado) references grado(idgrado)
);

insert into grupo(letra_grupo, capacidad, idgrado) values
-- Grupos de preescolar (solo son grupos de primero)
	('A', 10, 1),
    ('B', 10, 1),
	('C', 10, 1),
    ('D', 10, 1),
-- Grupos de primaria (solo son grupos de primero y sexto)
	('A', 20, 4),
    ('B', 20, 4),
    ('A', 20, 9),
    ('B', 20, 9),
-- Grupos de secundaria (solo son grupos de tercero)
	('A', 30, 12),
    ('B', 30, 12);

select * from grupo;

/*Tabla Asignatura*/
create table asignatura(
	idasignatura int primary key,
    nombre_asignatura varchar(20) not null,
    idgrado int not null,
    foreign key(idgrado) references grado(idgrado) 
);

insert into asignatura(idasignatura, nombre_asignatura, idgrado) values
	(0001, 'Matemáticas III', 12),
    (0002, 'Historia de México', 12),
    (0003, 'Literatura III', 12),
    (0004, 'Ingles B2', 12),
    (0005, 'Educación Física', 12),
    (0006, 'Quimica', 12);

select * from asignatura;

-- Maestro y sus relaciones
/*Tabla Maestro*/
create table maestro(
	idmaestro int primary key auto_increment,
    nombre_maestro varchar(20)
);

insert into maestro(nombre_maestro) values
	('Elsa Pato'),
    ('Elmer Homero'),
    ('Mario Neta'),
    ('Elpa Tron'),
    ('Aquiles Baeza'),
    ('Elba Surita');

select * from maestro;

/*Tabla Maestro Nivel*/
create table maestro_nivel(
	idmaestro int not null,
    idnivel int not null,
    primary key(idmaestro , idnivel),
    foreign key(idmaestro) references maestro(idmaestro),
    foreign key(idnivel) references nivel(idnivel)
);

insert into maestro_nivel(idmaestro, idnivel) values
     (3, 2),
     (5, 3),
     (3, 1),
     (4, 3);

select * from maestro_nivel;

/*Tabla Maestro Asignatura*/ 
create table maestro_asignatura(
	idmaestro int not null,
    idasignatura int not null,
    primary key(idmaestro, idasignatura),
    foreign key(idmaestro) references maestro(idmaestro),
    foreign key(idasignatura) references asignatura(idasignatura) 
);

insert into maestro_asignatura(idmaestro, idasignatura) values
     (1, 0002),
     (3, 0004),
     (4, 0001),
     (6, 0003),
     (2, 0005);

select * from maestro_asignatura;

/*Tabla Maestro Grupo*/
create table maestro_grupo(
	idmaestro int not null,
    idgrupo int not null,
    primary key(idmaestro, idgrupo),
    foreign key(idmaestro) references maestro(idmaestro),
    foreign key(idgrupo) references grupo(idgrupo)
);

insert into maestro_grupo(idmaestro, idgrupo) values
     (4, 10),
     (2, 6), 
     (6, 2),
     (3, 5),
     (1, 8),
     (5, 7);

select * from maestro_grupo;

-- Alumno y sus relaciones
/*Tabla Alumno*/
create table alumno(
	idalumno int primary key,
    nombre_alumno varchar(20) not null,
    fecnac date not null,
    direccion varchar(50) not null,
    idgrupo int not null,
    foreign key(idgrupo) references grupo(idgrupo)
);

insert into alumno(idalumno, nombre_alumno, fecnac, direccion, idgrupo) values
     (01, 'Alberto', '2011-10-30', 'Calle 345', 10),
     (02, 'Daniela', '2010-12-20', 'Calle 897', 8),
     (03, 'Luis', '2011-08-10', 'Calle 244', 9),
     (04, 'Paola', '2010-06-09', 'Calle 880', 10),
     (05, 'Karla', '2011-06-02', 'Calle 238', 9),
     (06, 'Gerardo', '2010-01-12', 'Calle 249', 8);

select * from alumno;

/*Tabla Asistenca*/
create table asistencia(
	idasistencia int primary key auto_increment,
    fecha date not null,
    presente bool not null,
    idalumno int not null,
    foreign key(idalumno) references alumno(idalumno)
);

insert into asistencia(fecha, presente, idalumno) values
      ('2024-09-19', true, 1),
      ('2024-09-19', true, 2),
      ('2024-09-19', true, 3),
      ('2024-09-19', true, 4),
      ('2024-09-19', true, 5),
      ('2024-09-19', true, 6);

select * from asistencia;

/*Tabla Uniforme*/
create table uniforme(
	iduniforme int primary key auto_increment,
    fecha date not null,
    cumple bool not null,
    idalumno int not null,
    foreign key(idalumno) references alumno(idalumno)
);

insert into uniforme(fecha, cumple, idalumno) values
      ('2024-09-18', true, 1),
      ('2024-09-18', true, 2),
      ('2024-09-18', false, 3),
      ('2024-09-18', true, 4),
      ('2024-09-18', false, 5),
      ('2024-09-18', true, 6);

select * from uniforme;

-- Calificaciones y sus relaciones
/*Tabla Periodo Academico*/
create table periodo_academico(
	idperiodo int primary key auto_increment,
    nombre_periodo varchar(20) not null, 
    fecinicio date not null,
    fecfin date not null
);

insert into periodo_academico(nombre_periodo, fecinicio, fecfin) values
     ('Primer parcial', '2024-08-26', '2024-12-13'),
     ('Segundo parcial', '2025-01-13', '2025-06-11');

select * from periodo_academico;

/*Tabla Elemento Evaluacion*/ 
create table elemento_evaluacion(
	idelemento int primary key auto_increment,
    nombre_elemento varchar(20) not null,
    idasignatura int not null,
    foreign key(idasignatura) references asignatura(idasignatura) 
);

insert into elemento_evaluacion(nombre_elemento, idasignatura) values
     ('Tareas', 0006),
     ('Examenes', 0006),
     ('Laboratorio', 0006),
     ('Participacion', 0005),
     ('Competencias', 0005),
     ('Tareas', 0004),
     ('Examenes', 0004),
     ('Tareas', 0003),
     ('Examenes', 0003),
     ('Lecturas', 0003),
     ('Exposiciones', 0002),
     ('Examenes', 0002),
     ('Investigaciones', 0002),
     ('Examenes', 0001),
     ('Calculo mental', 0001),
     ('Tareas', 0001);

select * from elemento_evaluacion;

/*Tabla Calificacion*/
create table calificacion(
	idcalificacion int primary key auto_increment,
    nota int not null,
    idelemento int not null,
    idalumno int not null,
    idperiodo int not null,
    foreign key(idelemento) references elemento_evaluacion(idelemento),
    foreign key(idalumno) references alumno(idalumno),
    foreign key(idperiodo) references periodo_academico(idperiodo)
);

insert into calificacion(nota, idelemento, idalumno, idperiodo) values
    (85, 1, 1, 1),
    (90, 2, 1, 1),
    (75, 3, 1, 1),
    (80, 4, 1, 1),
    (85, 5, 1, 1),
    (66, 6, 1, 1),
    (95, 7, 1, 1),
    (92, 8, 1, 1),
    (72, 9, 1, 1),
    (100, 10, 1, 1),
    (83, 11, 1, 1),
    (75, 12, 1, 1),
    (69, 13, 1, 1),
    (96, 14, 1, 1),
    (99, 15, 1, 1),
    (97, 16, 1, 1),
    
    (95, 1, 2, 1),
    (90, 2, 2, 1),
    (85, 3, 2, 1),
    (95, 4, 2, 1),
    (72, 5, 2, 1),
    (66, 6, 2, 1),
    (81, 7, 2, 1),
    (79, 8, 2, 1),
    (99, 9, 2, 1),
    (100, 10, 2, 1),
    (84, 11, 2, 1),
    (78, 12, 2, 1),
    (69, 13, 2, 1),
    (96, 14, 2, 1),
    (99, 15, 2, 1),
    (97, 16, 2, 1);

select * from calificacion;

-- Convenio y sus relaciones
/*Tabla Convenio Preparatoria*/ 
create table convenio_preparatoria(
	idconvenio int primary key auto_increment,
    nombre_preparatoria varchar(20) not null
);

insert into convenio_preparatoria(nombre_preparatoria) values
    ('Preparatoria 8'),
    ('Preparatoria 3'),
    ('Preparatoria 12');

select * from convenio_preparatoria;

/*Tabla Aspirantes*/
create table aspirantes(
	idconvenio int not null,
    idalumno int not null,
    primary key(idconvenio, idalumno),
    foreign key(idconvenio) references convenio_preparatoria(idconvenio),
    foreign key(idalumno) references alumno(idalumno)
);

insert into aspirantes(idconvenio, idalumno) values
	(1, 1),
    (1, 2),
    (2, 3),
    (2, 4),
    (3, 5),
    (3, 6);

select * from aspirantes;

-- Beca y sus relaciones
/*Tabla Beca*/
create table beca(
	idbeca int primary key auto_increment,
    tipo_beca varchar(20) not null,
    porcentaje varchar(10) not null
);

insert into beca(tipo_beca, porcentaje) values
    ('Beca Académica', '50%'),
    ('Beca Deportiva', '30%'),
    ('Beca Cultural', '20%');

select * from beca;

/*Tabla Becados*/
create table becados(
	idbeca int not null,
    idalumno int not null,
    primary key(idbeca, idalumno),
    foreign key(idbeca) references beca(idbeca),
    foreign key(idalumno) references alumno(idalumno)
);

insert into becados(idbeca, idalumno) values
	(1, 1),
    (1, 3),
    (2, 2),
    (3, 5),
    (2, 6);

select * from becados;
