# DBAutomotrizOscarArismendi

## Consultas requeridas

1. Obtener el historial de reparaciones de un vehículo específico

   ```mysql
   SELECT
   	re.id AS reparacion_id,
   	re.fecha,
   	re.empleado_id,
   	re.vehiculo_id,
   	re.costo_total,
   	re.descripcion
   FROM
   	reparacion re
   INNER JOIN
   	vehiculo ve ON re.vehiculo_id = ve.id
   WHERE
   	ve.id = 1;
   +---------------+------------+-------------+-------------+-------------+---------------------------------------+
   | reparacion_id | fecha      | empleado_id | vehiculo_id | costo_total | descripcion                           |
   +---------------+------------+-------------+-------------+-------------+---------------------------------------+
   |             1 | 2023-01-10 |           1 |           1 |      150.00 | Cambio de aceite y revisión general   |
   |             6 | 2023-03-10 |           1 |           1 |       90.00 | Cambio de aceite y alineación         |
   |             7 | 2024-01-15 |           1 |           1 |      120.00 | Cambio de aceite y balanceo de ruedas |
   +---------------+------------+-------------+-------------+-------------+---------------------------------------+
   3 rows in set (0.00 sec)
   -- se pasa por la tabla de reparaciones y solo se seleccionan las que tengan la id  igual al vehiculo que se busca
   ```

   

2. Calcular el costo total de todas las reparaciones realizadas por un empleado
   específico en un período de tiempo

```mysql
SELECT
	CONCAT(em.nombre," ",em.apellido) AS  nombre_empleado,
	SUM(re.costo_total)  AS costo_total_de_todas_las_reparaciones
FROM
	reparacion  re
INNER JOIN
	empleado em ON re.empleado_id = em.id
WHERE em.id = 5 AND re.fecha >= "2023-01-01"  AND  re.fecha <= "2023-12-31"
GROUP BY em.id;
+-----------------+---------------------------------------+
| nombre_empleado | costo_total_de_todas_las_reparaciones |
+-----------------+---------------------------------------+
| Andrés García   |                                200.00 |
+-----------------+---------------------------------------+
1 row in set (0.01 sec)
-- Se buscan las reparaciones del empleado con la id 5 y que hayan sido en 2023 para sumarse al final
```



3. Listar todos los clientes y los vehículos que poseen

```mysql
SELECT 
	cl.id AS id_cliente,
	cl.nombre  AS nombre_cliente,
	cl.apellido AS apellido_cliente,
	ve.id AS id_vehiculo,
	ve.placa,
	ve.marca_id,
	ve.modelo,
	ve.año_fabricacion
FROM
	cliente cl
LEFT JOIN
	vehiculo ve ON cl.id = ve.cliente_id
ORDER BY
	cl.id ASC;
+------------+----------------+------------------+-------------+--------+----------+---------+-----------------+
| id_cliente | nombre_cliente | apellido_cliente | id_vehiculo | placa  | marca_id | modelo  | año_fabricacion |
+------------+----------------+------------------+-------------+--------+----------+---------+-----------------+
|          1 | Juan           | Pérez            |           1 | ABC123 |        1 | Corolla |            2020 |
|          2 | Maria          | Gómez            |           2 | DEF456 |        2 | Focus   |            2019 |
|          3 | Luis           | Martínez         |           3 | GHI789 |        3 | Camaro  |            2018 |
|          4 | Ana            | Fernández        |           4 | JKL012 |        4 | Civic   |            2021 |
|          5 | Carlos         | Rodríguez        |           5 | MNO345 |        5 | Altima  |            2017 |
+------------+----------------+------------------+-------------+--------+----------+---------+-----------------+
5 rows in set (0.00 sec)

-- Se hace la union de tablas del cliente con sus respectivos vehiculos y se devuelven los datos ordenandolos por la id del cliente
```



4. Obtener la cantidad de piezas en inventario para cada pieza

```mysql
SELECT
	pi.nombre,
	inv.cantidad
FROM
	pieza_inventario piin
INNER JOIN
	inventario inv ON inv.id = piin.inventario_id
INNER JOIN
	pieza pi ON pi.id = piin.pieza_id;
+--------------------+----------+
| nombre             | cantidad |
+--------------------+----------+
| Filtro de Aceite   |      100 |
| Pastillas de Freno |      150 |
| Neumático          |      200 |
| Batería            |      250 |
| Amortiguador       |      300 |
+--------------------+----------+
5 rows in set (0.00 sec)
-- Uso la tabla intermedi pieza_inventario para relacionar pieza con inventario y saber su cantidad y nombre
```



5. Obtener las citas programadas para un día específico

```mysql
SELECT
	ci.id AS id_cita,
	ci.fecha_hora,
	CONCAT(cli.nombre,"  ",cli.apellido) AS nombre_cliente,
	ci.vehiculo_id
FROM
	cita ci
INNER JOIN
	cliente cli ON ci.cliente_id = cli.id
WHERE
	DATE(ci.fecha_hora) = "2024-01-15";
+---------+---------------------+----------------+-------------+
| id_cita | fecha_hora          | nombre_cliente | vehiculo_id |
+---------+---------------------+----------------+-------------+
|       7 | 2024-01-15 10:00:00 | Juan  Pérez    |           1 |
+---------+---------------------+----------------+-------------+
1 row in set (0.00 sec)
-- Uso fecha_hora de la tabla date para el dia dandole un formato en el cual no tiene encuenta la hora, ya que en este caso solo nos interesa el dia
```



