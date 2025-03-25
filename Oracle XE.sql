--comentarios

/*
comentarios mas de una línea
*/

--no diferencia mayúsculas de minúsculas en las palabras clave

select * from EMP;
select * from DEPT;
--mayusculas y minusculas es igual
select DEPT_NO, DNOMBRE, LOC from DEPT;

--la ordenación siempre al final y afecta al select
select dept_no, dnombre, loc from dept;
--ascendente, pero no vale la pena p q lo da por defecto
select * from emp order by apellido asc;
--descendente
select * from emp order by apellido desc;

--orfdenar por más de un campo
select * from emp order by dept_no, oficio;

-- filtrado de registros
--operadores de comparación
/*
=
>=
<=
>
<
<> distinto
!= DISTINTO
*/
--oracle, por defecto, diferencia entre mayúsculas y mminúsculas en sus textos
--(string y varchar)
--todo lo que no se número se escribe entre comillas simples 'ññññ'
select * from emp where dept_no=10;

select * from emp where oficio='DIRECTOR';

select * from emp where oficio<>'DIRECTOR';
--  != FUNCIONA PERO NO ES ESTÁNDAR
select * from emp where oficio!='DIRECTOR';

--OPERADORESS RELACIONALES
--OR
--AND
--NOT (EVITARLO)

SELECT * FROM EMP WHERE DEPT_NO=10 AND OFICIO='DIRECTOR';

SELECT * FROM EMP WHERE DEPT_NO=10 OR OFICIO='DIRECTOR';

SELECT * FROM EMP WHERE DEPT_NO=10 OR DEPT_NO=20;

select * from emp where salario between 251000 and 390000 order by salario;

select * from emp where salario >= 251000 and salario <= 390000 order by
salario;

--evitar la negación
--mosrar los empleados que no sean director

select * from emp where not oficio='DIRECTOR';

--se puede hacer así
select * from emp where oficio <> 'DIRECTOR';

--cuandop usamos el NOT, internamente, se hacen DOS consultas, cuando usamos el
--operador solo se hace una

--operadores para buscar coincidencias en textos
/*
%
_
?
*/

--mostrar los empleados cuyo apellido comienza en s

select * from emp where apellido like 's%';

--mostar todos los empleados cuyo apellido sea de 4 letras

select * from emp where apellido like '____';

existe otro operador para buscar coincidencias de igualdad en un mismo campo
--mosttar empleados departamento 10 y  del 20 y 30, 55, 55, 65, 77
--operador IN

SELECT * FROM EMP WHERE DEPT_NO in (10,20,30,55,65,77);

--operador NOT IN

SELECT * FROM EMP WHERE not DEPT_NO in (10,20); --EVITARLO, no usarlo
SELECT * FROM EMP WHERE DEPT_NO not in (10,20); --si USARLO

--campos calculados

select apellido, salario, comision, (salario + comision) from emp;

--todo campo calculado POR NORMA debe tener un ALIAS
select apellido, salario, comision, (salario + comision)as total from emp;

--todos los empleados con salario mas comision mayor que 344500

select apellido, salario, comision, (salario + comision) as total from emp
where (salario+comision) >= 344500;

--queremos la consulta original y ordenar por ella

select apellido, salario, comision, (salario + comision) as total from emp
order by total;

--el select where actua sobre la TABLA y order by sobre el CURSOR

-- clausula distint se utiliza para el SELECT y elimina repetidos de la consulta

--mostrar el oficio de los empleados
select oficio from emp;

--mostrar el oficio de los empleados
select distinct oficio from emp;

select distinct oficio, apellido from emp;



--Mostrar todos los enfermos nacidos antes del 11/01/1970. 
select * from enfermo;
desc enfermo;

 select * from enfermo where fecha_nac <= '11/01/1970';

-- Igual que el anterior, para los nacidos antes del 1/1/1970 ordenados por
--número de inscripción. 
 select * from enfermo where fecha_nac <= '01/01/70' order by inscripcion;
 
 
 --Listar todos los datos de la plantilla del hospital del turno de mañana 
