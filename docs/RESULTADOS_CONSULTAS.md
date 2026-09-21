# Resultados verificados de las consultas

Salida real obtenida al ejecutar los scripts de la carpeta `sql/`. Sirve
como comprobacion de la recomendacion 5 del enunciado ("verifica que todas
las consultas funcionen correctamente antes de entregar") y como referencia
para comparar con tus capturas de HeidiSQL.

- Fecha de ejecucion: 2026-09-21

> Nota: las consultas que usan `CURDATE()` (edad de los estudiantes y torneos
> del anio en curso) dependen de la fecha en que se ejecuten.


## Ejercicio 1 - Administracion de productos

Base de datos: `ej1_taller_prisma3d`  ·  Script: `sql/01_productos.sql`

### Consulta 1: mostrar todos los productos.

```sql
SELECT *
FROM productos;
```

```
+-------------+-------------+---------------------------------+-------------+--------+-------+---------------+
| id_producto | codigo      | nombre                          | categoria   | precio | stock | fecha_ingreso |
+-------------+-------------+---------------------------------+-------------+--------+-------+---------------+
|           1 | FIL-PLA-BLA | Filamento PLA 1.75mm blanco 1kg | Filamentos  |  24.90 |    35 | 2026-01-15    |
|           2 | FIL-PET-NEG | Filamento PETG 1.75mm negro 1kg | Filamentos  |  31.50 |    18 | 2026-01-15    |
|           3 | FIL-ABS-ROJ | Filamento ABS 1.75mm rojo 1kg   | Filamentos  |  28.75 |     7 | 2026-02-03    |
|           4 | RES-STD-GRI | Resina estandar gris 1L         | Resinas     |  52.00 |    12 | 2026-02-03    |
|           5 | RES-DEN-TRA | Resina dental translucida 500ml | Resinas     | 145.00 |     4 | 2026-02-20    |
|           6 | BOQ-060-LAT | Boquilla de laton 0.6mm         | Repuestos   |   4.20 |    80 | 2026-03-01    |
|           7 | BOQ-040-END | Boquilla endurecida 0.4mm       | Repuestos   |  18.90 |     9 | 2026-03-01    |
|           8 | EXT-DIR-V6  | Extrusor directo V6 completo    | Repuestos   |  89.90 |     6 | 2026-03-18    |
|           9 | PLA-PEI-220 | Placa flexible PEI 220x220mm    | Accesorios  |  34.00 |    22 | 2026-04-05    |
|          10 | LAV-UV-02   | Estacion de lavado y curado UV  | Equipos     | 210.00 |     3 | 2026-04-05    |
|          11 | IMP-FDM-01  | Impresora FDM 220x220x250mm     | Equipos     | 399.99 |     5 | 2026-05-10    |
|          12 | HER-ESP-KIT | Kit de esputulas y pinzas       | Accesorios  |  12.50 |    40 | 2026-05-10    |
|          13 | SEC-FIL-01  | Secador de filamento 2 bobinas  | Accesorios  |  76.40 |     8 | 2026-06-02    |
|          14 | ADH-LAC-01  | Laca adherente para cama 400ml  | Consumibles |   9.80 |    25 | 2026-06-02    |
|          15 | ALC-ISO-05  | Alcohol isopropilico 99% 5L     | Consumibles |  58.30 |     2 | 2026-06-20    |
+-------------+-------------+---------------------------------+-------------+--------+-------+---------------+
```

### Consulta 2: mostrar los productos cuyo precio sea mayor a $50.

```sql
SELECT *
FROM productos
WHERE precio > 50;
```

```
+-------------+-------------+---------------------------------+-------------+--------+-------+---------------+
| id_producto | codigo      | nombre                          | categoria   | precio | stock | fecha_ingreso |
+-------------+-------------+---------------------------------+-------------+--------+-------+---------------+
|           4 | RES-STD-GRI | Resina estandar gris 1L         | Resinas     |  52.00 |    12 | 2026-02-03    |
|           5 | RES-DEN-TRA | Resina dental translucida 500ml | Resinas     | 145.00 |     4 | 2026-02-20    |
|           8 | EXT-DIR-V6  | Extrusor directo V6 completo    | Repuestos   |  89.90 |     6 | 2026-03-18    |
|          10 | LAV-UV-02   | Estacion de lavado y curado UV  | Equipos     | 210.00 |     3 | 2026-04-05    |
|          11 | IMP-FDM-01  | Impresora FDM 220x220x250mm     | Equipos     | 399.99 |     5 | 2026-05-10    |
|          13 | SEC-FIL-01  | Secador de filamento 2 bobinas  | Accesorios  |  76.40 |     8 | 2026-06-02    |
|          15 | ALC-ISO-05  | Alcohol isopropilico 99% 5L     | Consumibles |  58.30 |     2 | 2026-06-20    |
+-------------+-------------+---------------------------------+-------------+--------+-------+---------------+
```

### Consulta 3: mostrar los productos que tengan stock menor a 10.

```sql
SELECT *
FROM productos
WHERE stock < 10;
```

```
+-------------+-------------+---------------------------------+-------------+--------+-------+---------------+
| id_producto | codigo      | nombre                          | categoria   | precio | stock | fecha_ingreso |
+-------------+-------------+---------------------------------+-------------+--------+-------+---------------+
|           3 | FIL-ABS-ROJ | Filamento ABS 1.75mm rojo 1kg   | Filamentos  |  28.75 |     7 | 2026-02-03    |
|           5 | RES-DEN-TRA | Resina dental translucida 500ml | Resinas     | 145.00 |     4 | 2026-02-20    |
|           7 | BOQ-040-END | Boquilla endurecida 0.4mm       | Repuestos   |  18.90 |     9 | 2026-03-01    |
|           8 | EXT-DIR-V6  | Extrusor directo V6 completo    | Repuestos   |  89.90 |     6 | 2026-03-18    |
|          10 | LAV-UV-02   | Estacion de lavado y curado UV  | Equipos     | 210.00 |     3 | 2026-04-05    |
|          11 | IMP-FDM-01  | Impresora FDM 220x220x250mm     | Equipos     | 399.99 |     5 | 2026-05-10    |
|          13 | SEC-FIL-01  | Secador de filamento 2 bobinas  | Accesorios  |  76.40 |     8 | 2026-06-02    |
|          15 | ALC-ISO-05  | Alcohol isopropilico 99% 5L     | Consumibles |  58.30 |     2 | 2026-06-20    |
+-------------+-------------+---------------------------------+-------------+--------+-------+---------------+
```


## Ejercicio 2 - Estudio de videojuegos

Base de datos: `ej2_nube_roja_studio`  ·  Script: `sql/02_estudio_videojuegos.sql`

### Consulta 1: mostrar todos los desarrolladores asignados al proyecto "Space Adventure".

```sql
SELECT d.id_desarrollador, d.nombres, d.apellidos, d.rol
FROM desarrolladores AS d
INNER JOIN proyecto_desarrollador AS pd ON pd.id_desarrollador = d.id_desarrollador
INNER JOIN proyectos AS p              ON p.id_proyecto        = pd.id_proyecto
WHERE p.nombre = 'Space Adventure';
```

```
+------------------+---------+-----------+-----------------------+
| id_desarrollador | nombres | apellidos | rol                   |
+------------------+---------+-----------+-----------------------+
|                1 | Mariela | Cordova   | Programadora gameplay |
|                2 | Ignacio | Vasquez   | Artista 3D            |
|                4 | Damian  | Loor      | Programador de motor  |
|                6 | Tomas   | Quispe    | QA tester             |
+------------------+---------+-----------+-----------------------+
```

### Consulta 2: listar todas las tareas pendientes.

```sql
SELECT *
FROM tareas
WHERE estado = 'pendiente';
```

```
+----------+--------------------------------------+-----------+-----------+--------------+-------------+------------------+
| id_tarea | titulo                               | estado    | prioridad | fecha_limite | id_proyecto | id_desarrollador |
+----------+--------------------------------------+-----------+-----------+--------------+-------------+------------------+
|        2 | Corregir colisiones en la nave madre | pendiente | alta      | 2026-10-02   |           1 |                1 |
|        4 | Optimizar carga de escenas           | pendiente | alta      | 2026-09-30   |           1 |                4 |
|        5 | Plan de pruebas del nivel 3          | pendiente | media     | 2026-10-20   |           1 |                6 |
|        7 | Grabar ambiente de lluvia            | pendiente | baja      | 2026-11-18   |           2 |                5 |
|        9 | Ajustar dificultad de los faroles    | pendiente | media     | 2026-09-28   |           3 |                3 |
+----------+--------------------------------------+-----------+-----------+--------------+-------------+------------------+
```

### Consulta 3: contar cuantas tareas tiene asignado cada desarrollador.

```sql
SELECT d.nombres, d.apellidos, COUNT(t.id_tarea) AS total_tareas
FROM desarrolladores AS d
LEFT JOIN tareas AS t ON t.id_desarrollador = d.id_desarrollador
GROUP BY d.id_desarrollador, d.nombres, d.apellidos;
```

```
+---------+-----------+--------------+
| nombres | apellidos | total_tareas |
+---------+-----------+--------------+
| Mariela | Cordova   |            3 |
| Ignacio | Vasquez   |            1 |
| Sofia   | Benitez   |            2 |
| Damian  | Loor      |            1 |
| Renata  | Aguirre   |            2 |
| Tomas   | Quispe    |            1 |
+---------+-----------+--------------+
```

### Consulta 4: mostrar los proyectos y la cantidad de desarrolladores que participan en cada uno.

```sql
SELECT p.nombre AS proyecto, COUNT(pd.id_desarrollador) AS total_desarrolladores
FROM proyectos AS p
LEFT JOIN proyecto_desarrollador AS pd ON pd.id_proyecto = p.id_proyecto
GROUP BY p.id_proyecto, p.nombre;
```

```
+------------------+-----------------------+
| proyecto         | total_desarrolladores |
+------------------+-----------------------+
| Space Adventure  |                     4 |
| Raices de Niebla |                     2 |
| Duelo de Faroles |                     2 |
+------------------+-----------------------+
```


## Ejercicio 3 - Biblioteca multimedia

Base de datos: `ej3_sala_lumiere`  ·  Script: `sql/03_biblioteca_multimedia.sql`

### Consulta 1: mostrar todas las peliculas.

```sql
SELECT *
FROM peliculas;
```

```
+-------------+----------------------------+-----------------+--------------+------------------+-----------+--------------------+-------------+
| id_pelicula | titulo                     | genero          | anio_estreno | duracion_minutos | idioma    | copias_disponibles | id_director |
+-------------+----------------------------+-----------------+--------------+------------------+-----------+--------------------+-------------+
|           1 | El ultimo tren a Latacunga | Drama           |         2019 |              112 | Espanol   |                  3 |           1 |
|           2 | Cenizas de sal             | Drama           |         2022 |               98 | Espanol   |                  2 |           1 |
|           3 | La ruta del condor         | Documental      |         2021 |               84 | Espanol   |                  4 |           2 |
|           4 | Nieve sobre el desierto    | Ciencia ficcion |         2023 |              131 | Ingles    |                  2 |           2 |
|           5 | Kilometro cero             | Accion          |         2018 |              105 | Espanol   |                  5 |           4 |
|           6 | Lagos de neon              | Ciencia ficcion |         2024 |              118 | Ingles    |                  1 |           3 |
|           7 | La casa de las abuelas     | Comedia         |         2020 |               92 | Espanol   |                  3 |           4 |
|           8 | Ojos de tormenta           | Suspenso        |         2025 |              107 | Ingles    |                  2 |           3 |
|           9 | Invierno en Odesa          | Drama           |         2024 |              124 | Ucraniano |                  1 |           5 |
|          10 | Raiz cuadrada del miedo    | Suspenso        |         2016 |               96 | Espanol   |                  2 |           5 |
|          11 | Manifiesto de papel        | Documental      |         2026 |               78 | Espanol   |                  1 |           1 |
|          12 | Orbita baja                | Ciencia ficcion |         2020 |              140 | Ingles    |                  2 |           2 |
+-------------+----------------------------+-----------------+--------------+------------------+-----------+--------------------+-------------+
```

### Consulta 2: mostrar las peliculas estrenadas despues de 2020.

```sql
SELECT *
FROM peliculas
WHERE anio_estreno > 2020;
```

```
+-------------+-------------------------+-----------------+--------------+------------------+-----------+--------------------+-------------+
| id_pelicula | titulo                  | genero          | anio_estreno | duracion_minutos | idioma    | copias_disponibles | id_director |
+-------------+-------------------------+-----------------+--------------+------------------+-----------+--------------------+-------------+
|           2 | Cenizas de sal          | Drama           |         2022 |               98 | Espanol   |                  2 |           1 |
|           3 | La ruta del condor      | Documental      |         2021 |               84 | Espanol   |                  4 |           2 |
|           4 | Nieve sobre el desierto | Ciencia ficcion |         2023 |              131 | Ingles    |                  2 |           2 |
|           6 | Lagos de neon           | Ciencia ficcion |         2024 |              118 | Ingles    |                  1 |           3 |
|           8 | Ojos de tormenta        | Suspenso        |         2025 |              107 | Ingles    |                  2 |           3 |
|           9 | Invierno en Odesa       | Drama           |         2024 |              124 | Ucraniano |                  1 |           5 |
|          11 | Manifiesto de papel     | Documental      |         2026 |               78 | Espanol   |                  1 |           1 |
+-------------+-------------------------+-----------------+--------------+------------------+-----------+--------------------+-------------+
```

### Consulta 3: mostrar las peliculas de un genero determinado.

```sql
SELECT *
FROM peliculas
WHERE genero = 'Ciencia ficcion';
```

```
+-------------+-------------------------+-----------------+--------------+------------------+--------+--------------------+-------------+
| id_pelicula | titulo                  | genero          | anio_estreno | duracion_minutos | idioma | copias_disponibles | id_director |
+-------------+-------------------------+-----------------+--------------+------------------+--------+--------------------+-------------+
|           4 | Nieve sobre el desierto | Ciencia ficcion |         2023 |              131 | Ingles |                  2 |           2 |
|           6 | Lagos de neon           | Ciencia ficcion |         2024 |              118 | Ingles |                  1 |           3 |
|          12 | Orbita baja             | Ciencia ficcion |         2020 |              140 | Ingles |                  2 |           2 |
+-------------+-------------------------+-----------------+--------------+------------------+--------+--------------------+-------------+
```


## Ejercicio 4 - Gestion de estudiantes

Base de datos: `ej4_instituto_antares`  ·  Script: `sql/04_gestion_estudiantes.sql`

### Consulta 1: mostrar todos los estudiantes.

```sql
SELECT *
FROM estudiantes;
```

```
+---------------+------------+-----------+------------+------------------+---------------------------------+------------+------------+------------+
| id_estudiante | cedula     | nombres   | apellidos  | fecha_nacimiento | correo                          | telefono   | ciudad     | id_carrera |
+---------------+------------+-----------+------------+------------------+---------------------------------+------------+------------+------------+
|             1 | 0923451871 | Andres    | Pilataxi   | 2004-02-18       | andres.pilataxi@antares.edu     | 0991234567 | Quito      |          1 |
|             2 | 0918273645 | Camila    | Verdugo    | 2003-11-05       | camila.verdugo@antares.edu      | 0987654321 | Guayaquil  |          1 |
|             3 | 1725489630 | Joel      | Naranjo    | 2009-06-30       | joel.naranjo@antares.edu        | 0965432178 | Ambato     |          1 |
|             4 | 1712398745 | Valentina | Sarmiento  | 2002-09-12       | valentina.sarmiento@antares.edu | 0978451236 | Cuenca     |          2 |
|             5 | 0604512398 | Mateo     | Chimbo     | 2008-12-24       | mateo.chimbo@antares.edu        | 0954123698 | Riobamba   |          2 |
|             6 | 1309871245 | Dayana    | Zambrano   | 2001-04-03       | dayana.zambrano@antares.edu     | 0993216547 | Manta      |          3 |
|             7 | 0801234567 | Kevin     | Caicedo    | 2005-08-21       | kevin.caicedo@antares.edu       | 0986541237 | Esmeraldas |          3 |
|             8 | 1104567823 | Brenda    | Jaramillo  | 2000-01-29       | brenda.jaramillo@antares.edu    | 0971234589 | Loja       |          4 |
|             9 | 0703215698 | Ismael    | Tandazo    | 2007-10-16       | ismael.tandazo@antares.edu      | 0968745123 | Machala    |          4 |
|            10 | 1003698521 | Fernanda  | Imbaquingo | 1999-05-07       | fernanda.imbaquingo@antares.edu | 0995874123 | Ibarra     |          1 |
+---------------+------------+-----------+------------+------------------+---------------------------------+------------+------------+------------+
```

### Consulta 2: mostrar los estudiantes mayores de 18 anios.

```sql
SELECT *
FROM estudiantes
WHERE TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) > 18;
```

```
+---------------+------------+-----------+------------+------------------+---------------------------------+------------+------------+------------+
| id_estudiante | cedula     | nombres   | apellidos  | fecha_nacimiento | correo                          | telefono   | ciudad     | id_carrera |
+---------------+------------+-----------+------------+------------------+---------------------------------+------------+------------+------------+
|             1 | 0923451871 | Andres    | Pilataxi   | 2004-02-18       | andres.pilataxi@antares.edu     | 0991234567 | Quito      |          1 |
|             2 | 0918273645 | Camila    | Verdugo    | 2003-11-05       | camila.verdugo@antares.edu      | 0987654321 | Guayaquil  |          1 |
|             4 | 1712398745 | Valentina | Sarmiento  | 2002-09-12       | valentina.sarmiento@antares.edu | 0978451236 | Cuenca     |          2 |
|             6 | 1309871245 | Dayana    | Zambrano   | 2001-04-03       | dayana.zambrano@antares.edu     | 0993216547 | Manta      |          3 |
|             7 | 0801234567 | Kevin     | Caicedo    | 2005-08-21       | kevin.caicedo@antares.edu       | 0986541237 | Esmeraldas |          3 |
|             8 | 1104567823 | Brenda    | Jaramillo  | 2000-01-29       | brenda.jaramillo@antares.edu    | 0971234589 | Loja       |          4 |
|            10 | 1003698521 | Fernanda  | Imbaquingo | 1999-05-07       | fernanda.imbaquingo@antares.edu | 0995874123 | Ibarra     |          1 |
+---------------+------------+-----------+------------+------------------+---------------------------------+------------+------------+------------+
```

### Consulta 3: mostrar los estudiantes de una carrera especifica.

```sql
SELECT e.*
FROM estudiantes AS e
INNER JOIN carreras AS c ON c.id_carrera = e.id_carrera
WHERE c.nombre = 'Desarrollo de software';
```

```
+---------------+------------+----------+------------+------------------+---------------------------------+------------+-----------+------------+
| id_estudiante | cedula     | nombres  | apellidos  | fecha_nacimiento | correo                          | telefono   | ciudad    | id_carrera |
+---------------+------------+----------+------------+------------------+---------------------------------+------------+-----------+------------+
|             1 | 0923451871 | Andres   | Pilataxi   | 2004-02-18       | andres.pilataxi@antares.edu     | 0991234567 | Quito     |          1 |
|             2 | 0918273645 | Camila   | Verdugo    | 2003-11-05       | camila.verdugo@antares.edu      | 0987654321 | Guayaquil |          1 |
|             3 | 1725489630 | Joel     | Naranjo    | 2009-06-30       | joel.naranjo@antares.edu        | 0965432178 | Ambato    |          1 |
|            10 | 1003698521 | Fernanda | Imbaquingo | 1999-05-07       | fernanda.imbaquingo@antares.edu | 0995874123 | Ibarra    |          1 |
+---------------+------------+----------+------------+------------------+---------------------------------+------------+-----------+------------+
```


## Ejercicio 5 - Torneo de eSports

Base de datos: `ej5_liga_andina_esports`  ·  Script: `sql/05_torneo_esports.sql`

### Consulta 1: mostrar los jugadores del equipo "Dragones Digitales".

```sql
SELECT j.*
FROM jugadores AS j
INNER JOIN equipos AS e ON e.id_equipo = j.id_equipo
WHERE e.nombre = 'Dragones Digitales';
```

```
+------------+------------+-------------------+-----------+------+-----------+
| id_jugador | nick       | nombre_real       | rol       | edad | id_equipo |
+------------+------------+-------------------+-----------+------+-----------+
|          1 | drk_flame  | Alejandro Salazar | Carry     |   22 |         1 |
|          2 | valkiria99 | Michelle Andrade  | Support   |   24 |         1 |
|          3 | n0ct4      | Bryan Montenegro  | Mid laner |   20 |         1 |
|          4 | ceniza     | Paola Trujillo    | Offlaner  |   23 |         1 |
|          5 | ironpaw    | Steven Ochoa      | Jungla    |   21 |         1 |
+------------+------------+-------------------+-----------+------+-----------+
```

### Consulta 2: listar los torneos programados para este anio.

```sql
SELECT *
FROM torneos
WHERE YEAR(fecha_inicio) = YEAR(CURDATE());
```

```
+-----------+-----------------+----------+--------------+------------+-----------+------------+
| id_torneo | nombre          | juego    | fecha_inicio | fecha_fin  | sede      | premio_usd |
+-----------+-----------------+----------+--------------+------------+-----------+------------+
|         2 | Clasico Digital | Valorant | 2026-03-05   | 2026-03-15 | Guayaquil |   12000.00 |
|         3 | Altura Open     | Dota 2   | 2026-08-12   | 2026-08-24 | Cuenca    |   15000.00 |
|         4 | Costa Showdown  | Valorant | 2026-11-07   | 2026-11-16 | Manta     |    9500.00 |
+-----------+-----------------+----------+--------------+------------+-----------+------------+
```

### Consulta 3: contar cuantos jugadores tiene cada equipo.

```sql
SELECT e.nombre AS equipo, COUNT(j.id_jugador) AS total_jugadores
FROM equipos AS e
LEFT JOIN jugadores AS j ON j.id_equipo = e.id_equipo
GROUP BY e.id_equipo, e.nombre;
```

```
+--------------------+-----------------+
| equipo             | total_jugadores |
+--------------------+-----------------+
| Dragones Digitales |               5 |
| Pumas Binarios     |               3 |
| Kondor Esports     |               3 |
| Neon Manabi        |               2 |
+--------------------+-----------------+
```

### Consulta 4: mostrar que equipos participan en cada torneo.

```sql
SELECT t.nombre AS torneo, e.nombre AS equipo
FROM torneos AS t
INNER JOIN torneo_equipo AS te ON te.id_torneo = t.id_torneo
INNER JOIN equipos AS e        ON e.id_equipo  = te.id_equipo;
```

```
+----------------------+--------------------+
| torneo               | equipo             |
+----------------------+--------------------+
| Copa Andina Invierno | Dragones Digitales |
| Clasico Digital      | Dragones Digitales |
| Altura Open          | Dragones Digitales |
| Liga Sur Masters     | Dragones Digitales |
| Copa Andina Invierno | Kondor Esports     |
| Altura Open          | Kondor Esports     |
| Liga Sur Masters     | Kondor Esports     |
| Clasico Digital      | Neon Manabi        |
| Costa Showdown       | Neon Manabi        |
| Clasico Digital      | Pumas Binarios     |
| Altura Open          | Pumas Binarios     |
| Costa Showdown       | Pumas Binarios     |
+----------------------+--------------------+
```