6. Generar una factura para un cliente específico en una fecha determinada

```mysql
SELECT
	fa.id AS factura_id,
	CONCAT(cli.nombre," ",cli.apellido) AS nombre_cliente,
	fa.fecha,
	fa.total
FROM
	factura fa 
INNER JOIN
	cliente cli ON cli.id = fa.cliente_id
WHERE
	fa.fecha = "2024-01-15"
	AND
	cli.id = 1;
+------------+----------------+------------+--------+
| factura_id | nombre_cliente | fecha      | total  |
+------------+----------------+------------+--------+
|          7 | Juan Pérez     | 2024-01-15 | 142.80 |
+------------+----------------+------------+--------+
1 row in set (0.00 sec)
--  Busca la  factura del dia 2024-01-15 y con el cliente de id 1
```



7. Listar todas las órdenes de compra y sus detalles

```mysql
SELECT
	orcom.id AS id_orden_compra,
	orde.pieza_id AS id_pieza,
	orde.cantidad,
	orde.precio
FROM
	orden_compra orcom
INNER JOIN
	orden_detalle orde ON orde.orden_id = orcom.id;
+-----------------+----------+----------+--------+
| id_orden_compra | id_pieza | cantidad | precio |
+-----------------+----------+----------+--------+
|               1 |        1 |       10 |  15.00 |
|               2 |        2 |       20 |  50.00 |
|               3 |        3 |       30 | 100.00 |
|               4 |        4 |       40 |  80.00 |
|               5 |        5 |       50 | 120.00 |
+-----------------+----------+----------+--------+
5 rows in set (0.00 sec)
-- Une orden_compra  con orden_detalle para mostrar  la orden de compra con cada uno de suss detalles
```



8. Obtener el costo total de piezas utilizadas en una reparación específica

```mysql
SELECT
	pi.nombre,
	repi.cantidad,
	pre.precio_proveedor,
	(repi.cantidad * pre.precio_proveedor) AS total
FROM
	reparacion_piezas repi
INNER JOIN
	pieza pi ON repi.pieza_id  = pi.id
INNER JOIN
	precio AS pre ON pre.pieza_id = repi.pieza_id
WHERE
	repi.reparacion_id = 5;
+--------------+----------+------------------+--------+
| nombre       | cantidad | precio_proveedor | total  |
+--------------+----------+------------------+--------+
| Amortiguador |        2 |            90.00 | 180.00 |
+--------------+----------+------------------+--------+
1 row in set (0.00 sec)
-- Utiliza las tabla precio para el precio del proveedor de la pieza, reparacion_piezas para la cantidad y el total seria la multiplicacion de las dos
```



9. Obtener el inventario de piezas que necesitan ser reabastecidas (cantidad
   menor que un umbral)

```mysql
SELECT
	pi.nombre AS nombre_pieza,
	inv.cantidad
FROM
	inventario inv
INNER JOIN
	pieza_inventario piinv ON piinv.inventario_id = inv.id
INNER JOIN
	pieza pi ON  piinv.pieza_id = pi.id
WHERE
	inv.cantidad < 151;
+--------------------+----------+
| nombre_pieza       | cantidad |
+--------------------+----------+
| Filtro de Aceite   |      100 |
| Pastillas de Freno |      150 |
+--------------------+----------+
2 rows in set (0.00 sec)
-- se devuelve el nombre y la cantidad de la pieza en inventario que esta por debajo del umbral que seria 151 unidades
```



10. Obtener la lista de servicios más solicitados en un período específico

```mysql
SELECT
	se.nombre AS nombre_servicio,
	COUNT(se.nombre) AS numero_de_solicitudes
FROM
	cita ci
INNER JOIN
	cita_servicio cise ON cise.cita_id = ci.id
INNER JOIN
	servicio se ON  cise.servicio_id = se.id
WHERE
	DATE(ci.fecha_hora) >= "2023-06-01" AND DATE(ci.fecha_hora) <= "2023-06-05"
GROUP BY
	se.id
ORDER BY
	numero_de_solicitudes DESC
LIMIT 3;
+------------------+-----------------------+
| nombre_servicio  | numero_de_solicitudes |
+------------------+-----------------------+
| Cambio de Aceite |                     2 |
| Alineación       |                     1 |
| Balanceo         |                     1 |
+------------------+-----------------------+
3 rows in set (0.00 sec)
-- Se buscan los servicios que se hayan pedido cita entre el 2023-06-01 y 2023-06-05 y se hace el conteo de cada uno
```



11. Obtener el costo total de reparaciones para cada cliente en un período
    específico

```mysql
SELECT
	cl.id AS id_cliente,
	CONCAT(cl.nombre, " ", cl.apellido) AS  nombre_cliente,
	SUM(re.costo_total) AS total_reparaciones
FROM	
	cliente cl
INNER JOIN
	vehiculo ve ON cl.id = ve.cliente_id
LEFT JOIN
	reparacion re ON ve.id = re.vehiculo_id
WHERE
	re.fecha >= "2023-01-01" AND re.fecha <= "2023-06-05"
GROUP BY
	cl.id;
+------------+------------------+--------------------+
| id_cliente | nombre_cliente   | total_reparaciones |
+------------+------------------+--------------------+
|          1 | Juan Pérez       |             240.00 |
|          2 | Maria Gómez      |              90.00 |
|          3 | Luis Martínez    |             130.00 |
|          4 | Ana Fernández    |              70.00 |
|          5 | Carlos Rodríguez |             200.00 |
+------------+------------------+--------------------+
5 rows in set (0.00 sec)
-- Suma el coste total de reparaciones de las entre las fechas 2023-01-01 y  2023-06-05  para cada cliente
```



