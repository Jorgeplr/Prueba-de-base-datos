/* ============================================================================
   TAREA 1 - BASES DE DATOS  -  SCRIPT COMPLETO (EJERCICIOS 1 AL 5)
   ----------------------------------------------------------------------------
   Asignatura : Lenguaje informatico para desarrollo de productos
   Unidad 2   : Introduccion a bases de datos para medios digitales
   Motor      : MySQL 8 / MariaDB      Cliente: HeidiSQL

   Este archivo reune los cinco ejercicios en un solo script. Cada ejercicio
   crea su propia base de datos, por lo que puede ejecutarse completo de una
   sola vez (en HeidiSQL: F9 o "Ejecutar SQL"), o abrir el archivo individual
   de cada ejercicio dentro de la carpeta sql/.

   ATENCION: cada bloque inicia con DROP DATABASE IF EXISTS, es decir, vuelve a
   crear la base desde cero cada vez que se ejecuta.

   Bases de datos que se crean:
     ej1_taller_prisma3d       -> Ejercicio 1: administracion de productos
     ej2_nube_roja_studio      -> Ejercicio 2: estudio de videojuegos
     ej3_sala_lumiere          -> Ejercicio 3: biblioteca multimedia
     ej4_instituto_antares     -> Ejercicio 4: gestion de estudiantes
     ej5_liga_andina_esports   -> Ejercicio 5: torneo de eSports
   ============================================================================ */


-- ####################################################################
-- ###  ORIGEN: sql/01_productos.sql
-- ####################################################################

/* ============================================================================
   TAREA 1 - BASES DE DATOS  |  EJERCICIO 1: ADMINISTRACION DE PRODUCTOS
   ----------------------------------------------------------------------------
   Caso: "Taller Prisma 3D", una empresa que comercializa insumos y repuestos
         para impresion 3D, necesita administrar los productos que vende.
   Motor: MySQL 8 / MariaDB  -  Cliente: HeidiSQL
   ============================================================================ */

-- ----------------------------------------------------------------------------
-- 1) DDL: creacion de la base de datos
-- ----------------------------------------------------------------------------
DROP DATABASE IF EXISTS ej1_taller_prisma3d;
CREATE DATABASE ej1_taller_prisma3d
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE ej1_taller_prisma3d;

