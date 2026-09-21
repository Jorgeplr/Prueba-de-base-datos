# Resultados verificados de las consultas

Salida real obtenida al ejecutar los scripts de la carpeta `sql/` sobre un
servidor MySQL/MariaDB. Sirve como comprobacion de la recomendacion 5 del
enunciado ("verifica que todas las consultas funcionen correctamente antes
de entregar") y como referencia para comparar con tus capturas de HeidiSQL.

- Fecha de ejecucion: 2026-09-21
- Servidor de prueba: MariaDB 10.11.14-MariaDB-0ubuntu0.24.04.1 (compatible con MySQL 8 para estas sentencias)

> Nota: las consultas que usan `CURDATE()` (edad de los estudiantes y torneos
> del anio en curso) dependen de la fecha en que se ejecuten.


## Ejercicio 1 - Administracion de productos

Base de datos: `ej1_taller_prisma3d`  ·  Script: `sql/01_productos.sql`

### Consulta 1: mostrar todos los productos.

```sql
SELECT *
FROM productos
ORDER BY id_producto;
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
SELECT id_producto, codigo, nombre, categoria, precio, stock
FROM productos
WHERE precio > 50
ORDER BY precio DESC;
```

```
+-------------+-------------+---------------------------------+-------------+--------+-------+
| id_producto | codigo      | nombre                          | categoria   | precio | stock |
+-------------+-------------+---------------------------------+-------------+--------+-------+
|          11 | IMP-FDM-01  | Impresora FDM 220x220x250mm     | Equipos     | 399.99 |     5 |
|          10 | LAV-UV-02   | Estacion de lavado y curado UV  | Equipos     | 210.00 |     3 |
|           5 | RES-DEN-TRA | Resina dental translucida 500ml | Resinas     | 145.00 |     4 |
|           8 | EXT-DIR-V6  | Extrusor directo V6 completo    | Repuestos   |  89.90 |     6 |
|          13 | SEC-FIL-01  | Secador de filamento 2 bobinas  | Accesorios  |  76.40 |     8 |
|          15 | ALC-ISO-05  | Alcohol isopropilico 99% 5L     | Consumibles |  58.30 |     2 |
|           4 | RES-STD-GRI | Resina estandar gris 1L         | Resinas     |  52.00 |    12 |
+-------------+-------------+---------------------------------+-------------+--------+-------+
```

### Consulta 3: mostrar los productos que tengan stock menor a 10.

```sql
SELECT id_producto, codigo, nombre, categoria, stock, precio
FROM productos
WHERE stock < 10
ORDER BY stock ASC;
```

```
+-------------+-------------+---------------------------------+-------------+-------+--------+
| id_producto | codigo      | nombre                          | categoria   | stock | precio |
+-------------+-------------+---------------------------------+-------------+-------+--------+
|          15 | ALC-ISO-05  | Alcohol isopropilico 99% 5L     | Consumibles |     2 |  58.30 |
|          10 | LAV-UV-02   | Estacion de lavado y curado UV  | Equipos     |     3 | 210.00 |
|           5 | RES-DEN-TRA | Resina dental translucida 500ml | Resinas     |     4 | 145.00 |
|          11 | IMP-FDM-01  | Impresora FDM 220x220x250mm     | Equipos     |     5 | 399.99 |
|           8 | EXT-DIR-V6  | Extrusor directo V6 completo    | Repuestos   |     6 |  89.90 |
|           3 | FIL-ABS-ROJ | Filamento ABS 1.75mm rojo 1kg   | Filamentos  |     7 |  28.75 |
|          13 | SEC-FIL-01  | Secador de filamento 2 bobinas  | Accesorios  |     8 |  76.40 |
|           7 | BOQ-040-END | Boquilla endurecida 0.4mm       | Repuestos   |     9 |  18.90 |
+-------------+-------------+---------------------------------+-------------+-------+--------+
```


## Ejercicio 2 - Estudio de videojuegos

Base de datos: `ej2_nube_roja_studio`  ·  Script: `sql/02_estudio_videojuegos.sql`

### Consulta 1: mostrar todos los desarrolladores asignados al proyecto "Space Adventure".

```sql
SELECT d.id_desarrollador,
       CONCAT(d.nombres, ' ', d.apellidos) AS desarrollador,
       d.rol,
       pd.horas_semana,
       p.nombre AS proyecto
FROM desarrolladores AS d
INNER JOIN proyecto_desarrollador AS pd ON pd.id_desarrollador = d.id_desarrollador
INNER JOIN proyectos AS p              ON p.id_proyecto        = pd.id_proyecto
WHERE p.nombre = 'Space Adventure'
ORDER BY d.apellidos;
```

```
+------------------+-----------------+-----------------------+--------------+-----------------+
| id_desarrollador | desarrollador   | rol                   | horas_semana | proyecto        |
+------------------+-----------------+-----------------------+--------------+-----------------+
|                1 | Mariela Cordova | Programadora gameplay |           40 | Space Adventure |
|                4 | Damian Loor     | Programador de motor  |           40 | Space Adventure |
|                6 | Tomas Quispe    | QA tester             |           20 | Space Adventure |
|                2 | Ignacio Vasquez | Artista 3D            |           30 | Space Adventure |
+------------------+-----------------+-----------------------+--------------+-----------------+
```

### Consulta 2: listar todas las tareas pendientes.

```sql
SELECT t.id_tarea,
       t.titulo,
       t.prioridad,
       t.fecha_limite,
       p.nombre AS proyecto,
       CONCAT(d.nombres, ' ', d.apellidos) AS responsable
FROM tareas AS t
INNER JOIN proyectos AS p       ON p.id_proyecto        = t.id_proyecto
INNER JOIN desarrolladores AS d ON d.id_desarrollador   = t.id_desarrollador
WHERE t.estado = 'pendiente'
ORDER BY t.fecha_limite;
```

```
+----------+--------------------------------------+-----------+--------------+------------------+-----------------+
| id_tarea | titulo                               | prioridad | fecha_limite | proyecto         | responsable     |
+----------+--------------------------------------+-----------+--------------+------------------+-----------------+
|        9 | Ajustar dificultad de los faroles    | media     | 2026-09-28   | Duelo de Faroles | Sofia Benitez   |
|        4 | Optimizar carga de escenas           | alta      | 2026-09-30   | Space Adventure  | Damian Loor     |
|        2 | Corregir colisiones en la nave madre | alta      | 2026-10-02   | Space Adventure  | Mariela Cordova |
|        5 | Plan de pruebas del nivel 3          | media     | 2026-10-20   | Space Adventure  | Tomas Quispe    |
|        7 | Grabar ambiente de lluvia            | baja      | 2026-11-18   | Raices de Niebla | Renata Aguirre  |
+----------+--------------------------------------+-----------+--------------+------------------+-----------------+
```

### Consulta 3: contar cuantas tareas tiene asignado cada desarrollador.

```sql
SELECT CONCAT(d.nombres, ' ', d.apellidos) AS desarrollador,
       d.rol,
       COUNT(t.id_tarea) AS total_tareas
FROM desarrolladores AS d
LEFT JOIN tareas AS t ON t.id_desarrollador = d.id_desarrollador
GROUP BY d.id_desarrollador, desarrollador, d.rol
ORDER BY total_tareas DESC, desarrollador;
```

```
+-----------------+-----------------------+--------------+
| desarrollador   | rol                   | total_tareas |
+-----------------+-----------------------+--------------+
| Mariela Cordova | Programadora gameplay |            3 |
| Renata Aguirre  | Disenadora de sonido  |            2 |
| Sofia Benitez   | Disenadora de niveles |            2 |
| Damian Loor     | Programador de motor  |            1 |
| Ignacio Vasquez | Artista 3D            |            1 |
| Tomas Quispe    | QA tester             |            1 |
+-----------------+-----------------------+--------------+
```

### Consulta 4: mostrar los proyectos y la cantidad de desarrolladores que participan en cada uno.

```sql
SELECT p.id_proyecto,
       p.nombre AS proyecto,
       p.plataforma,
       p.estado,
       COUNT(pd.id_desarrollador) AS total_desarrolladores
FROM proyectos AS p
LEFT JOIN proyecto_desarrollador AS pd ON pd.id_proyecto = p.id_proyecto
GROUP BY p.id_proyecto, p.nombre, p.plataforma, p.estado
ORDER BY total_desarrolladores DESC;
```

```
+-------------+------------------+-----------------+---------------+-----------------------+
| id_proyecto | proyecto         | plataforma      | estado        | total_desarrolladores |
+-------------+------------------+-----------------+---------------+-----------------------+
|           1 | Space Adventure  | PC / Steam      | desarrollo    |                     4 |
|           3 | Duelo de Faroles | Movil Android   | pruebas       |                     2 |
|           2 | Raices de Niebla | Nintendo Switch | planificacion |                     2 |
+-------------+------------------+-----------------+---------------+-----------------------+
```


## Ejercicio 3 - Biblioteca multimedia

Base de datos: `ej3_sala_lumiere`  ·  Script: `sql/03_biblioteca_multimedia.sql`

### Consulta 1: mostrar todas las peliculas (con el director que las dirigio).

```sql
SELECT p.id_pelicula,
       p.titulo,
       p.genero,
       p.anio_estreno,
       p.duracion_minutos,
       CONCAT(d.nombres, ' ', d.apellidos) AS director
FROM peliculas AS p
INNER JOIN directores AS d ON d.id_director = p.id_director
ORDER BY p.titulo;
```

```
+-------------+----------------------------+-----------------+--------------+------------------+------------------+
| id_pelicula | titulo                     | genero          | anio_estreno | duracion_minutos | director         |
+-------------+----------------------------+-----------------+--------------+------------------+------------------+
|           2 | Cenizas de sal             | Drama           |         2022 |               98 | Helena Matamoros |
|           1 | El ultimo tren a Latacunga | Drama           |         2019 |              112 | Helena Matamoros |
|           9 | Invierno en Odesa          | Drama           |         2024 |              124 | Nadia Kirilenko  |
|           5 | Kilometro cero             | Accion          |         2018 |              105 | Teodoro Rivas    |
|           7 | La casa de las abuelas     | Comedia         |         2020 |               92 | Teodoro Rivas    |
|           3 | La ruta del condor         | Documental      |         2021 |               84 | Bruno Salcedo    |
|           6 | Lagos de neon              | Ciencia ficcion |         2024 |              118 | Amara Okonkwo    |
|          11 | Manifiesto de papel        | Documental      |         2026 |               78 | Helena Matamoros |
|           4 | Nieve sobre el desierto    | Ciencia ficcion |         2023 |              131 | Bruno Salcedo    |
|           8 | Ojos de tormenta           | Suspenso        |         2025 |              107 | Amara Okonkwo    |
|          12 | Orbita baja                | Ciencia ficcion |         2020 |              140 | Bruno Salcedo    |
|          10 | Raiz cuadrada del miedo    | Suspenso        |         2016 |               96 | Nadia Kirilenko  |
+-------------+----------------------------+-----------------+--------------+------------------+------------------+
```

### Consulta 2: mostrar las peliculas estrenadas despues de 2020.

```sql
SELECT p.id_pelicula,
       p.titulo,
       p.genero,
       p.anio_estreno,
       CONCAT(d.nombres, ' ', d.apellidos) AS director
FROM peliculas AS p
INNER JOIN directores AS d ON d.id_director = p.id_director
WHERE p.anio_estreno > 2020
ORDER BY p.anio_estreno DESC, p.titulo;
```

```
+-------------+-------------------------+-----------------+--------------+------------------+
| id_pelicula | titulo                  | genero          | anio_estreno | director         |
+-------------+-------------------------+-----------------+--------------+------------------+
|          11 | Manifiesto de papel     | Documental      |         2026 | Helena Matamoros |
|           8 | Ojos de tormenta        | Suspenso        |         2025 | Amara Okonkwo    |
|           9 | Invierno en Odesa       | Drama           |         2024 | Nadia Kirilenko  |
|           6 | Lagos de neon           | Ciencia ficcion |         2024 | Amara Okonkwo    |
|           4 | Nieve sobre el desierto | Ciencia ficcion |         2023 | Bruno Salcedo    |
|           2 | Cenizas de sal          | Drama           |         2022 | Helena Matamoros |
|           3 | La ruta del condor      | Documental      |         2021 | Bruno Salcedo    |
+-------------+-------------------------+-----------------+--------------+------------------+
```

### Consulta 3: mostrar las peliculas de un genero determinado (Ciencia ficcion).

```sql
SELECT p.id_pelicula,
       p.titulo,
       p.anio_estreno,
       p.duracion_minutos,
       p.copias_disponibles,
       CONCAT(d.nombres, ' ', d.apellidos) AS director
FROM peliculas AS p
INNER JOIN directores AS d ON d.id_director = p.id_director
WHERE p.genero = 'Ciencia ficcion'
ORDER BY p.anio_estreno DESC;
```

```
+-------------+-------------------------+--------------+------------------+--------------------+---------------+
| id_pelicula | titulo                  | anio_estreno | duracion_minutos | copias_disponibles | director      |
+-------------+-------------------------+--------------+------------------+--------------------+---------------+
|           6 | Lagos de neon           |         2024 |              118 |                  1 | Amara Okonkwo |
|           4 | Nieve sobre el desierto |         2023 |              131 |                  2 | Bruno Salcedo |
|          12 | Orbita baja             |         2020 |              140 |                  2 | Bruno Salcedo |
+-------------+-------------------------+--------------+------------------+--------------------+---------------+
```


## Ejercicio 4 - Gestion de estudiantes

Base de datos: `ej4_instituto_antares`  ·  Script: `sql/04_gestion_estudiantes.sql`

### Consulta 1: mostrar todos los estudiantes (con su carrera).

```sql
SELECT e.id_estudiante,
       e.cedula,
       CONCAT(e.apellidos, ' ', e.nombres) AS estudiante,
       e.fecha_nacimiento,
       e.ciudad,
       c.nombre AS carrera
FROM estudiantes AS e
INNER JOIN carreras AS c ON c.id_carrera = e.id_carrera
ORDER BY e.apellidos;
```

```
+---------------+------------+---------------------+------------------+------------+----------------------------+
| id_estudiante | cedula     | estudiante          | fecha_nacimiento | ciudad     | carrera                    |
+---------------+------------+---------------------+------------------+------------+----------------------------+
|             7 | 0801234567 | Caicedo Kevin       | 2005-08-21       | Esmeraldas | Redes y telecomunicaciones |
|             5 | 0604512398 | Chimbo Mateo        | 2008-12-24       | Riobamba   | Diseno multimedia          |
|            10 | 1003698521 | Imbaquingo Fernanda | 1999-05-07       | Ibarra     | Desarrollo de software     |
|             8 | 1104567823 | Jaramillo Brenda    | 2000-01-29       | Loja       | Marketing digital          |
|             3 | 1725489630 | Naranjo Joel        | 2009-06-30       | Ambato     | Desarrollo de software     |
|             1 | 0923451871 | Pilataxi Andres     | 2004-02-18       | Quito      | Desarrollo de software     |
|             4 | 1712398745 | Sarmiento Valentina | 2002-09-12       | Cuenca     | Diseno multimedia          |
|             9 | 0703215698 | Tandazo Ismael      | 2007-10-16       | Machala    | Marketing digital          |
|             2 | 0918273645 | Verdugo Camila      | 2003-11-05       | Guayaquil  | Desarrollo de software     |
|             6 | 1309871245 | Zambrano Dayana     | 2001-04-03       | Manta      | Redes y telecomunicaciones |
+---------------+------------+---------------------+------------------+------------+----------------------------+
```

### Consulta 2: mostrar los estudiantes mayores de 18 anios.

```sql
SELECT e.id_estudiante,
       CONCAT(e.apellidos, ' ', e.nombres) AS estudiante,
       e.fecha_nacimiento,
       TIMESTAMPDIFF(YEAR, e.fecha_nacimiento, CURDATE()) AS edad,
       c.nombre AS carrera
FROM estudiantes AS e
INNER JOIN carreras AS c ON c.id_carrera = e.id_carrera
WHERE TIMESTAMPDIFF(YEAR, e.fecha_nacimiento, CURDATE()) > 18
ORDER BY edad DESC;
```

```
+---------------+---------------------+------------------+------+----------------------------+
| id_estudiante | estudiante          | fecha_nacimiento | edad | carrera                    |
+---------------+---------------------+------------------+------+----------------------------+
|            10 | Imbaquingo Fernanda | 1999-05-07       |   27 | Desarrollo de software     |
|             8 | Jaramillo Brenda    | 2000-01-29       |   26 | Marketing digital          |
|             6 | Zambrano Dayana     | 2001-04-03       |   25 | Redes y telecomunicaciones |
|             4 | Sarmiento Valentina | 2002-09-12       |   24 | Diseno multimedia          |
|             1 | Pilataxi Andres     | 2004-02-18       |   22 | Desarrollo de software     |
|             2 | Verdugo Camila      | 2003-11-05       |   22 | Desarrollo de software     |
|             7 | Caicedo Kevin       | 2005-08-21       |   21 | Redes y telecomunicaciones |
+---------------+---------------------+------------------+------+----------------------------+
```

### Consulta 3: mostrar los estudiantes de una carrera especifica.

```sql
SELECT e.id_estudiante,
       e.cedula,
       CONCAT(e.apellidos, ' ', e.nombres) AS estudiante,
       e.correo,
       c.nombre    AS carrera,
       c.modalidad
FROM estudiantes AS e
INNER JOIN carreras AS c ON c.id_carrera = e.id_carrera
WHERE c.nombre = 'Desarrollo de software'
ORDER BY e.apellidos;
```

```
+---------------+------------+---------------------+---------------------------------+------------------------+------------+
| id_estudiante | cedula     | estudiante          | correo                          | carrera                | modalidad  |
+---------------+------------+---------------------+---------------------------------+------------------------+------------+
|            10 | 1003698521 | Imbaquingo Fernanda | fernanda.imbaquingo@antares.edu | Desarrollo de software | presencial |
|             3 | 1725489630 | Naranjo Joel        | joel.naranjo@antares.edu        | Desarrollo de software | presencial |
|             1 | 0923451871 | Pilataxi Andres     | andres.pilataxi@antares.edu     | Desarrollo de software | presencial |
|             2 | 0918273645 | Verdugo Camila      | camila.verdugo@antares.edu      | Desarrollo de software | presencial |
+---------------+------------+---------------------+---------------------------------+------------------------+------------+
```


## Ejercicio 5 - Torneo de eSports

Base de datos: `ej5_liga_andina_esports`  ·  Script: `sql/05_torneo_esports.sql`

### Consulta 1: mostrar los jugadores del equipo "Dragones Digitales".

```sql
SELECT j.id_jugador,
       j.nick,
       j.nombre_real,
       j.rol,
       j.edad,
       e.nombre AS equipo
FROM jugadores AS j
INNER JOIN equipos AS e ON e.id_equipo = j.id_equipo
WHERE e.nombre = 'Dragones Digitales'
ORDER BY j.nick;
```

```
+------------+------------+-------------------+-----------+------+--------------------+
| id_jugador | nick       | nombre_real       | rol       | edad | equipo             |
+------------+------------+-------------------+-----------+------+--------------------+
|          4 | ceniza     | Paola Trujillo    | Offlaner  |   23 | Dragones Digitales |
|          1 | drk_flame  | Alejandro Salazar | Carry     |   22 | Dragones Digitales |
|          5 | ironpaw    | Steven Ochoa      | Jungla    |   21 | Dragones Digitales |
|          3 | n0ct4      | Bryan Montenegro  | Mid laner |   20 | Dragones Digitales |
|          2 | valkiria99 | Michelle Andrade  | Support   |   24 | Dragones Digitales |
+------------+------------+-------------------+-----------+------+--------------------+
```

### Consulta 2: listar los torneos programados para este anio.

```sql
SELECT id_torneo,
       nombre,
       juego,
       fecha_inicio,
       fecha_fin,
       sede,
       premio_usd
FROM torneos
WHERE YEAR(fecha_inicio) = YEAR(CURDATE())
ORDER BY fecha_inicio;
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
SELECT e.id_equipo,
       e.nombre AS equipo,
       e.ciudad,
       COUNT(j.id_jugador) AS total_jugadores
FROM equipos AS e
LEFT JOIN jugadores AS j ON j.id_equipo = e.id_equipo
GROUP BY e.id_equipo, e.nombre, e.ciudad
ORDER BY total_jugadores DESC, equipo;
```

```
+-----------+--------------------+-----------+-----------------+
| id_equipo | equipo             | ciudad    | total_jugadores |
+-----------+--------------------+-----------+-----------------+
|         1 | Dragones Digitales | Quito     |               5 |
|         3 | Kondor Esports     | Cuenca    |               3 |
|         2 | Pumas Binarios     | Guayaquil |               3 |
|         4 | Neon Manabi        | Manta     |               2 |
+-----------+--------------------+-----------+-----------------+
```

### Consulta 4: mostrar que equipos participan en cada torneo.

```sql
SELECT t.nombre   AS torneo,
       t.juego,
       t.fecha_inicio,
       e.nombre   AS equipo,
       te.grupo,
       te.posicion_final
FROM torneos AS t
INNER JOIN torneo_equipo AS te ON te.id_torneo = t.id_torneo
INNER JOIN equipos AS e        ON e.id_equipo  = te.id_equipo
ORDER BY t.fecha_inicio, te.grupo, e.nombre;
```

```
+----------------------+-------------------+--------------+--------------------+-------+----------------+
| torneo               | juego             | fecha_inicio | equipo             | grupo | posicion_final |
+----------------------+-------------------+--------------+--------------------+-------+----------------+
| Copa Andina Invierno | League of Legends | 2025-06-10   | Dragones Digitales | A     |              2 |
| Copa Andina Invierno | League of Legends | 2025-06-10   | Kondor Esports     | A     |              1 |
| Clasico Digital      | Valorant          | 2026-03-05   | Dragones Digitales | A     |              1 |
| Clasico Digital      | Valorant          | 2026-03-05   | Pumas Binarios     | A     |              3 |
| Clasico Digital      | Valorant          | 2026-03-05   | Neon Manabi        | B     |              2 |
| Altura Open          | Dota 2            | 2026-08-12   | Kondor Esports     | A     |              2 |
| Altura Open          | Dota 2            | 2026-08-12   | Pumas Binarios     | A     |              1 |
| Altura Open          | Dota 2            | 2026-08-12   | Dragones Digitales | B     |              4 |
| Costa Showdown       | Valorant          | 2026-11-07   | Neon Manabi        | A     |           NULL |
| Costa Showdown       | Valorant          | 2026-11-07   | Pumas Binarios     | A     |           NULL |
| Liga Sur Masters     | League of Legends | 2027-02-01   | Dragones Digitales | A     |           NULL |
| Liga Sur Masters     | League of Legends | 2027-02-01   | Kondor Esports     | B     |           NULL |
+----------------------+-------------------+--------------+--------------------+-------+----------------+
```

### Variante compacta de la consulta 4: un renglon por torneo con la lista de equipos.

```sql
SELECT t.nombre AS torneo,
       t.juego,
       COUNT(te.id_equipo)              AS total_equipos,
       GROUP_CONCAT(e.nombre ORDER BY e.nombre SEPARATOR ', ') AS equipos_participantes
FROM torneos AS t
LEFT JOIN torneo_equipo AS te ON te.id_torneo = t.id_torneo
LEFT JOIN equipos AS e        ON e.id_equipo  = te.id_equipo
GROUP BY t.id_torneo, t.nombre, t.juego
ORDER BY t.fecha_inicio;
```

```
+----------------------+-------------------+---------------+----------------------------------------------------+
| torneo               | juego             | total_equipos | equipos_participantes                              |
+----------------------+-------------------+---------------+----------------------------------------------------+
| Copa Andina Invierno | League of Legends |             2 | Dragones Digitales, Kondor Esports                 |
| Clasico Digital      | Valorant          |             3 | Dragones Digitales, Neon Manabi, Pumas Binarios    |
| Altura Open          | Dota 2            |             3 | Dragones Digitales, Kondor Esports, Pumas Binarios |
| Costa Showdown       | Valorant          |             2 | Neon Manabi, Pumas Binarios                        |
| Liga Sur Masters     | League of Legends |             2 | Dragones Digitales, Kondor Esports                 |
+----------------------+-------------------+---------------+----------------------------------------------------+
```