12. Listar los empleados con mayor cantidad de reparaciones realizadas en un
    período específico

```mysql
SELECT
	CONCAT(em.nombre," ", em.apellido) AS nombre_empleado,
	COUNT(re.empleado_id) AS total_de_reparaciones
	
FROM
	reparacion re
INNER JOIN
	empleado em ON re.empleado_id = em.id
WHERE
	re.fecha >= "2023-01-10" AND re.fecha < "2023-04-25"
GROUP BY
	re.empleado_id
ORDER BY
	total_de_reparaciones DESC
LIMIT 3;
+-----------------+-----------------------+
| nombre_empleado | total_de_reparaciones |
+-----------------+-----------------------+
| Pedro Sánchez   |                     2 |
| Laura Ramírez   |                     1 |
| José López      |                     1 |
+-----------------+-----------------------+
3 rows in set (0.00 sec)
-- Suma el total de reparaciones  de cada empleado entre el periode de 2023-01-10 y 2023-04-25 mostrandolo de manera descendente y solo los tres mejores
```



13. Obtener las piezas más utilizadas en reparaciones durante un período
    específico

```mysql
SELECT
	repi.pieza_id,
	pi.nombre AS nombre_pieza,
	SUM(repi.cantidad) AS cantidad_utilizada
FROM
	reparacion re
INNER JOIN
	reparacion_piezas repi ON repi.reparacion_id =  re.id
INNER JOIN
	pieza  pi ON repi.pieza_id = pi.id
WHERE
	re.fecha >= "2023-01-01" AND re.fecha < "2023-04-01"
GROUP BY
	repi.pieza_id
ORDER BY
	cantidad_utilizada DESC
LIMIT 3;
+----------+--------------------+--------------------+
| pieza_id | nombre_pieza       | cantidad_utilizada |
+----------+--------------------+--------------------+
|        3 | Neumático          |                  4 |
|        2 | Pastillas de Freno |                  2 |
|        1 | Filtro de Aceite   |                  1 |
+----------+--------------------+--------------------+
3 rows in set (0.00 sec)
-- Se unen las tablas reparacion, reparacion_piezas y pieza agrupandolas por la id de la pieza para poder sumar la cantidad usada de cada una entre las fechas 2023-01-01 y 2023-04-01, limitando solo las 3 mas usadas

```



14. Calcular el promedio de costo de reparaciones por vehículo

```mysql
SELECT
	ve.id AS id_vehiculo,
	ve.placa,
	AVG(re.costo_total) AS promedio_costo_reparaciones
FROM
	vehiculo ve
INNER JOIN
	reparacion re ON re.vehiculo_id = ve.id
GROUP BY
	ve.id
ORDER BY
	promedio_costo_reparaciones DESC;
+-------------+--------+-----------------------------+
| id_vehiculo | placa  | promedio_costo_reparaciones |
+-------------+--------+-----------------------------+
|           5 | MNO345 |                  200.000000 |
|           2 | DEF456 |                  135.000000 |
|           3 | GHI789 |                  130.000000 |
|           1 | ABC123 |                  120.000000 |
|           4 | JKL012 |                   70.000000 |
+-------------+--------+-----------------------------+
5 rows in set (0.00 sec)
-- se unen las  tablas vehiculo y reparacion, agrupandolas por la id del vehiculo para poder calcular el costo promedio y ordenarlas respecto a este de manera descendente
```



15. Obtener el inventario de piezas por proveedor

```mysql
SELECT
	pro.nombre AS nombre_proveedor,
	pi.nombre AS nombre_pieza,
	inv.cantidad
FROM
	precio pe
INNER JOIN
	pieza pi ON  pe.pieza_id = pi.id
INNER JOIN
	proveedor pro ON pe.proveedor_id = pro.id
INNER JOIN
	pieza_inventario piinv ON piinv.pieza_id =  pi.id
INNER JOIN
	inventario inv ON piinv.inventario_id = inv.id
ORDER BY
	nombre_proveedor;
+------------------+--------------------+----------+
| nombre_proveedor | nombre_pieza       | cantidad |
+------------------+--------------------+----------+
| Proveedor A      | Filtro de Aceite   |      100 |
| Proveedor A      | Pastillas de Freno |      150 |
| Proveedor B      | Pastillas de Freno |      150 |
| Proveedor C      | Neumático          |      200 |
| Proveedor D      | Batería            |      250 |
| Proveedor E      | Amortiguador       |      300 |
+------------------+--------------------+----------+
6 rows in set (0.01 sec)
-- Uno las tablas precio,pieza,proveedor,pieza_inventario y inventario para poder mostrar por orden alfabetico de porveedor cuales piezas dio y la cantidad actual en inventario de estas.

```



16. Listar los clientes que no han realizado reparaciones en el último año