select * from plantilla; 
select * from plantilla where turno ='M';

--Idem del turno de noche. 
select * from plantilla where turno ='N';

--Listar los doctores que su salario anual supere 3.000.000 €. 
select * from doctor;
select * from doctor where (salario * 12) > 3000000;
select apellido,(salario * 12) as total_anual from doctor
where (salario * 12) > 3000000;

--Visualizar los empleados de la plantilla del turno de mañana que tengan un
--salario entre 2.000.000 y 2.250.000. 
select * from plantilla;
select * from plantilla where turno='M' and salario >=200000 and salario <=225000;
select * from plantilla where turno='M' and (salario >=200000 and salario <=225000);
select * from plantilla where turno='M' and salario between 200000 and 225000;
 
--Visualizar los empleados de la tabla emp que no se dieron de alta
--entre el 01/01/1980 y el 12/12/1982. 
select * from emp;
select * from emp where fecha_alt <= '01/01/80' or fecha_alt >= '12/12/1982' and oficio = 'EMPLEADO';
select * from emp where  oficio = 'EMPLEADO' and fecha_alt not in ('01/01/80', '12/12/1982');
select * from emp where oficio = 'EMPLEADO' and fecha_alt <> ANY ('01/01/80', '12/12/1982');

--no usarlo
select * from emp where fecha_alt not between '01/01/80' and '12/12/1982';
-----EL NOT SOLO EN " NOT IN", DE RESTO NO USARLO
--no usarlo

--Mostrar los nombres de los departamentos situados en Madrid o en Barcelona. 
SELECT * FROM dept;
select dnombre, loc from dept where loC='MADRID' or loc='BARCELONA';

-- consultas de agrupación

--deben tener un alias

/*
count(*): cuent numero de registros incluyendo nulos
count(campo): cuenta numero de registros sin nulos
sum(numero)
avg(numero)
max(campo)maximo valor de un campo
min(campo)minimo valor de un campo

*/

select count (*) from doctor;
select count (*) as numero_doctores from doctor;

select count (apellido) as numero_doctores from doctor;

select count (*) as  doctores, max (salario) as maximo  from doctor;

--se pueden agrupar por algun campo de la tabla utilizando group by después del from

--TRUCO: debemos agrupar por cada campo que no sea una función
select * from doctor;
--doctores por especialidad
select count(*) as doctores, especialidad from doctor group by especialidad;
--numero de personas y maximo salario de los empleados, por departamento y oficio
select count (*) as personas, max(salario) as maximo_salario,
dept_no, oficio from emp group by dept_no, oficio;

--mostrar el numero de personas de la plantilla

select count(*) as personas from plantilla;

--mostrar el numero de personas por cada turno de la plantilla

select count (*) as personas, turno from plantilla group by turno;
select turno, count (*) as personas from plantilla group by turno;


--filtrando consultas de agrupación
--tenemos DOS posibiliddes
--WHERE antes del GROUP BY **agrupa por tabla**
--HAVING después del GROUP BY **agrupa por cursor**

--mostrar cuantos empleados tenemos por cada oficio
--que cobren mas de 200000
select count (*) as empleados, oficio from emp where salario >200000 group by oficio;

--mostrar cuantos empleados tenemos por cada oficio
--que sean analistas o vendedores

select count (*) as empleados, oficio from emp group by oficio
having oficio in ('ANALISTA', 'VENDEDOR');

select count (*) as empleados, oficio from emp where oficio in ('ANALISTA',
'VENDEDOR') group by oficio;

--NO ES OPTATIVO Y ESTAMOS OBLIGADOS a usar HAVING
--si queremos filtrar por una función de agrupación

--mostrar cuantos empleados tenemos por cada oficio
--solamente donde tengamos dos o mas empleados del mismo oficio

--*****importante*******

select count (*) as empleados, oficio from emp
group by oficio having count (*) >2;


