-- ----------------------------------------------------------------------------
-- 2) DDL: creacion de la tabla
--    Entidad unica: producto (el caso no exige relaciones).
-- ----------------------------------------------------------------------------
CREATE TABLE productos (
    id_producto     INT           NOT NULL AUTO_INCREMENT,
    codigo          VARCHAR(20)   NOT NULL,
    nombre          VARCHAR(80)   NOT NULL,
    categoria       VARCHAR(40)   NOT NULL,
    precio          DECIMAL(10,2) NOT NULL,
    stock           INT           NOT NULL DEFAULT 0,
    fecha_ingreso   DATE          NOT NULL,
    PRIMARY KEY (id_producto),
    UNIQUE KEY uq_productos_codigo (codigo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- 3) DML: carga de datos de prueba
-- ----------------------------------------------------------------------------
INSERT INTO productos (codigo, nombre, categoria, precio, stock, fecha_ingreso) VALUES
('FIL-PLA-BLA', 'Filamento PLA 1.75mm blanco 1kg',      'Filamentos',  24.90,  35, '2026-01-15'),
('FIL-PET-NEG', 'Filamento PETG 1.75mm negro 1kg',      'Filamentos',  31.50,  18, '2026-01-15'),
('FIL-ABS-ROJ', 'Filamento ABS 1.75mm rojo 1kg',        'Filamentos',  28.75,   7, '2026-02-03'),
('RES-STD-GRI', 'Resina estandar gris 1L',              'Resinas',     52.00,  12, '2026-02-03'),
('RES-DEN-TRA', 'Resina dental translucida 500ml',      'Resinas',    145.00,   4, '2026-02-20'),
('BOQ-060-LAT', 'Boquilla de laton 0.6mm',              'Repuestos',    4.20,  80, '2026-03-01'),
('BOQ-040-END', 'Boquilla endurecida 0.4mm',            'Repuestos',   18.90,   9, '2026-03-01'),
('EXT-DIR-V6',  'Extrusor directo V6 completo',         'Repuestos',   89.90,   6, '2026-03-18'),
('PLA-PEI-220', 'Placa flexible PEI 220x220mm',         'Accesorios',  34.00,  22, '2026-04-05'),
('LAV-UV-02',   'Estacion de lavado y curado UV',       'Equipos',    210.00,   3, '2026-04-05'),
('IMP-FDM-01',  'Impresora FDM 220x220x250mm',          'Equipos',    399.99,   5, '2026-05-10'),
('HER-ESP-KIT', 'Kit de esputulas y pinzas',            'Accesorios',   12.50,  40, '2026-05-10'),
('SEC-FIL-01',  'Secador de filamento 2 bobinas',       'Accesorios',   76.40,   8, '2026-06-02'),
('ADH-LAC-01',  'Laca adherente para cama 400ml',       'Consumibles',  9.80,  25, '2026-06-02'),
('ALC-ISO-05',  'Alcohol isopropilico 99% 5L',          'Consumibles', 58.30,   2, '2026-06-20');

/* ============================================================================
   4) CONSULTAS SOLICITADAS
   ============================================================================ */

-- Consulta 1: mostrar todos los productos.
SELECT *
FROM productos
ORDER BY id_producto;

-- Consulta 2: mostrar los productos cuyo precio sea mayor a $50.
SELECT id_producto, codigo, nombre, categoria, precio, stock
FROM productos
WHERE precio > 50
ORDER BY precio DESC;

-- Consulta 3: mostrar los productos que tengan stock menor a 10.
SELECT id_producto, codigo, nombre, categoria, stock, precio
FROM productos
WHERE stock < 10
ORDER BY stock ASC;


-- ####################################################################
-- ###  ORIGEN: sql/02_estudio_videojuegos.sql
-- ####################################################################

/* ============================================================================
   TAREA 1 - BASES DE DATOS  |  EJERCICIO 2: ESTUDIO DE VIDEOJUEGOS
   ----------------------------------------------------------------------------
   Caso: "Nube Roja Studio" necesita registrar sus desarrolladores, los
         proyectos en los que trabajan y las tareas asignadas, para saber quien
         participa en cada proyecto y controlar el avance del trabajo.
   Relaciones:
     - proyectos  N:M  desarrolladores  -> tabla puente proyecto_desarrollador
     - tareas      N:1  proyectos
     - tareas      N:1  desarrolladores
   ============================================================================ */

-- ----------------------------------------------------------------------------
-- 1) DDL: base de datos
-- ----------------------------------------------------------------------------
DROP DATABASE IF EXISTS ej2_nube_roja_studio;
CREATE DATABASE ej2_nube_roja_studio
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE ej2_nube_roja_studio;