```mysql
SELECT
	cli.id  AS id_cliente,
	CONCAT(cli.nombre," ",cli.apellido) AS nombre_cliente
FROM
	reparacion re
INNER JOIN
	vehiculo ve ON re.vehiculo_id = ve.id
INNER JOIN
	cliente cli ON ve.cliente_id = cli.id
GROUP BY
	cli.id
HAVING
	MAX(YEAR(re.fecha))  < 2024;
+------------+------------------+
| id_cliente | nombre_cliente   |
+------------+------------------+
|          3 | Luis Martínez    |
|          4 | Ana Fernández    |
|          5 | Carlos Rodríguez |
+------------+------------------+
3 rows in set (0.00 sec)
-- Se unen las tablas repara
```



17. Obtener las ganancias totales del taller en un período específico

```mysql
SELECT
	SUM(fa.total) AS ganancias_totales
FROM
	factura fa
WHERE
	fa.fecha  >= "2023-01-01" AND fa.fecha < "2024-04-01";
+-------------------+
| ganancias_totales |
+-------------------+
|           1011.50 |
+-------------------+
1 row in set (0.01 sec)
-- Se sacan las ganancias totales de lo facturado en el año 2023
```



18. Listar los empleados y el total de horas trabajadas en reparaciones en un
    período específico (asumiendo que se registra la duración de cada reparación)

```mysql
SELECT
	CONCAT(em.nombre," ",em.apellido) AS nombre_empleado,
	COUNT(em.id)*4 AS total_horas_reparacion
FROM
	empleado em
LEFT JOIN
	reparacion re ON re.empleado_id = em.id
WHERE
	re.fecha >= "2023-01-01" AND re.fecha < "2024-01-01"
GROUP BY
	em.id
ORDER BY
	total_horas_reparacion DESC;
+-----------------+------------------------+
| nombre_empleado | total_horas_reparacion |
+-----------------+------------------------+
| Pedro Sánchez   |                      8 |
| Laura Ramírez   |                      4 |
| José López      |                      4 |
| Claudia Torres  |                      4 |
| Andrés García   |                      4 |
+-----------------+------------------------+
5 rows in set (0.00 sec)
-- Al no tener duracion exacta de las reparaciones se asumio que cada una duraba 4 horas y se muestra el tiempo trabajado en el año 2023 ordenados de manera descendiente por las horas trabajadas en las reparacion
```



19. Obtener el listado de servicios prestados por cada empleado en un período
    específico

```mysql
SELECT
	CONCAT(em.nombre, " ", em.apellido) AS nombre_empleado,
	se.nombre AS nombre_servicio
FROM
	empleado em
INNER JOIN
	reparacion re ON em.id = re.empleado_id
INNER JOIN
	reparacion_servicio rese ON rese.reparacion_id = re.id
INNER JOIN
	servicio se ON se.id = rese.servicio_id
WHERE
	re.fecha > "2023-01-01" AND re.fecha < "2023-04-01"
ORDER BY
	em.id ASC;
+-----------------+------------------+
| nombre_empleado | nombre_servicio  |
+-----------------+------------------+
| Pedro Sánchez   | Cambio de Aceite |
| Pedro Sánchez   | Revisión General |
| Pedro Sánchez   | Cambio de Aceite |
| Pedro Sánchez   | Alineación       |
| Laura Ramírez   | Alineación       |
| Laura Ramírez   | Balanceo         |
| José López      | Revisión General |
| José López      | Cambio de Frenos |
+-----------------+------------------+
8 rows in set (0.01 sec)
-- Se utilizan la union de las tablas empleado,reparacion, reparacion_servicio y servicio para saber tanto el nombre del servicio como del empleado que la realizo para al minar mostrarlo por orden de id de empleado de manera ascendente.
```

## Subconsultas

1. Obtener el cliente que ha gastado más en reparaciones durante el último año.

   ```mysql
   SELECT
   	sub.id_cliente,
   	sub.nombre_cliente,
   	sub.total_gastado
   FROM (
   SELECT
   	cli.id AS id_cliente,
   	CONCAT(cli.nombre, " ", cli.apellido) AS nombre_cliente,
   	SUM(re.costo_total) AS total_gastado
   FROM
   	reparacion re
   INNER JOIN
   	vehiculo ve ON re.vehiculo_id = ve.id
   INNER JOIN
   	cliente cli ON  ve.cliente_id = cli.id
   WHERE
   	YEAR(re.fecha) = 2024 
   GROUP BY
   	cli.id
   ORDER BY
   	total_gastado DESC
   LIMIT 1)AS sub;
   
   +------------+----------------+---------------+
   | id_cliente | nombre_cliente | total_gastado |
   +------------+----------------+---------------+
   |          2 | Maria Gómez    |        180.00 |
   +------------+----------------+---------------+
   1 row in set (0.00 sec)
   -- Se hace una subconsulta en la cual se usa la union de las tablas reparacion,vehiculo y cliente para sumar el total de gasto en reparaciones de cada cliente en el año 2024 ordenado de mayor a menor para simplemente tener que mostrar el primero.
   ```

   

