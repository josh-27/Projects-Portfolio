#1
SELECT apellido1, apellido2, nombre
FROM 
persona
ORDER BY apellido1 DESC;

#2
SELECT nombre, apellido1, apellido2
FROM persona 
WHERE telefono IS NULL;

#3
SELECT nombre, apellido1, apellido2, fecha_nacimiento
FROM persona 
WHERE year(fecha_nacimiento) = 1999;

#4
SELECT nombre, tipo, nif, telefono 
FROM persona 
WHERE tipo = 'profesor' 
AND nif LIKE '%K'
AND telefono IS NULL;

#5
SELECT nombre, curso, cuatrimestre, id_grado
FROM asignatura 
WHERE curso = 3 
AND cuatrimestre = 1
AND id_grado = 7;

#6
SELECT persona.apellido1, persona.apellido2, 
persona.nombre, departamento.nombre
FROM persona
JOIN profesor
	ON persona.id = profesor.id_profesor 
JOIN departamento 
	ON departamento.id = profesor.id_departamento
ORDER BY apellido1 ASC;

#7
SELECT persona.nombre, persona.nif, asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin
FROM alumno_se_matricula_asignatura
JOIN asignatura
	ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura
JOIN curso_escolar 
	ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar
JOIN persona
	ON persona.id = alumno_se_matricula_asignatura.id_alumno
WHERE persona.nif = '26902806M';

#8
SELECT departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre
FROM persona
JOIN profesor
	ON profesor.id_profesor = persona.id 
LEFT JOIN departamento
	ON departamento.id = profesor.id_profesor
ORDER BY apellido1 DESC;

#9
SELECT count(tipo)
FROM persona 
WHERE tipo = 'alumno'
AND sexo = 'M';

#10
SELECT count(tipo)
FROM persona 
WHERE tipo = 'alumno'
AND year(fecha_nacimiento) = 1999;

#11
SELECT count(profesor.id_profesor) AS profesores , departamento.nombre
FROM profesor
JOIN departamento 
	ON departamento.id = profesor.id_departamento
GROUP BY departamento.nombre
ORDER BY profesores DESC;

#12
SELECT count(profesor.id_profesor) AS profesores , departamento.nombre
FROM profesor
RIGHT JOIN departamento 
	ON profesor.id_departamento = departamento.id 
GROUP BY departamento.nombre;

#13
SELECT grado.nombre AS grado, COUNT(asignatura.nombre) AS asignatura
FROM asignatura
RIGHT JOIN grado 
	ON grado.id = asignatura.id_grado 
GROUP BY grado.nombre;

#14
SELECT grado.nombre AS grado, COUNT(asignatura.nombre) AS asignatura
FROM asignatura
RIGHT JOIN grado 
	ON grado.id = asignatura.id_grado 
GROUP BY grado.nombre
HAVING count(asignatura.nombre) >= 50;

#15
SELECT COUNT(asignatura.creditos) AS creditos, grado.nombre AS asignatura, asignatura.tipo AS tipo  
FROM grado
JOIN asignatura 
	ON  asignatura.id_grado  = grado.id 
GROUP BY asignatura.creditos, grado.nombre, asignatura.tipo;

#16
SELECT COUNT(asignatura.id_profesor) AS numero_asignaturas, profesor.id_profesor, persona.nombre, persona.apellido1, persona.apellido2
FROM profesor
JOIN persona 
ON persona.id = profesor.id_profesor
LEFT JOIN asignatura
ON profesor.id_profesor = asignatura.id_profesor 
GROUP BY asignatura.id_profesor, profesor.id_profesor
ORDER BY asignatura.id_profesor DESC;

#17
SELECT departamento.nombre, profesor.id_profesor
FROM departamento 
LEFT OUTER JOIN profesor
	ON departamento.id  = profesor.id_departamento
WHERE profesor.id_departamento IS NULL;

#18
SELECT persona.nombre, persona.apellido1, persona.apellido2, 
	departamento.nombre AS departamento, asignatura.nombre AS asignatura
FROM persona 
JOIN profesor
	ON persona.id = profesor.id_profesor
JOIN departamento
	ON profesor.id_departamento = departamento.id
LEFT JOIN asignatura  
	ON profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.nombre IS NULL;

#19
SELECT *
FROM persona per1
JOIN(SELECT MAX(fecha_nacimiento) fecha FROM persona per2
WHERE tipo = 'alumno') per2
ON per2.fecha = per1.fecha_nacimiento; 

#20
SELECT DISTINCT departamento.nombre departamento, 
	asignatura.nombre asignatura, asignatura.curso curso
FROM departamento
JOIN profesor
	ON departamento.id = profesor.id_departamento
LEFT JOIN asignatura 
	ON profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.nombre IS NULL;







































 