-- ----------------------------------------------------------------------------
-- 2) DDL: tablas
-- ----------------------------------------------------------------------------
CREATE TABLE desarrolladores (
    id_desarrollador INT         NOT NULL AUTO_INCREMENT,
    nombres          VARCHAR(60) NOT NULL,
    apellidos        VARCHAR(60) NOT NULL,
    rol              VARCHAR(40) NOT NULL,
    correo           VARCHAR(90) NOT NULL,
    fecha_ingreso    DATE        NOT NULL,
    PRIMARY KEY (id_desarrollador),
    UNIQUE KEY uq_desarrolladores_correo (correo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE proyectos (
    id_proyecto   INT         NOT NULL AUTO_INCREMENT,
    nombre        VARCHAR(80) NOT NULL,
    plataforma    VARCHAR(40) NOT NULL,
    fecha_inicio  DATE        NOT NULL,
    estado        ENUM('planificacion','desarrollo','pruebas','publicado') NOT NULL DEFAULT 'desarrollo',
    PRIMARY KEY (id_proyecto),
    UNIQUE KEY uq_proyectos_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla puente: resuelve la relacion muchos a muchos.
CREATE TABLE proyecto_desarrollador (
    id_proyecto      INT NOT NULL,
    id_desarrollador INT NOT NULL,
    horas_semana     INT NOT NULL DEFAULT 40,
    PRIMARY KEY (id_proyecto, id_desarrollador),
    CONSTRAINT fk_pd_proyecto
        FOREIGN KEY (id_proyecto) REFERENCES proyectos (id_proyecto)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pd_desarrollador
        FOREIGN KEY (id_desarrollador) REFERENCES desarrolladores (id_desarrollador)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tareas (
    id_tarea         INT          NOT NULL AUTO_INCREMENT,
    titulo           VARCHAR(120) NOT NULL,
    estado           ENUM('pendiente','en_progreso','completada') NOT NULL DEFAULT 'pendiente',
    prioridad        ENUM('baja','media','alta') NOT NULL DEFAULT 'media',
    fecha_limite     DATE         NOT NULL,
    id_proyecto      INT          NOT NULL,
    id_desarrollador INT          NOT NULL,
    PRIMARY KEY (id_tarea),
    CONSTRAINT fk_tareas_proyecto
        FOREIGN KEY (id_proyecto) REFERENCES proyectos (id_proyecto)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_tareas_desarrollador
        FOREIGN KEY (id_desarrollador) REFERENCES desarrolladores (id_desarrollador)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- 3) DML: datos de prueba
-- ----------------------------------------------------------------------------
INSERT INTO desarrolladores (nombres, apellidos, rol, correo, fecha_ingreso) VALUES
('Mariela', 'Cordova',  'Programadora gameplay', 'mariela.cordova@nuberoja.dev', '2023-03-06'),
('Ignacio', 'Vasquez',  'Artista 3D',            'ignacio.vasquez@nuberoja.dev', '2023-07-17'),
('Sofia',   'Benitez',  'Disenadora de niveles', 'sofia.benitez@nuberoja.dev',   '2024-01-08'),
('Damian',  'Loor',     'Programador de motor',  'damian.loor@nuberoja.dev',     '2024-05-20'),
('Renata',  'Aguirre',  'Disenadora de sonido',  'renata.aguirre@nuberoja.dev',  '2025-02-10'),
('Tomas',   'Quispe',   'QA tester',             'tomas.quispe@nuberoja.dev',    '2025-09-01');

INSERT INTO proyectos (nombre, plataforma, fecha_inicio, estado) VALUES
('Space Adventure',   'PC / Steam',      '2025-04-01', 'desarrollo'),
('Raices de Niebla',  'Nintendo Switch', '2025-11-12', 'planificacion'),
('Duelo de Faroles',  'Movil Android',   '2024-08-19', 'pruebas');

INSERT INTO proyecto_desarrollador (id_proyecto, id_desarrollador, horas_semana) VALUES
(1, 1, 40),   -- Space Adventure  <- Mariela
(1, 2, 30),   -- Space Adventure  <- Ignacio
(1, 4, 40),   -- Space Adventure  <- Damian
(1, 6, 20),   -- Space Adventure  <- Tomas
(2, 3, 35),   -- Raices de Niebla <- Sofia
(2, 5, 25),   -- Raices de Niebla <- Renata
(3, 1, 10),   -- Duelo de Faroles <- Mariela
(3, 3, 15);   -- Duelo de Faroles <- Sofia

INSERT INTO tareas (titulo, estado, prioridad, fecha_limite, id_proyecto, id_desarrollador) VALUES
('Implementar salto con impulso variable', 'completada',  'alta',  '2026-07-10', 1, 1),
('Corregir colisiones en la nave madre',   'pendiente',   'alta',  '2026-10-02', 1, 1),
('Modelar asteroides de fondo',            'en_progreso', 'media', '2026-10-15', 1, 2),
('Optimizar carga de escenas',             'pendiente',   'alta',  '2026-09-30', 1, 4),
('Plan de pruebas del nivel 3',            'pendiente',   'media', '2026-10-20', 1, 6),
('Bocetar el bosque de niebla',            'en_progreso', 'media', '2026-11-05', 2, 3),
('Grabar ambiente de lluvia',              'pendiente',   'baja',  '2026-11-18', 2, 5),
('Musica del menu principal',              'completada',  'media', '2026-08-22', 2, 5),
('Ajustar dificultad de los faroles',      'pendiente',   'media', '2026-09-28', 3, 3),
('Reparar guardado en la nube',            'en_progreso', 'alta',  '2026-10-08', 3, 1);

/* ============================================================================
   4) CONSULTAS SOLICITADAS
   ============================================================================ */

-- Consulta 1: mostrar todos los desarrolladores asignados al proyecto "Space Adventure".
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

-- Consulta 2: listar todas las tareas pendientes.
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

-- Consulta 3: contar cuantas tareas tiene asignado cada desarrollador.
-- Se usa LEFT JOIN para que tambien aparezcan los que tienen 0 tareas.
SELECT CONCAT(d.nombres, ' ', d.apellidos) AS desarrollador,
       d.rol,
       COUNT(t.id_tarea) AS total_tareas
FROM desarrolladores AS d
LEFT JOIN tareas AS t ON t.id_desarrollador = d.id_desarrollador
GROUP BY d.id_desarrollador, desarrollador, d.rol
ORDER BY total_tareas DESC, desarrollador;

-- Consulta 4: mostrar los proyectos y la cantidad de desarrolladores que participan en cada uno.
SELECT p.id_proyecto,
       p.nombre AS proyecto,
       p.plataforma,
       p.estado,
       COUNT(pd.id_desarrollador) AS total_desarrolladores
FROM proyectos AS p
LEFT JOIN proyecto_desarrollador AS pd ON pd.id_proyecto = p.id_proyecto
GROUP BY p.id_proyecto, p.nombre, p.plataforma, p.estado
ORDER BY total_desarrolladores DESC;


-- ####################################################################
-- ###  ORIGEN: sql/03_biblioteca_multimedia.sql
-- ####################################################################

/* ============================================================================
   TAREA 1 - BASES DE DATOS  |  EJERCICIO 3: BIBLIOTECA MULTIMEDIA
   ----------------------------------------------------------------------------
   Caso: La mediateca "Sala Lumiere" desea registrar la informacion de sus
         peliculas y de los directores que las dirigieron.
   Relacion: directores 1:N peliculas
   ============================================================================ */

DROP DATABASE IF EXISTS ej3_sala_lumiere;
CREATE DATABASE ej3_sala_lumiere
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE ej3_sala_lumiere;

-- ----------------------------------------------------------------------------
-- DDL: tablas
-- ----------------------------------------------------------------------------
CREATE TABLE directores (
    id_director     INT         NOT NULL AUTO_INCREMENT,
    nombres         VARCHAR(60) NOT NULL,
    apellidos       VARCHAR(60) NOT NULL,
    nacionalidad    VARCHAR(40) NOT NULL,
    anio_nacimiento SMALLINT    NOT NULL,
    PRIMARY KEY (id_director)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE peliculas (
    id_pelicula      INT          NOT NULL AUTO_INCREMENT,
    titulo           VARCHAR(120) NOT NULL,
    genero           VARCHAR(40)  NOT NULL,
    anio_estreno     SMALLINT     NOT NULL,
    duracion_minutos SMALLINT     NOT NULL,
    idioma           VARCHAR(30)  NOT NULL DEFAULT 'Espanol',
    copias_disponibles TINYINT    NOT NULL DEFAULT 1,
    id_director      INT          NOT NULL,
    PRIMARY KEY (id_pelicula),
    KEY idx_peliculas_genero (genero),
    CONSTRAINT fk_peliculas_director
        FOREIGN KEY (id_director) REFERENCES directores (id_director)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- DML: datos de prueba (titulos y directores ficticios de la mediateca)
-- ----------------------------------------------------------------------------
INSERT INTO directores (nombres, apellidos, nacionalidad, anio_nacimiento) VALUES
('Helena',  'Matamoros', 'Ecuatoriana', 1978),
('Bruno',   'Salcedo',   'Chilena',     1965),
('Amara',   'Okonkwo',   'Nigeriana',   1984),
('Teodoro', 'Rivas',     'Mexicana',    1971),
('Nadia',   'Kirilenko', 'Ucraniana',   1990);

INSERT INTO peliculas (titulo, genero, anio_estreno, duracion_minutos, idioma, copias_disponibles, id_director) VALUES
('El ultimo tren a Latacunga', 'Drama',            2019, 112, 'Espanol', 3, 1),
('Cenizas de sal',             'Drama',            2022,  98, 'Espanol', 2, 1),
('La ruta del condor',         'Documental',       2021, 84,  'Espanol', 4, 2),
('Nieve sobre el desierto',    'Ciencia ficcion',  2023, 131, 'Ingles',  2, 2),
('Kilometro cero',             'Accion',           2018, 105, 'Espanol', 5, 4),
('Lagos de neon',              'Ciencia ficcion',  2024, 118, 'Ingles',  1, 3),
('La casa de las abuelas',     'Comedia',          2020,  92, 'Espanol', 3, 4),
('Ojos de tormenta',           'Suspenso',         2025, 107, 'Ingles',  2, 3),
('Invierno en Odesa',          'Drama',            2024, 124, 'Ucraniano', 1, 5),
('Raiz cuadrada del miedo',    'Suspenso',         2016,  96, 'Espanol', 2, 5),
('Manifiesto de papel',        'Documental',       2026,  78, 'Espanol', 1, 1),
('Orbita baja',                'Ciencia ficcion',  2020, 140, 'Ingles',  2, 2);

/* ============================================================================
   CONSULTAS SOLICITADAS
   ============================================================================ */

-- Consulta 1: mostrar todas las peliculas (con el director que las dirigio).
SELECT p.id_pelicula,
       p.titulo,
       p.genero,
       p.anio_estreno,
       p.duracion_minutos,
       CONCAT(d.nombres, ' ', d.apellidos) AS director
FROM peliculas AS p
INNER JOIN directores AS d ON d.id_director = p.id_director
ORDER BY p.titulo;

-- Consulta 2: mostrar las peliculas estrenadas despues de 2020.
SELECT p.id_pelicula,
       p.titulo,
       p.genero,
       p.anio_estreno,
       CONCAT(d.nombres, ' ', d.apellidos) AS director
FROM peliculas AS p
INNER JOIN directores AS d ON d.id_director = p.id_director
WHERE p.anio_estreno > 2020
ORDER BY p.anio_estreno DESC, p.titulo;

-- Consulta 3: mostrar las peliculas de un genero determinado (Ciencia ficcion).
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


-- ####################################################################
-- ###  ORIGEN: sql/04_gestion_estudiantes.sql
-- ####################################################################

/* ============================================================================
   TAREA 1 - BASES DE DATOS  |  EJERCICIO 4: GESTION DE ESTUDIANTES
   ----------------------------------------------------------------------------
   Caso: El "Instituto Superior Antares" necesita administrar a sus estudiantes
         y las matriculas que realizan cada periodo academico.
   Relaciones:
     - carreras    1:N estudiantes
     - estudiantes 1:N matriculas
   ============================================================================ */

DROP DATABASE IF EXISTS ej4_instituto_antares;
CREATE DATABASE ej4_instituto_antares
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE ej4_instituto_antares;

-- ----------------------------------------------------------------------------
-- DDL: tablas
-- ----------------------------------------------------------------------------
CREATE TABLE carreras (
    id_carrera         INT         NOT NULL AUTO_INCREMENT,
    nombre             VARCHAR(80) NOT NULL,
    modalidad          ENUM('presencial','virtual','hibrida') NOT NULL DEFAULT 'presencial',
    duracion_semestres TINYINT     NOT NULL,
    PRIMARY KEY (id_carrera),
    UNIQUE KEY uq_carreras_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE estudiantes (
    id_estudiante    INT         NOT NULL AUTO_INCREMENT,
    cedula           VARCHAR(15) NOT NULL,
    nombres          VARCHAR(60) NOT NULL,
    apellidos        VARCHAR(60) NOT NULL,
    fecha_nacimiento DATE        NOT NULL,
    correo           VARCHAR(90) NOT NULL,
    telefono         VARCHAR(15) NULL,
    ciudad           VARCHAR(40) NOT NULL,
    id_carrera       INT         NOT NULL,
    PRIMARY KEY (id_estudiante),
    UNIQUE KEY uq_estudiantes_cedula (cedula),
    UNIQUE KEY uq_estudiantes_correo (correo),
    CONSTRAINT fk_estudiantes_carrera
        FOREIGN KEY (id_carrera) REFERENCES carreras (id_carrera)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE matriculas (
    id_matricula  INT         NOT NULL AUTO_INCREMENT,
    id_estudiante INT         NOT NULL,
    periodo       VARCHAR(15) NOT NULL,          -- ejemplo: 2026-2S
    fecha         DATE        NOT NULL,
    estado        ENUM('registrada','pagada','anulada') NOT NULL DEFAULT 'registrada',
    PRIMARY KEY (id_matricula),
    UNIQUE KEY uq_matricula_estudiante_periodo (id_estudiante, periodo),
    CONSTRAINT fk_matriculas_estudiante
        FOREIGN KEY (id_estudiante) REFERENCES estudiantes (id_estudiante)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- DML: datos de prueba
-- ----------------------------------------------------------------------------
INSERT INTO carreras (nombre, modalidad, duracion_semestres) VALUES
('Desarrollo de software',      'presencial', 5),
('Diseno multimedia',           'hibrida',    5),
('Redes y telecomunicaciones',  'presencial', 6),
('Marketing digital',           'virtual',    4);

INSERT INTO estudiantes (cedula, nombres, apellidos, fecha_nacimiento, correo, telefono, ciudad, id_carrera) VALUES
('0923451871', 'Andres',   'Pilataxi',  '2004-02-18', 'andres.pilataxi@antares.edu',  '0991234567', 'Quito',      1),
('0918273645', 'Camila',   'Verdugo',   '2003-11-05', 'camila.verdugo@antares.edu',   '0987654321', 'Guayaquil',  1),
('1725489630', 'Joel',     'Naranjo',   '2009-06-30', 'joel.naranjo@antares.edu',     '0965432178', 'Ambato',     1),
('1712398745', 'Valentina','Sarmiento', '2002-09-12', 'valentina.sarmiento@antares.edu','0978451236','Cuenca',    2),
('0604512398', 'Mateo',    'Chimbo',    '2008-12-24', 'mateo.chimbo@antares.edu',     '0954123698', 'Riobamba',   2),
('1309871245', 'Dayana',   'Zambrano',  '2001-04-03', 'dayana.zambrano@antares.edu',  '0993216547', 'Manta',      3),
('0801234567', 'Kevin',    'Caicedo',   '2005-08-21', 'kevin.caicedo@antares.edu',    '0986541237', 'Esmeraldas', 3),
('1104567823', 'Brenda',   'Jaramillo', '2000-01-29', 'brenda.jaramillo@antares.edu', '0971234589', 'Loja',       4),
('0703215698', 'Ismael',   'Tandazo',   '2007-10-16', 'ismael.tandazo@antares.edu',   '0968745123', 'Machala',    4),
('1003698521', 'Fernanda', 'Imbaquingo','1999-05-07', 'fernanda.imbaquingo@antares.edu','0995874123','Ibarra',    1);

INSERT INTO matriculas (id_estudiante, periodo, fecha, estado) VALUES
( 1, '2026-2S', '2026-09-01', 'pagada'),
( 2, '2026-2S', '2026-09-01', 'pagada'),
( 3, '2026-2S', '2026-09-02', 'registrada'),
( 4, '2026-2S', '2026-09-02', 'pagada'),
( 5, '2026-2S', '2026-09-03', 'registrada'),
( 6, '2026-2S', '2026-09-03', 'pagada'),
( 7, '2026-2S', '2026-09-04', 'anulada'),
( 8, '2026-2S', '2026-09-04', 'pagada'),
( 9, '2026-2S', '2026-09-05', 'registrada'),
(10, '2026-2S', '2026-09-05', 'pagada');

/* ============================================================================
   CONSULTAS SOLICITADAS
   ============================================================================ */

-- Consulta 1: mostrar todos los estudiantes (con su carrera).
SELECT e.id_estudiante,
       e.cedula,
       CONCAT(e.apellidos, ' ', e.nombres) AS estudiante,
       e.fecha_nacimiento,
       e.ciudad,
       c.nombre AS carrera
FROM estudiantes AS e
INNER JOIN carreras AS c ON c.id_carrera = e.id_carrera
ORDER BY e.apellidos;

-- Consulta 2: mostrar los estudiantes mayores de 18 anios.
-- TIMESTAMPDIFF calcula la edad exacta a partir de la fecha de nacimiento.
SELECT e.id_estudiante,
       CONCAT(e.apellidos, ' ', e.nombres) AS estudiante,
       e.fecha_nacimiento,
       TIMESTAMPDIFF(YEAR, e.fecha_nacimiento, CURDATE()) AS edad,
       c.nombre AS carrera
FROM estudiantes AS e
INNER JOIN carreras AS c ON c.id_carrera = e.id_carrera
WHERE TIMESTAMPDIFF(YEAR, e.fecha_nacimiento, CURDATE()) > 18
ORDER BY edad DESC;

-- Consulta 3: mostrar los estudiantes de una carrera especifica.
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


-- ####################################################################
-- ###  ORIGEN: sql/05_torneo_esports.sql
-- ####################################################################

/* ============================================================================
   TAREA 1 - BASES DE DATOS  |  EJERCICIO 5: TORNEO DE ESPORTS
   ----------------------------------------------------------------------------
   Caso: La organizacion "Liga Andina de eSports" administra equipos, jugadores
         y torneos. Necesita controlar que jugadores pertenecen a cada equipo y
         que equipos participan en cada torneo.
   Relaciones:
     - equipos 1:N jugadores
     - torneos N:M equipos -> tabla puente torneo_equipo
   ============================================================================ */

DROP DATABASE IF EXISTS ej5_liga_andina_esports;
CREATE DATABASE ej5_liga_andina_esports
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE ej5_liga_andina_esports;

-- ----------------------------------------------------------------------------
-- DDL: tablas
-- ----------------------------------------------------------------------------
CREATE TABLE equipos (
    id_equipo       INT         NOT NULL AUTO_INCREMENT,
    nombre          VARCHAR(60) NOT NULL,
    ciudad          VARCHAR(40) NOT NULL,
    fecha_fundacion DATE        NOT NULL,
    entrenador      VARCHAR(80) NOT NULL,
    PRIMARY KEY (id_equipo),
    UNIQUE KEY uq_equipos_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE jugadores (
    id_jugador   INT         NOT NULL AUTO_INCREMENT,
    nick         VARCHAR(30) NOT NULL,
    nombre_real  VARCHAR(80) NOT NULL,
    rol          VARCHAR(30) NOT NULL,
    edad         TINYINT     NOT NULL,
    id_equipo    INT         NOT NULL,
    PRIMARY KEY (id_jugador),
    UNIQUE KEY uq_jugadores_nick (nick),
    CONSTRAINT fk_jugadores_equipo
        FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE torneos (
    id_torneo    INT           NOT NULL AUTO_INCREMENT,
    nombre       VARCHAR(80)   NOT NULL,
    juego        VARCHAR(50)   NOT NULL,
    fecha_inicio DATE          NOT NULL,
    fecha_fin    DATE          NOT NULL,
    sede         VARCHAR(60)   NOT NULL,
    premio_usd   DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_torneo),
    UNIQUE KEY uq_torneos_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla puente: un torneo tiene varios equipos y un equipo juega varios torneos.
CREATE TABLE torneo_equipo (
    id_torneo       INT     NOT NULL,
    id_equipo       INT     NOT NULL,
    grupo           CHAR(1) NOT NULL,
    posicion_final  TINYINT NULL,     -- NULL mientras el torneo no termina
    PRIMARY KEY (id_torneo, id_equipo),
    CONSTRAINT fk_te_torneo
        FOREIGN KEY (id_torneo) REFERENCES torneos (id_torneo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_te_equipo
        FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- DML: datos de prueba
-- ----------------------------------------------------------------------------
INSERT INTO equipos (nombre, ciudad, fecha_fundacion, entrenador) VALUES
('Dragones Digitales', 'Quito',      '2019-03-14', 'Rodrigo Maldonado'),
('Pumas Binarios',     'Guayaquil',  '2020-07-25', 'Silvia Arteaga'),
('Kondor Esports',     'Cuenca',     '2018-11-02', 'Jonathan Peralta'),
('Neon Manabi',        'Manta',      '2021-05-19', 'Karla Mendoza');

INSERT INTO jugadores (nick, nombre_real, rol, edad, id_equipo) VALUES
('drk_flame',   'Alejandro Salazar',  'Carry',      22, 1),
('valkiria99',  'Michelle Andrade',   'Support',    24, 1),
('n0ct4',       'Bryan Montenegro',   'Mid laner',  20, 1),
('ceniza',      'Paola Trujillo',     'Offlaner',   23, 1),
('ironpaw',     'Steven Ochoa',       'Jungla',     21, 1),
('puma_zero',   'Erick Bravo',        'Carry',      19, 2),
('lince_azul',  'Nicole Palacios',    'Support',    25, 2),
('mecha_gye',   'Christian Solorzano','Mid laner',  22, 2),
('kondorx',     'Luis Cabrera',       'Carry',      26, 3),
('andina',      'Jazmin Uyaguari',    'Support',    23, 3),
('cuenca_bot',  'Diego Vintimilla',   'Jungla',     20, 3),
('neon_wave',   'Anthony Cedeno',     'Carry',      18, 4),
('marea_alta',  'Melany Pincay',      'Support',    21, 4);

INSERT INTO torneos (nombre, juego, fecha_inicio, fecha_fin, sede, premio_usd) VALUES
('Copa Andina Invierno', 'League of Legends', '2025-06-10', '2025-06-22', 'Quito',     8000.00),
('Clasico Digital',      'Valorant',          '2026-03-05', '2026-03-15', 'Guayaquil',12000.00),
('Altura Open',          'Dota 2',            '2026-08-12', '2026-08-24', 'Cuenca',   15000.00),
('Costa Showdown',       'Valorant',          '2026-11-07', '2026-11-16', 'Manta',     9500.00),
('Liga Sur Masters',     'League of Legends', '2027-02-01', '2027-02-12', 'Loja',     20000.00);

INSERT INTO torneo_equipo (id_torneo, id_equipo, grupo, posicion_final) VALUES
(1, 1, 'A', 2),
(1, 3, 'A', 1),
(2, 1, 'A', 1),
(2, 2, 'A', 3),
(2, 4, 'B', 2),
(3, 1, 'B', 4),
(3, 2, 'A', 1),
(3, 3, 'A', 2),
(4, 2, 'A', NULL),
(4, 4, 'A', NULL),
(5, 1, 'A', NULL),
(5, 3, 'B', NULL);

/* ============================================================================
   CONSULTAS SOLICITADAS
   ============================================================================ */

-- Consulta 1: mostrar los jugadores del equipo "Dragones Digitales".
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

-- Consulta 2: listar los torneos programados para este anio.
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

-- Consulta 3: contar cuantos jugadores tiene cada equipo.
SELECT e.id_equipo,
       e.nombre AS equipo,
       e.ciudad,
       COUNT(j.id_jugador) AS total_jugadores
FROM equipos AS e
LEFT JOIN jugadores AS j ON j.id_equipo = e.id_equipo
GROUP BY e.id_equipo, e.nombre, e.ciudad
ORDER BY total_jugadores DESC, equipo;

-- Consulta 4: mostrar que equipos participan en cada torneo.
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

-- Variante compacta de la consulta 4: un renglon por torneo con la lista de equipos.
SELECT t.nombre AS torneo,
       t.juego,
       COUNT(te.id_equipo)              AS total_equipos,
       GROUP_CONCAT(e.nombre ORDER BY e.nombre SEPARATOR ', ') AS equipos_participantes
FROM torneos AS t
LEFT JOIN torneo_equipo AS te ON te.id_torneo = t.id_torneo
LEFT JOIN equipos AS e        ON e.id_equipo  = te.id_equipo
GROUP BY t.id_torneo, t.nombre, t.juego
ORDER BY t.fecha_inicio;