1. Obtener la pieza más utilizada en reparaciones durante el último mes

   ```mysql
   SELECT
   	sub.nombre_pieza,
   	sub.cantidad_pieza
   FROM (
   SELECT
   	pi.nombre AS nombre_pieza,
   	SUM(repi.cantidad) AS cantidad_pieza
   FROM
   	reparacion re
   INNER JOIN
   	reparacion_piezas repi ON repi.reparacion_id = re.id
   INNER JOIN
   	pieza pi ON repi.pieza_id = pi.id
   WHERE
   	MONTH(re.fecha) = 9 AND YEAR(re.fecha) = 2024
   GROUP BY
   	pi.id
   ORDER BY
   	cantidad_pieza DESC
   LIMIT 1) AS sub;
   
   +--------------------+----------------+
   | nombre_pieza       | cantidad_pieza |
   +--------------------+----------------+
   | Pastillas de Freno |              7 |
   +--------------------+----------------+
   1 row in set (0.00 sec)
   -- se hace una subconsulta en la cual se unen las tablas reparacion, reparacion_piezas y piezas en una union para poder tener la cantidad de piezas usadas en el ultimo mes y muestra solo la que mas se uso.
   ```

   

1. Obtener los proveedores que suministran las piezas más caras

   ```mysql
   SELECT
   	sub.id_proveedor,
   	sub.nombre_proveedor
   FROM
   	(
       SELECT
   	pro.id AS id_proveedor,
   	pro.nombre AS nombre_proveedor
   FROM
   	precio pre
   INNER JOIN
   	proveedor pro ON pre.proveedor_id = pro.id
   ORDER BY
   	pre.precio_proveedor DESC
   LIMIT 1
   ) AS sub;
   +--------------+------------------+
   | id_proveedor | nombre_proveedor |
   +--------------+------------------+
   |            5 | Proveedor E      |
   +--------------+------------------+
   1 row in set (0.00 sec)
   -- Se hace una subconsulta donde se ordena por el precio del proveedor, pero solo devuelve el proveedor con el precio mas alto
   ```

   

1. Listar las reparaciones que no utilizaron piezas especificas durante el ultimo año.

   ```mysql
   SELECT
   	re.id AS id_reparacion,
   	re.fecha,
   	re.descripcion
   FROM
   	reparacion re
   WHERE  re.id NOT IN(
   	SELECT
   		repi.reparacion_id
   	FROM
   		reparacion_piezas repi
       WHERE
   		repi.pieza_id = 1 
   	)
   	AND YEAR(re.fecha) = 2024;
   
   +---------------+------------+---------------------------------+
   | id_reparacion | fecha      | descripcion                     |
   +---------------+------------+---------------------------------+
   |             8 | 2024-09-01 | Alineación y revisión de frenos |
   +---------------+------------+---------------------------------+
   1 row in set (0.00 sec)
   
   -- Hace una subconsulta de las reparacion con la pieza con la id  y se busca que la reparacion no este entre esas especificando que solo se tiene en cuente las del 2024
   
   ```

   

1. Obtener las piezas que están en inventario por debajo del 10% del stock inicial

   ```mysql
   SELECT 
       pi.id AS id_pieza,
       pi.nombre AS nombre_pieza
   FROM 
       pieza pi
   INNER JOIN 
       pieza_inventario piinv ON pi.id = piinv.pieza_id
   INNER JOIN 
       inventario inv ON piinv.inventario_id = inv.id
   LEFT JOIN 
       (SELECT pieza_id, SUM(cantidad) AS total_gastado FROM reparacion_piezas GROUP BY pieza_id) repi 
       ON pi.id = repi.pieza_id
   WHERE 
       (IFNULL(repi.total_gastado, 0) > inv.cantidad * 0.9);
   +----------+------------------+
   | id_pieza | nombre_pieza     |
   +----------+------------------+
   |        1 | Filtro de Aceite |
   +----------+------------------+
   1 row in set (0.00 sec)
   -- Primero uso la tabla pieza despues utilizo la tabla intermedia pieza_inventario para poder relacionarla con inventario inventario despues hago una subconsulta para que de la tabla reparacion_piezas me de la suma del total_gastado en piezas en reparaciones y  si ese total gastado es mayor al 90% de la cantidad inicial en el inventario seleciono la fila mostrando solo el nombre de la pieza y su id correspondiente
   ```


## Procedimientos Almacenados

1. Crear un procedimiento almacenado para insertar una nueva reparación.

   ```mysql
   DELIMITER $$
   DROP PROCEDURE IF EXISTS insertar_reparacion;
   CREATE PROCEDURE insertar_reparacion(
       IN fecha DATE, 
       IN empleado_id INT,
       IN vehiculo_id INT, 
       IN costo_total DECIMAL(10,2),
       IN descripcion TEXT)
   BEGIN
   	INSERT INTO reparacion(fecha,empleado_id,vehiculo_id,costo_total,descripcion) VALUES (fecha,empleado_id,vehiculo_id,costo_total,descripcion) ;
   END $$
   DELIMITER ;
   CALL insertar_reparacion('2024-01-10', 1, 1, 150.00, 'Cambio de aceite y revisión general');
   
   -- En este procedimiento pedimos todos los datos necesarios para poder insertar una nueva reparacion
   ```

   

1. Crear un procedimiento almacenado para actualizar el inventario de una pieza.

   ```mysql
   DELIMITER $$
   DROP PROCEDURE IF EXISTS actualizar_inventario_pieza;
   CREATE PROCEDURE actualizar_inventario_pieza(
   	IN pieza_id INT,
   	IN nueva_cantidad INT)
   BEGIN
   	DECLARE mensaje VARCHAR(100);
   	UPDATE inventario inv
   	SET
   		inv.cantidad = nueva_cantidad
   	WHERE inv.id IN(
       	SELECT
       		piinv.inventario_id
       	FROM
       		pieza_inventario piinv
      		WHERE piinv.pieza_id = pieza_id);
      	IF (ROW_COUNT() > 0) THEN
      		SET mensaje =  CONCAT("La id de la pieza: " ,pieza_id," ha sido actualizada exitosamente");
      	ELSE
      		SET mensaje =  CONCAT("La id de la pieza: " ,pieza_id," no se ha encontrado");
      	END IF;
      	SELECT mensaje AS "Mensaje";
   END $$
   DELIMITER ;
   
   CALL actualizar_inventario_pieza(1,3);
   +-------------------------------------------------------+
   | Mensaje                                               |
   +-------------------------------------------------------+
   | La id de la pieza: 1 ha sido actualizada exitosamente |
   +-------------------------------------------------------+
   1 row in set (0.01 sec)
   
   Query OK, 0 rows affected (0.02 sec)
   -- Se pide la id de la pieza y la nueva cantidad despues se pasa por la tabla de inventario en la cual se hace una subconsulta con pieza_inventario para saber si esta relacionado con esa pieza y se cambia, de haber algun cambio tendra un mensaje exitoso de lo contrario se dira que no la ha encontrado.
   
   ```

   

1. Crear un procedimiento almacenado para eliminar una cita

   ```mysql
   DELIMITER $$
   DROP PROCEDURE IF EXISTS eliminar_cita;
   CREATE PROCEDURE eliminar_cita(
   	IN cita_id INT)
   BEGIN
   	DECLARE mensaje VARCHAR(100);
   	DELETE FROM cita_servicio  cise WHERE cise.id = cita_id;
   	DELETE FROM cita ci WHERE ci.id = cita_id;
   	IF(ROW_COUNT() > 0 ) THEN
   		SET mensaje = CONCAT("La cita con la id ",cita_id," ha sido eliminada");
   	ELSE
   		SET mensaje = CONCAT("La cita con la id ",cita_id," no ha sido encontrada");
   	END IF;
   	SELECT mensaje AS "mensaje";
   END $$
   DELIMITER ; 
   
   CALL eliminar_cita(1);
   -- Creo un procedimiento en el cual pido la id a eliminar de la cita y primero la elimino de la tabla cita_servicio y despues de cita retornando un mensaje exitoso o de no encontrado.
   ```

   

1. Crear un procedimiento almacenado para generar una factura

   ```mysql
   DELIMITER $$
   DROP PROCEDURE IF EXISTS crear_factura;
   CREATE PROCEDURE crear_factura(
   	IN p_fecha DATE,
   	IN p_cliente_id INT,
   	IN p_reparaciones VARCHAR(255)
   )
   BEGIN
   	DECLARE v_total DECIMAL(10,2) DEFAULT 0.00;
       DECLARE v_reparacion_id INT;
       DECLARE v_precio DECIMAL(10,2);
       DECLARE v_pos INT DEFAULT 1;
       DECLARE v_length INT;
       DECLARE v_reparacion_list VARCHAR(255);
       -- creacion factura
       INSERT INTO factura(fecha,cliente_id,total) VALUES(p_fecha,p_cliente_id,v_total);
       SET @factura_id = LAST_INSERT_ID();
       SET  v_reparacion_list = p_reparaciones;
       SET v_length = LENGTH(v_reparacion_list)  - LENGTH(REPLACE(v_reparacion_list,",",""))+1;
       -- loop para pasar por todas las reparaciones
       WHILE v_pos <= v_length DO
       	SET v_reparacion_id = SUBSTRING_INDEX(SUBSTRING_INDEX(v_reparacion_list, ",", v_pos), ",", -1);
   
       	SELECT costo_total INTO v_precio FROM reparacion re WHERE re.id =  v_reparacion_id;
       -- inserciones de factura_detalle
           INSERT INTO factura_detalle(factura_id,reparacion_id,cantidad,precio) VALUES (@factura_id,v_reparacion_id,1,v_precio);
           SET v_total = v_total + v_precio;
           SET v_pos = v_pos + 1;
        END WHILE;
        UPDATE factura SET total = v_total*1.19 WHERE id = @factura_id;
   END $$
   DELIMITER ;
   CALL crear_factura('2024-06-08', 1, '1,2,3');
   -- Se realiza un procedimiento en el cual se pide la fecha de la factura, la id del cliente y las id de las reparaciones a modo de string  para poder generar tanto los detalles de la factura como el costo total con IVA
   ```

   

1. Crear un procedimiento almacenado para obtener el historial de reparaciones
   de un vehículo

   ```mysql
   DELIMITER $$
   DROP PROCEDURE IF EXISTS historial_reparaciones;
   CREATE PROCEDURE historial_reparaciones(
   	IN id_vehiculo INT)
   BEGIN
   	SELECT
   		re.id AS id_reparacion,
   		re.fecha,
   		re.empleado_id,
   		re.costo_total,
   		re.descripcion
   	FROM
   		reparacion re
   	WHERE
   		re.vehiculo_id = id_vehiculo;
   END $$
   DELIMITER ;
   CALL historial_reparaciones(1);
   +---------------+------------+-------------+-------------+---------------------------------------+
   | id_reparacion | fecha      | empleado_id | costo_total | descripcion                           |
   +---------------+------------+-------------+-------------+---------------------------------------+
   |             1 | 2023-01-10 |           1 |      150.00 | Cambio de aceite y revisión general   |
   |             6 | 2023-03-10 |           1 |       90.00 | Cambio de aceite y alineación         |
   |             7 | 2024-01-15 |           1 |      120.00 | Cambio de aceite y balanceo de ruedas |
   |             9 | 2024-01-10 |           1 |      150.00 | Cambio de aceite y revisión general   |
   +---------------+------------+-------------+-------------+---------------------------------------+
   4 rows in set (0.00 sec)
   
   Query OK, 0 rows affected (0.02 sec)
   -- Se crea un procedimiento en el cual se pide la id de un vehiculo, la cual se buca en la tabla reparaciones y  todas las que tengan relacion con esa id se muestran
   ```

   

1. Crear un procedimiento almacenado para calcular el costo total de
   reparaciones de un cliente en un período

   ```mysql
   DELIMITER $$
   DROP PROCEDURE IF EXISTS costo_total_cliente;
   CREATE PROCEDURE costo_total_cliente(
   	IN id_cliente INT,
   	IN fecha_minima DATE,
   	IN fecha_maxima DATE)
   BEGIN
   	SELECT
   		SUM(re.costo_total) AS costo_total_reparaciones
   	FROM
   		reparacion re
   	INNER  JOIN
   		vehiculo ve ON ve.id = re.vehiculo_id
   	WHERE
   		ve.cliente_id = id_cliente 
   		AND
   		re.fecha >= fecha_minima
   		AND
   		re.fecha <= fecha_maxima;
   END $$
   DELIMITER ;
   CALL costo_total_cliente(1,"2023-01-1","2023-12-31");
   +--------------------------+
   | costo_total_reparaciones |
   +--------------------------+
   |                   240.00 |
   +--------------------------+
   1 row in set (0.00 sec)
   
   Query OK, 0 rows affected (0.01 sec)
   -- Se crea un procedimiento en el cual se pide la id del cliente,  el rango minimo y maximo de la fecha y dependiendo de eso se busca en  la tabla reparaciones todos los vehiculos que sean del cliente y que esten en el rango establecido para sumar el cossto de todas las reparaciones
   ```

   

1. Crear un procedimiento almacenado para obtener la lista de vehículos que
   requieren mantenimiento basado en el kilometraje.

   ```mysql
   DELIMITER $$
   DROP PROCEDURE IF EXISTS  mantenimiento_por_kilometraje;
   CREATE PROCEDURE mantenimiento_por_kilometraje(
   	IN kilometraje_in INT)
   BEGIN
   	SELECT
   		ve.id AS  id_vehiculo,
   		ve.placa,
   		ve.modelo,
   		ve.año_fabricacion,
   		kive.kilometraje
   	FROM
   		kilometraje_vehiculo kive
   	INNER JOIN
   		vehiculo ve ON kive.vehiculo_id  = ve.id
   	WHERE
   		kive.kilometraje >=  kilometraje_in;
   END $$
   DELIMITER ;
   
   CALL mantenimiento_por_kilometraje(16000);
   +-------------+--------+--------+-----------------+-------------+
   | id_vehiculo | placa  | modelo | año_fabricacion | kilometraje |
   +-------------+--------+--------+-----------------+-------------+
   |           2 | DEF456 | Focus  |            2019 |       25000 |
   |           4 | JKL012 | Civic  |            2021 |       30000 |
   |           5 | MNO345 | Altima |            2017 |       45000 |
   +-------------+--------+--------+-----------------+-------------+
   3 rows in set (0.00 sec)
   
   Query OK, 0 rows affected (0.01 sec)
   -- Se crea un procedimiento en elcual  el empleado puede poner el
   -- kilometraje y mirar todos los vehiculos que sean mayor o igual a ese umbral
   ```

   

1. Crear un procedimiento almacenado para insertar una nueva orden de compra

   ```mysql
   DELIMITER $$
   
   DROP PROCEDURE IF EXISTS crear_orden_compra;
   CREATE PROCEDURE crear_orden_compra(
       IN p_fecha DATE,
       IN p_empleado_id INT,
       IN p_proveedor_id INT,
       IN p_piezas VARCHAR(255),
       IN p_cantidades VARCHAR(255)
   )
   BEGIN
       DECLARE v_total DECIMAL(10,2) DEFAULT 0.00;
       DECLARE v_pieza_id INT;
       DECLARE v_cantidad INT;
       DECLARE v_precio DECIMAL(10,2);
       DECLARE v_pos INT DEFAULT 1;
       DECLARE v_length_piezas INT;
       DECLARE v_length_cantidades INT;
       DECLARE v_piezas_list VARCHAR(255);
       DECLARE v_cantidades_list VARCHAR(255);
   
       -- Creación de la orden de compra
       INSERT INTO orden_compra(fecha, proveedor_id, empleado_id, total) 
       VALUES(p_fecha, p_proveedor_id, p_empleado_id, v_total);
       
       SET @orden_compra_id = LAST_INSERT_ID();
       
       SET v_length_piezas = LENGTH(p_piezas) - LENGTH(REPLACE(p_piezas, ",", "")) + 1;
       SET v_length_cantidades = LENGTH(p_cantidades) - LENGTH(REPLACE(p_cantidades, ",", "")) + 1;
       
       IF v_length_piezas = v_length_cantidades THEN
           -- Loop para pasar por todas las piezas y cantidades
           WHILE v_pos <= v_length_piezas DO
               SET v_pieza_id = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(p_piezas, ",", v_pos), ",", -1) AS UNSIGNED);
               SET v_cantidad = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(p_cantidades, ",", v_pos), ",", -1) AS UNSIGNED);
               
               SELECT precio_venta INTO v_precio FROM precio 
               WHERE proveedor_id = p_proveedor_id AND pieza_id = v_pieza_id;
               -- Inserts para orden_detalle
               INSERT INTO orden_detalle(orden_id, pieza_id, cantidad, precio) 
               VALUES (@orden_compra_id, v_pieza_id, v_cantidad, v_precio);
               
               SET v_total = v_total + (v_precio * v_cantidad);
               SET v_pos = v_pos + 1;
           END WHILE;
           
           -- Actualizar el total de la orden de compra
           UPDATE orden_compra SET total = v_total WHERE id = @orden_compra_id;
       ELSE
           SELECT 'Ha ingresado incorrectamente las piezas o cantidades' AS error;
       END IF;
   END $$
   
   DELIMITER ;
   
   CALL crear_orden_compra('2024-06-08', 3,1, '1,2',"10,20");
   -- Se crea un procedimiento que requiere la insercion de una fecha, una id de empleado y  proveedor, las piezas que va a usar con su respectiva cantidad
   -- si la cadena de piezas es de diferente longitud que la de cantidad dara un error, de resto entrara en un ciclo en el cual pasara por las piezas y cantidades insertandolas en orden_detalle
   -- mientras calcula el total de la orden para poder completar orden_compra
   ```

   

1. Crear un procedimiento almacenado para actualizar los datos de un cliente

   ```mysql
   DELIMITER $$
   DROP PROCEDURE IF EXISTS actualizar_cliente;
   CREATE PROCEDURE actualizar_cliente(
   	IN id_cliente_in INT,
       IN nombre_in VARCHAR(50),
   	IN apellido_in VARCHAR(50),
   	IN email_in VARCHAR(254))
   BEGIN
   	DECLARE mensaje VARCHAR(100);
   	UPDATE cliente  
   	SET
   		nombre =  nombre_in,
   		apellido = apellido_in,
   		email = email_in
   	WHERE
   		id = id_cliente_in;
   	IF ROW_COUNT() > 0 THEN
   		SET mensaje = CONCAT("El cliente con la id ",id_cliente_in," ha sido actualizado exitosamente");
   	ELSE
   		SET mensaje = CONCAT("El cliente con la id ",id_cliente_in," no se ha encontrado");
   	END IF;
   	SELECT mensaje AS "mensaje";
   END $$
   DELIMITER ;
   
   CALL actualizar_cliente(1,'Juan', 'Pérez', 'juan.perez1@example.com');
   +---------------------------------------------------------+
   | mensaje                                                 |
   +---------------------------------------------------------+
   | El cliente con la id 1 ha sido actualizado exitosamente |
   +---------------------------------------------------------+
   1 row in set (0.01 sec)
   
   Query OK, 0 rows affected (0.01 sec)
   -- En este procedimiento se le pide todos los atributos del cliente en el  cual puede tener un mensaje exitoso si se encontro la id del cliente
   -- O un mensaje de que no ha sido encontrado.
   ```

   

1. Crear un procedimiento almacenado para obtener los servicios más solicitados
   en un período

   ```mysql
   DELIMITER $$
   DROP PROCEDURE IF EXISTS servicios_mas_solicitados;
   CREATE PROCEDURE servicios_mas_solicitados(
   	IN fecha_minima DATETIME,
   	IN fecha_maxima DATETIME)
   BEGIN
   	SELECT
   		se.id AS id_servicio,
   		se.nombre,
   		se.descripcion,
   		se.costo,
   		COUNT(ci.id) AS pedidos_totales
   	FROM
   		cita ci
   	INNER JOIN
   		cita_servicio cise ON cise.cita_id = ci.id
   	INNER JOIN
   		servicio se ON cise.servicio_id = se.id
   	WHERE
   		ci.fecha_hora >= fecha_minima
   		AND
   		ci.fecha_hora <= fecha_maxima
   	GROUP BY
   		se.id
   	ORDER BY
   		pedidos_totales DESC
   	LIMIT 3;
   END $$
   DELIMITER ; 
   
   CALL servicios_mas_solicitados('2023-06-01 09:00:00','2024-01-15 10:00:00');
   +-------------+------------------+--------------------------------+--------+-----------------+
   | id_servicio | nombre           | descripcion                    | costo  | pedidos_totales |
   +-------------+------------------+--------------------------------+--------+-----------------+
   |           1 | Cambio de Aceite | Cambio de aceite y filtro      |  50.00 |               3 |
   |           3 | Balanceo         | Balanceo de neumáticos         |  30.00 |               2 |
   |           4 | Revisión General | Revisión completa del vehículo | 100.00 |               1 |
   +-------------+------------------+--------------------------------+--------+-----------------+
   3 rows in set (0.01 sec)
   
   Query OK, 0 rows affected (0.03 sec)
   -- El procedimiento requiere de un rango de fecha en el cual se debe poner la hora y despues se encargara  de pasara por todas las citas de un 
   -- servicio que se haya hecho para verificar que este dentro del rango  y mostrando tanto los datos  del servicio como las veces que se pidieron.
   ```

   
